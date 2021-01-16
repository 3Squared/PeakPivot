//
//  PivotBuilder.swift
//  PeakPivot
//
//  Created by Luke Stringer on 31/12/2019.
//  Copyright © 2019 3Squared Ltd. All rights reserved.
//

import Foundation

/// Namespace for all the kinds of PivotBuilder
public enum PivotBuilder {
    
    /// A user defined pivot builder
    open class Custom: BuildPivot {
        
        public var table: Table?
        
        public var fields: [FieldName]?
        
        public var percentagesEnabled = true
        
        public var sumsEnabled = false
        
        public var zeroRowsEnabled = true
        
        public var sortDescriptor = BuildPivotDescriptor.byTitle(ascending: true)
        
        public var filters: [BuildPivotFilter]?
        
        public init() {}
    }

}
