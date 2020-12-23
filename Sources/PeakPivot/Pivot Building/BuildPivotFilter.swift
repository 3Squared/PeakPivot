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
    
    /// The values of the field name to include
    public let include: [FieldValue]
    
    public init(fieldName: FieldName, include: [FieldName]) {
        self.fieldName = fieldName
        self.include = include
    }
}
