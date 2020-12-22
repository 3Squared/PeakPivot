//
//  PivotBuilder.swift
//  Bugfender-CSV-Viewer
//
//  Created by Luke Stringer on 31/12/2019.
//  Copyright © 2019 3Squared Ltd. All rights reserved.
//

import Foundation

/// Namespace for all the kinds of PivotBuilder
enum PivotBuilder {
    
    /// A user defined pivot builder
    class Custom: BuildPivot {
        var table: Table?
        
        var fields: [FieldName]?
        
        var percentagesEnabled = true
        
        var zeroRowsEnabled = true
        
        var sortDescriptor = BuildPivotDescriptor.byTitle(ascending: true)
        
        var filters: [BuildPivotFilter]?
    }
    
    // TODO: Add unit tests for these templates
    /// Pre-defined temapltes for building pivots
    enum Template {
        
        struct CompanyByAppVersion: BuildPivot {
            
            var table: Table? = nil
            
            var fields: [FieldName]? = [
                "Company Name",
                "App Version"
            ]
            
            var percentagesEnabled = true
            
            var zeroRowsEnabled = false
            
            var sortDescriptor = BuildPivotDescriptor.byValue(ascending: false)
            
            var filters: [BuildPivotFilter]? = [BuildPivotFilter(fieldName: "Company Name", include: [
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
