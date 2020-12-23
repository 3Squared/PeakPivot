//
//  MetaFieldRule.swift
//  Bugfender Stats
//
//  Created by Luke Stringer on 19/05/2020.
//  Copyright © 2020 Luke Stringer. All rights reserved.
//

import Foundation

public protocol MetaFieldRule {
    
    typealias Transformation = ((FieldValue) -> FieldValue)
    
    var sourceFieldName: FieldValue { get }
    var destinationFieldName: String { get }
    var transform: Transformation { get }
}

public struct CustomMetaFieldRule: MetaFieldRule {
    
    public let sourceFieldName: FieldName
    public let destinationFieldName: String
    
    public let transform: Transformation
}

public struct iOSModelTypeRule: MetaFieldRule {
    
    public let sourceFieldName: FieldValue = "Device model"
    public let destinationFieldName = "iOS Model Type*"
    
    public var transform: Transformation =  { name in
        enum DeviceType: String, CaseIterable {
            case iPad
            case iPhone
            case Simulator
            case Unknown
        }
        
        if name.contains(DeviceType.iPad.rawValue) {
            return DeviceType.iPad.rawValue
        }
        else if name.contains(DeviceType.iPhone.rawValue) {
            return DeviceType.iPhone.rawValue
        }
        else if name.contains(DeviceType.Simulator.rawValue) {
            return DeviceType.Simulator.rawValue
        }
        
        return DeviceType.Unknown.rawValue
    }
}

public struct MajorOSVersionRule: MetaFieldRule {
    
    public let sourceFieldName: FieldValue = "OS version"
    public let destinationFieldName = "Major OS Version*"
    
    public var transform: Transformation =  { name in
       guard
        let major = name.components(separatedBy: ".").first
            else { return "Unknown" }
        
        return major
    }
}

