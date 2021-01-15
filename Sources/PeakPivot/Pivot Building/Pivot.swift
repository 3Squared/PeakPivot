//
//  Pivot.swift
//  PeakPivot
//
//  Created by Luke Stringer on 31/12/2019.
//  Copyright © 2019 3Squared Ltd. All rights reserved.
//

import Foundation

/// Output from processessing a Table into a Pivot
public struct Pivot {
    
    /// The rows in the Pivot
    public let rows: [PivotRow]
    
    /// The filters applied on the Fields
    public  let filterFields: [FilterField]
    
    /// Total number of rows (including sub-rows) in the Pivot
    public let total: Int
}

/// A Ro in a Pivot
public struct PivotRow {
    
    public struct Value {
        
        /// The count of the row
        public let count: Int
        
        /// The precentage value calculated against the rest of the pivot
        public let percentage: Float?
    }
    
    /// The level of indentation, indexed starting at 0. A Pivot created with n fields will have n levels of indentation.
    public let level: Int
    
    /// The title
    public let title: String
    
    /// The value
    public  let value: Value
    
    /// The subrows at lower level of indentation
    public let subRows: [PivotRow]?
}

/// A field in a Pivot (corresponds to a column in the source CSV) that can be filtered to be included or excluded
public struct FilterField {
    
    /// The name of the field
    public let name: FieldName
    
    /// The values in the field to be included or excluded
    public let values: [FieldValue]
}

extension FilterField: Equatable {}

extension FilterField: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        let valuesText = values.joined(separator: ", ")
        return "\(name)\n\t| \(valuesText)\n"
    }
}

extension PivotRow.Value: Equatable { }

extension PivotRow.Value: Comparable {
    public static func < (lhs: PivotRow.Value, rhs: PivotRow.Value) -> Bool {
        return lhs.count < rhs.count
    }
    
    
}

extension PivotRow: Equatable {}

public extension String {
    static func compareAsTitle(lhs: String, rhs: String, ascending: Bool = true) -> Bool {
        if lhs == Blank.description {
            return false
        }
        else if rhs == Blank.description {
            return true
        }
        else {
            return ascending ? lhs < rhs : lhs > rhs
        }
    }
}

extension PivotRow: Comparable {
    
    public static func < (lhs: PivotRow, rhs: PivotRow) -> Bool {
        return compareByTitle(lhs: lhs, rhs: rhs)
    }
    
    static func compareByTitle(lhs: PivotRow, rhs: PivotRow, ascending: Bool = true)  -> Bool {
        return String.compareAsTitle(lhs: lhs.title, rhs: rhs.title, ascending: ascending)
    }
    
    static func compareByValue(lhs: PivotRow, rhs: PivotRow, ascending: Bool = true)  -> Bool {
        let lhsValue = lhs.value
        let rhsValue = rhs.value
        
        if lhsValue == rhsValue {
            return compareByTitle(lhs: lhs, rhs: rhs)
        }
        return ascending ? lhsValue < rhsValue : lhsValue > rhsValue
    }
}

public extension Array where Element == PivotRow {
    func sortedByTitle(ascending: Bool = true) -> [Element] {
        
        let thisLevel = sorted { PivotRow.compareByTitle(lhs: $0, rhs: $1, ascending: ascending) }
        
        return thisLevel.map { row -> PivotRow in
            let nextLevel = row.subRows?.sortedByTitle(ascending: ascending)
            return PivotRow(level: row.level, title: row.title, value: row.value, subRows: nextLevel)
        }
    }
    
    func sortedByValue(ascending: Bool = true) ->  [Element]{
        let thisLevel = sorted { PivotRow.compareByValue(lhs: $0, rhs: $1, ascending: ascending) }
        
        return thisLevel.map { row -> PivotRow in
            let nextLevel = row.subRows?.sortedByValue(ascending: ascending)
            return PivotRow(level: row.level, title: row.title, value: row.value, subRows: nextLevel)
        }
    }
    
}

extension PivotRow: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        
        let indent = String.init(repeating: "\t", count: level)
        let rowDescription = "\n\(indent)\(level)| \(title) : \(value), [sub:\(subRows?.count ?? 0)]"
        
        if let theseSubRows = subRows, theseSubRows.count > 0 {
            let subRowDescriptions = theseSubRows
                .map { $0.debugDescription }
                .joined()
            return "\(rowDescription)\(subRowDescriptions)"
        }
        else {
            return rowDescription
        }
    }
    
    
    
}

public extension Array where Element == PivotRow {
    var exportDescription: String {
        return map { row -> String in
            let pipe = row.level > 0 ? "|" : ""
            let indent = String.init(repeating: "\t", count: row.level) + pipe
            let percentage = row.value.percentage.flatMap { ", \(Int($0 * 100))%" } ?? ""
            let rowDescription = "\n\(indent) \(row.title) : \(row.value.count)\(percentage)"
            
            if let theseSubRows = row.subRows, theseSubRows.count > 0 {
                let subRowDescriptions = theseSubRows
                    .map { $0.debugDescription }
                    .joined()
                return "\(rowDescription)\(subRowDescriptions)"
            }
            else {
                return rowDescription
            }
        }.joined(separator: "")
    }
    
}


public extension Array where Element == PivotRow {
    
    func sorted(using descriptor: BuildPivotDescriptor) -> [PivotRow] {
        switch descriptor {
        case .byTitle(let ascending):
            return sortedByTitle(ascending: ascending)
        case .byValue(let ascending):
            return sortedByValue(ascending: ascending)
        }
    }
}
