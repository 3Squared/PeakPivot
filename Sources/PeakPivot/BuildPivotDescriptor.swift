//
//  BuildPivotDescriptor.swift
//  PeakPivot
//
//  Created by Luke Stringer on 27/05/2020.
//  Copyright © 2020 Luke Stringer. All rights reserved.
//

import Foundation

/// Describes how to sort a pivot table
public enum BuildPivotDescriptor: Equatable, CaseIterable {
    case byTitle(ascending: Bool = true)
    case byCount(ascending: Bool = true)
    case bySum(ascending: Bool = true)
    
    public static var allCases: [BuildPivotDescriptor] {
        return [
            .byTitle(ascending: true),
            .byTitle(ascending: false),
            .byCount(ascending: true),
            .byCount(ascending: false),
            .bySum(ascending: true),
            .bySum(ascending: false)
        ]
    }
}
