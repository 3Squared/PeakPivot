//
//  BuildPivot.swift
//  PeakPivot
//
//  Created by Luke Stringer on 27/05/2020.
//  Copyright © 2020 Luke Stringer. All rights reserved.
//

import Foundation

/// Build a pivot table given some input data
public protocol BuildPivot {
    /// The table of data to be pivotted
    var table: Table? { get set }
    
    /// The field names (columns) in the table to pivot around
    var fields: [FieldName]?  { get set }
    
    /// Whether to compute percentages or not
    var percentagesEnabled: Bool { get set }
    
    var sumsEnabled: Bool  { get set }
    
    /// Whether to include rows that have zero values
    var zeroRowsEnabled: Bool  { get set }
    
    /// Descriptor for sorting the pivot table
    var sortDescriptor: BuildPivotDescriptor  { get set }
    
    /// The filters to apply to the pivot table
    var filters: [BuildPivotFilter]?  { get set }
    
    func build() throws -> Pivot
}

/// Errors generated during the pivot building process
public enum BuildPivotError: Error {
    case noTable
    case noFields
    case noOutput
}

public extension BuildPivot {

    func build() throws -> Pivot {
        guard let table = table else {
                throw BuildPivotError.noTable
            }
            
            guard let fields = fields else {
                throw BuildPivotError.noFields
            }
            
            // Replace any empty strings
            let tableWithBlanks = replaceEmptyStrings(in: table)
            
            // Generate PivotRows without percentages
            guard let rowsWithoutPercentages = generatePivotRows(from: tableWithBlanks, fieldNames: fields, level: 0) else {
                throw BuildPivotError.noOutput
            }
            
            
            // Sum up counts for all top level rows to get the overall total
            let total = rowsWithoutPercentages.filter { $0.level == 0 }.reduce(0, {$0 + $1.value.count})
            
            let rows: [PivotRow] = {
                
                guard percentagesEnabled else { return rowsWithoutPercentages }
                
                // Add percentages
                return generatePivotRowsWithPercentages(for: rowsWithoutPercentages, total: total)
            }()
            
        
            // Sort
            let sorted = rows.sorted(using: sortDescriptor)
            
            // Generate FilterFields
            let filterFields = generateFilterFields(from: tableWithBlanks, fields: fields)
            
            return Pivot(rows: sorted, filterFields: filterFields, total: total)
    }
}

fileprivate extension BuildPivot {
    
    /// Generate pivot rows from a table, recursing down each level as defined in the fieldNames
    /// - Parameters:
    ///   - table: The table of data (i.e. from a CSV)
    ///   - fieldNames: The field names to pivot around. The order of these fields names determines the order in which this function recurses through the levels
    ///   - level: The current level of the recursion. Start calling this function at level 0.
    func generatePivotRows(from table: [TableRow], fieldNames: [FieldName], level: Int) -> [PivotRow]? {
        
        // Base case - where we no longer have anymore fieldNames to process
        guard let fieldName = fieldNames.first else { return nil }
        
        // Group rows according to their fieldName value
        var fieldNameGroups = [FieldValue: [TableRow]]()
        for row in table {
            guard let fieldValue = row[fieldName] else { continue }
            
            // If there are filters skip any rows that are not included in the filters
            if let filters = self.filters {
                
                let matchingFilters = filters.filter { filter -> Bool in
                    return fieldName == filter.fieldName && !filter.include.contains(fieldValue)
                }
                
                if matchingFilters.count > 0 {
                    continue
                }
            }
            
            var newRows = [row]
            if let currentRows = fieldNameGroups[fieldValue] {
                newRows += currentRows
            }
            fieldNameGroups[fieldValue] = newRows
        }
        
        // Remove the current field names so we only process the remaining ones on the next recurse
        let nextFieldNames = Array(fieldNames[1..<fieldNames.count])
        
        // Process groups into PivotRows
        let pivotRows = fieldNameGroups.compactMap { group -> PivotRow? in
            let (fieldValue, rows) = group
            
            // Recurse through the next field names to get the sub rows
            let subRows = generatePivotRows(from: rows, fieldNames: nextFieldNames, level:level+1)
            
            // Compute the count
            let count: Int = {
                // If we have subrows then the count is the sum of all the subrow values
                if let subRows = subRows {
                    return subRows.reduce(0) {  $0 + $1.value.count }
                }
                
                // If we don't have subrows the count is equal to the number of rows for the group
                return rows.count
            }()
            
 
            // Compute the sum
            // For this to work the value of the fields must be a number
            let sum: Float? = sumsEnabled ? {
                
                // If there are subrows then add up all the sums to get the overal sum for the parent row
                if let theSubrows = subRows {
                    
                    return theSubrows.reduce(0, { inital, row -> Float in
                        
                        if let rowFloat = Float(row.title) {
                            return inital + (rowFloat * Float(row.value.count))
                        }
                        
                        return inital
                    })
                }
                
                else {
                    return Float(fieldValue).flatMap { $0 * Float(count) } ?? nil
                }
            }() : nil
            
            // Remove any rows with zero if not enabled
            let keepThisRow = zeroRowsEnabled || !zeroRowsEnabled && count > 0
            guard keepThisRow else { return nil }
            
            // Percentage is nil at this point as we need the overall counts
            let percentage: Float? = nil
            
            // Use nil rather than empty array for sub rows
            let subRowsOrNil = subRows?.count == 0 ? nil : subRows
            
            // Create the PivotRow for the group and it's sub rows
            return PivotRow(level: level, title: fieldValue, value: PivotRow.Value(count: count, sum: sum, percentage: percentage), subRows: subRowsOrNil)
        }
        
       return pivotRows
    }
    
    
    /// Add percentages to Pivot Rows
    /// - Parameters:
    ///   - rows: PivotRows without percentages to generate percentages for
    ///   - total: The overall total to compute percentages from
    func generatePivotRowsWithPercentages(for rows: [PivotRow], total: Int) -> [PivotRow] {
        
         return rows.map { row -> PivotRow in
             let count = row.value.count
             let percentage = Float(count) / Float(total)
             
             let subRowsWithPercentages = row.subRows.flatMap { generatePivotRowsWithPercentages(for: $0, total: total) } ?? nil
             
             return PivotRow(level: row.level, title: row.title, value: PivotRow.Value(count: count, sum: nil, percentage: percentage), subRows: subRowsWithPercentages)
         }
         

     }
    
    func generateFilterFields(from table: Table, fields: [FieldName]) -> [FilterField] {
        
        return fields.map { fieldName -> FilterField in
            let values = table.compactMap { $0[fieldName] }
            let uniqieValues = Array(Set(values))
            let sortedValues = uniqieValues.sorted { lhs, rhs -> Bool in
                return String.compareAsTitle(lhs: lhs, rhs: rhs, ascending: true)
            }
            return FilterField(name: fieldName, values: sortedValues)
        }
    }
    
    
    /// Replaces empty string values in the table with Blanks. Blanks are understood by the pivot generation code, empty strings are not
    /// - Parameter table: The table containing empty strings
    private func replaceEmptyStrings(in table: Table) -> Table {
        return table.map({ row -> TableRow in
            var newRow = row
            for (key, value) in newRow {
                if value == "" {
                    newRow[key] = Blank
                }
            }
            return newRow
        })
        
    }
}
