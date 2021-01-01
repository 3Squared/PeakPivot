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
        
        public var zeroRowsEnabled = true
        
        public var sortDescriptor = BuildPivotDescriptor.byTitle(ascending: true)
        
        public var filters: [BuildPivotFilter]?
        
        public init() {}
    }
    
    // TODO: Add unit tests for these templates
    /// Pre-defined temapltes for building pivots
    public enum Template {
        
        public struct CompanyByAppVersion: BuildPivot {
            
            public var table: Table? = nil
            
            public var fields: [FieldName]? = [
                "Company Name",
                "App Version"
            ]
            
            public var percentagesEnabled = true
            
            public var zeroRowsEnabled = false
            
            public var sortDescriptor = BuildPivotDescriptor.byValue(ascending: false)
            
            public var filters: [BuildPivotFilter]? = [BuildPivotFilter(fieldName: "Company Name", include: [
                "Colas Rail Ltd",
                "DWS Demo",
                "Freightliner Ltd",
                "GB Railfreight",
                "LNER",
                "Network Rail",
                "Wabtec Rail Ltd",
            ])]
        }
    }

}
