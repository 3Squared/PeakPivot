//
//  MetaTableBuilder.swift
//  Bugfender Stats
//
//  Created by Luke Stringer on 19/05/2020.
//  Copyright © 2020 Luke Stringer. All rights reserved.
//

import Foundation

class MetaTableBuilder {
    
    /// The source table to process
    var source: Table?
    
    /// The rules to apply during processing
    var rules: [MetaFieldRule]?
    
    /// Errors emitted from the builder
    enum Error: Swift.Error {
        
        /// Missing the source table so nothing to process
        case noSource
    }
    
    /// Run the builder to process the source table with the given rules
    func build() throws ->Table {
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
