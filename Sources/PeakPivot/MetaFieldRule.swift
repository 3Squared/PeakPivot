//
//  MetaFieldRule.swift
//  PeakPivot
//
//  Created by Luke Stringer on 19/05/2020.
//  Copyright © 2020 Luke Stringer. All rights reserved.
//

import Foundation

/// Rule that defines how to transform a source field
public protocol MetaFieldRule {
    
    typealias Transformation = ((FieldValue) -> FieldValue)
    
    var sourceFieldName: FieldValue { get }
    var destinationFieldName: String { get }
    var transform: Transformation { get }
}

/// Concrete implementation of MetaFieldRule
public struct CustomMetaFieldRule: MetaFieldRule {
    
    public let sourceFieldName: FieldName
    public let destinationFieldName: String
    
    public let transform: Transformation
}

