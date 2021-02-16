//
//  MetaFieldRuleTests.swift
//  UnitTests
//
//  Created by Luke Stringer on 19/05/2020.
//  Copyright © 2020 Luke Stringer. All rights reserved.
//

import XCTest
@testable import PeakPivot

class MetaFieldRuleTests: XCTestCase {
    
    // MARK: - Tests
    
    func testDeviceTypeRule() {
        
        let source: Table = [
            ["Device model" : "Pad Air 2 (iPad5,4)"],
            ["Device model" : "iPhone 8 (iPhone10)"],
            ["Device model" : "iPhone X (iPhone10)"],
            ["Device model" : "iPhone X (iPhone10)"],
            ["Device model" : "iPad mini 2 (iPad4)"],
            ["Device model" : "iPad Pro (12.9-inch)"],
            ["Device model" : "Android Tablet"],
        ]
        
        let expected: Table = [
            ["Device model" : "Pad Air 2 (iPad5,4)", "iOS Model Type*" : "iPad"],
            ["Device model" : "iPhone 8 (iPhone10)", "iOS Model Type*" : "iPhone"],
            ["Device model" : "iPhone X (iPhone10)", "iOS Model Type*" : "iPhone"],
            ["Device model" : "iPhone X (iPhone10)", "iOS Model Type*" : "iPhone"],
            ["Device model" : "iPad mini 2 (iPad4)", "iOS Model Type*" : "iPad"],
            ["Device model" : "iPad Pro (12.9-inch)", "iOS Model Type*" : "iPad"],
            ["Device model" : "Android Tablet", "iOS Model Type*" : "Unknown"],
        ]
        
        let builder = MetaTableBuilder()
        builder.source = source
        builder.rules = [
            iOSModelTypeRule()
        ]
        
        let metaTable = try! builder.build()
        
        XCTAssertEqual(metaTable, expected)
    }
    
    func testMajorOSVersionRule() {
        
        let source: Table = [
            ["OS version" : "12.2"],
            ["OS version" : "12.3.4"],
            ["OS version" : "13.0"],
            ["OS version" : "9.1.1"],
            ["OS version" : "10.1"],
            ["OS version" : "13.0.2"],
            ["OS version" : "11.2.1"],
            ["OS version" : "Beta"],
        ]
        
        let expected: Table = [
            ["OS version" : "12.2", "Major OS Version*" : "12"],
            ["OS version" : "12.3.4", "Major OS Version*" : "12"],
            ["OS version" : "13.0", "Major OS Version*" : "13"],
            ["OS version" : "9.1.1", "Major OS Version*" : "9"],
            ["OS version" : "10.1", "Major OS Version*" : "10"],
            ["OS version" : "13.0.2", "Major OS Version*" : "13"],
            ["OS version" : "11.2.1", "Major OS Version*" : "11"],
            ["OS version" : "Beta", "Major OS Version*" : "Beta"],
        ]
        
        let builder = MetaTableBuilder()
        builder.source = source
        builder.rules = [
            MajorOSVersionRule()
        ]
        
        let metaTable = try! builder.build()
        
        XCTAssertEqual(metaTable, expected)
    }
    
    // TODO: Fix this bu sorting the source and expected
    func x_testBothRules() {
        let source: Table = [
            ["Device model" : "Pad Air 2 (iPad5,4)", "OS version" : "12.2"],
            ["Device model" : "iPhone 8 (iPhone10)", "OS version" : "12.3.4"],
            ["Device model" : "iPhone X (iPhone10)", "OS version" : "13.0"],
            ["Device model" : "iPhone X (iPhone10)", "OS version" : "9.1.1"],
            ["Device model" : "iPad mini 2 (iPad4)", "OS version" : "10.1"],
            ["Device model" : "iPad Pro (12.9-inch)", "OS version" : "13.0.2"],
            ["Device model" : "Android Tablet", "OS version" : "Beta"]
        ]
        
        let expected: Table = [
            ["Device model" : "Pad Air 2 (iPad5,4)", "iOS Model Type" : "iPad", "OS version" : "12.2", "Major OS Version" : "12"],
            ["Device model" : "iPhone 8 (iPhone10)", "iOS Model Type" : "iPhone", "OS version" : "12.3.4", "Major OS Version" : "12"],
            ["Device model" : "iPhone X (iPhone10)", "iOS Model Type" : "iPhone", "OS version" : "12.3.4", "Major OS Version" : "12"],
            ["Device model" : "iPhone X (iPhone10)", "iOS Model Type" : "iPhone", "OS version" : "9.1.1", "Major OS Version" : "9"],
            ["Device model" : "iPad mini 2 (iPad4)", "iOS Model Type" : "iPad", "OS version" : "10.1", "Major OS Version" : "10"],
            ["Device model" : "iPad Pro (12.9-inch)", "iOS Model Type" : "iPad","OS version" : "13.0.2", "Major OS Version" : "13"],
            ["Device model" : "Android Tablet", "iOS Model Type" : "Unknown", "OS version" : "Beta", "Major OS Version" : "Beta"],
        ]
        
        let builder = MetaTableBuilder()
        builder.source = source
        builder.rules = [
            iOSModelTypeRule(),
            MajorOSVersionRule()
        ]
        
        let metaTable = try! builder.build()
        
        XCTAssertEqual(metaTable, expected)
        
    }
    
}


struct iOSModelTypeRule: MetaFieldRule {
    
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

struct MajorOSVersionRule: MetaFieldRule {
    
    public let sourceFieldName: FieldValue = "OS version"
    public let destinationFieldName = "Major OS Version*"
    
    public var transform: Transformation =  { name in
       guard
        let major = name.components(separatedBy: ".").first
            else { return "Unknown" }
        
        return major
    }
}
