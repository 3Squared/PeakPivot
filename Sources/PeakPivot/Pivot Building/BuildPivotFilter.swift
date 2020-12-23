//
//  BuildPivotFilter.swift
//  Bugfender Stats
//
//  Created by Luke Stringer on 27/05/2020.
//  Copyright © 2020 Luke Stringer. All rights reserved.
//

import Foundation

/// Describe how to filter a pivot by including only data matching certain fields
public struct BuildPivotFilter: Codable {
    /// The field name to filter on
    let fieldName: FieldName
    
    /// The values of the field name to include
    let include: [FieldValue]
}
