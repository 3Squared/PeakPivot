//
//  FilterViewController+Logic.swift
//  PeakPivot
//
//  Created by Luke Stringer on 04/01/2020.
//  Copyright © 2020 3Squared Ltd. All rights reserved.
//

import Foundation
import PeakPivot

/// Logic for converting to and from Filter model types and view controller types
extension FilterViewController {
    
    /// Convert model types to view controller types
    static func selectedIndexPaths(from fields: [FilterField], filters: [BuildPivotFilter]? ) -> [IndexPath] {
        
        return fields.compactMap { filterField -> [IndexPath]? in
            
            guard let section = fields.firstIndex(of: filterField) else { return nil }
            
            return filterField.values.compactMap { value -> IndexPath? in
                guard let index = filterField.values.firstIndex(of: value) else { return nil }
    
                
                if let filtersToApply = filters {
                    let matchingFilters = filtersToApply.filter { filter -> Bool in
                        return filter.fieldName == filterField.name && !filter.include.contains(value)
                    }
                    
                    if matchingFilters.count > 0 {
                        return nil
                    }
                }
                
                // If we don't have a filter then we want to select all values by default
                return IndexPath(row: index + SelectAllRow.offset, section: section)
                
            }
        }.flatMap { $0 }
    }
    
    /// Convert view controller types to model types
    static func fieldValues(from fields: [FilterField], selectedFileName fieldName: FieldName, selectedIndexPaths indexPaths: [IndexPath]) -> [FieldValue] {
        
        return indexPaths.compactMap { indexPath -> FieldValue? in
            
            let fieldForIndexPath = fields[indexPath.section]
            guard fieldForIndexPath.name == fieldName else { return nil }
            
            return fieldForIndexPath.values[indexPath.row - SelectAllRow.offset]
        }
    }
    
    // Generate filters from the selected index paths and filters
    static func filters(from fields: [FilterField], selectedIndexPaths: [IndexPath]) -> [BuildPivotFilter] {
        
        return fields.compactMap { field -> BuildPivotFilter? in
            guard let sectionIndex = fields.firstIndex(of: field) else { return nil }
            
            let selectedRowsInSection = selectedIndexPaths.filter { return $0.section == sectionIndex }
            let valueIndicies = selectedRowsInSection.compactMap { indexPath -> Int? in
                let row = indexPath.row
                guard row != FilterViewController.SelectAllRow.index else { return nil }
                return row - FilterViewController.SelectAllRow.offset
                
            }
            let valuesToInclude = valueIndicies.compactMap { (field.values.count > $0) ? field.values[$0] : nil}
            
            guard valuesToInclude.count > 0 else { return nil }
            
            let filter = BuildPivotFilter(fieldName: field.name, include: valuesToInclude)
            
            return filter
        }
    }
    
}
