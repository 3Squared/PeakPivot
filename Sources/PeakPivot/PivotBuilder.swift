//
//  PivotBuilder.swift
//  PeakPivot
//
//  Created by Luke Stringer on 31/12/2019.
//  Copyright © 2019 3Squared Ltd. All rights reserved.
//

import Foundation

/// A concrete class that implements the `BuildPivot` protocol with some defaults
open class PivotBuilder: BuildPivot {
    
    /// The table of data to be pivotted
    public var table: Table?
    
    /// The field names (columns) in the table to pivot around
    public var fields: [FieldName]?
    
    /// Whether to compute percentages or not
    public var percentagesEnabled = true
    
    /// Whether to compute sums or not
    public var sumsEnabled = false
    
    /// Whether to include rows that have zero values
    public var zeroRowsEnabled = true
    
    /// Descriptor for sorting the pivot table
    public var sortDescriptor = BuildPivotDescriptor.byTitle(ascending: true)
    
    /// The filters to apply to the pivot table
    public var filters: [BuildPivotFilter]?
    
    public init() {}
}

