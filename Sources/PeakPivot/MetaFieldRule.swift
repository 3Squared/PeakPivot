//
//  MetaFieldRule.swift
//  Bugfender Stats
//
//  Created by Luke Stringer on 19/05/2020.
//  Copyright © 2020 Luke Stringer. All rights reserved.
//

import Foundation

protocol MetaFieldRule {
    
    typealias Transformation = ((FieldValue) -> FieldValue)
    
    var sourceFieldName: FieldValue { get }
    var destinationFieldName: String { get }
    var transform: Transformation { get }
}

struct CustomMetaFieldRule: MetaFieldRule {
    
    let sourceFieldName: FieldName
    let destinationFieldName: String
    
    let transform: Transformation
}

struct iOSModelTypeRule: MetaFieldRule {
    
    let sourceFieldName: FieldValue = "Device model"
    let destinationFieldName = "iOS Model Type*"
    
    var transform: Transformation =  { name in
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

struct MajorOSVersionRule: MetaFieldRule {
    
    let sourceFieldName: FieldValue = "OS version"
    let destinationFieldName = "Major OS Version*"
    
    var transform: Transformation =  { name in
       guard
        let major = name.components(separatedBy: ".").first
            else { return "Unknown" }
        
        return major
    }
}

