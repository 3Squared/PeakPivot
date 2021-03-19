//
//  BuildPivotFilter.swift
//  PeakPivot
//
//  Created by Luke Stringer on 27/05/2020.
//  Copyright © 2020 Luke Stringer. All rights reserved.
//

import Foundation

/// Describe how to filter a pivot by including only data matching certain fields
public struct BuildPivotFilter {
    /// The field name to filter on
    public let fieldName: FieldName
    
    /// The values of the field name to exclude
    public let exclude: [FieldValue]
    
    public init(fieldName: FieldName, exclude: [FieldName]) {
        self.fieldName = fieldName
        self.exclude = exclude
    }
}

extension BuildPivotFilter: Equatable {}
