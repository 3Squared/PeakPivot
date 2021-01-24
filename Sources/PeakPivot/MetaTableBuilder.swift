//
//  MetaTableBuilder.swift
//  PeakPivot
//
//  Created by Luke Stringer on 19/05/2020.
//  Copyright © 2020 Luke Stringer. All rights reserved.
//

import Foundation

/// Transform a source table into a meta-table using a set of rules
public class MetaTableBuilder {
    
    /// The source table to process
    public var source: Table?
    
    /// The rules to apply during processing
    public var rules: [MetaFieldRule]?
    
    /// Errors emitted from the builder
    public enum Error: Swift.Error {
        
        /// Missing the source table so nothing to process
        case noSource
    }
    
    public init() {}
    
    /// Run the builder to process the source table with the given rules
    public func build() throws ->Table {
        guard let source = source else { throw Error.noSource }
        
        // If no rules then we don't need to process the source table
        guard let rules = rules, rules.count > 0 else { return source }
        
        let metaTable = source.map { row -> TableRow in
            var rowCopy = row
            for rule in rules {
                guard let value = rowCopy[rule.sourceFieldName]  else { continue }
                let transformed = rule.transform(value)
                let newFieldName = rule.destinationFieldName
                rowCopy[newFieldName] = transformed
            }
            
            return rowCopy
        }
        
        return metaTable
    }
}
