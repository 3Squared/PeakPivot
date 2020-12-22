//
//  PivotBuilderMultipleFilterTests.swift
//  UnitTests
//
//  Created by Luke Stringer on 17/02/2020.
//  Copyright © 2020 3Squared Ltd. All rights reserved.
//

import Foundation

import XCTest
@testable import PeakPivot

class PivotBuilderMultipleFilterTests: PivotBuilderTestsBase {
    
    func testTwoLevels_TwoFilters_TwoIncludes() {
        builder.fields = ["title", "age_range"]
        builder.filters = [
            BuildPivotFilter(fieldName: "title", include: ["Dr", Blank]),
            BuildPivotFilter(fieldName: "age_range", include: ["40s", "60s"]),
        ]
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "Dr", value: PivotRow.Value(count: 2, percentage: nil), subRows: [
                PivotRow(level: 1, title: "40s", value: PivotRow.Value(count: 1, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "60s", value: PivotRow.Value(count: 1, percentage: nil), subRows: nil),
            ]),
            PivotRow(level: 0, title: "(blank)", value: PivotRow.Value(count: 3, percentage: nil), subRows: [
                PivotRow(level: 1, title: "40s", value: PivotRow.Value(count: 1, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "60s", value: PivotRow.Value(count: 2, percentage: nil), subRows: nil),
            ]),
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func testTwoLevels_TwoFilters_TwoIncludes_ZerosEnabled() {
        builder.fields = ["title", "age_range"]
        builder.filters = [
            BuildPivotFilter(fieldName: "age_range", include: ["50s"]),
        ]
        builder.zeroRowsEnabled = true
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "Dr", value: PivotRow.Value(count: 0, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "Honorable", value: PivotRow.Value(count: 1, percentage: nil), subRows: [
                PivotRow(level: 1, title: "50s", value: PivotRow.Value(count: 1, percentage: nil), subRows: nil),
            ]),
            PivotRow(level: 0, title: "Mr", value: PivotRow.Value(count: 1, percentage: nil), subRows: [
                PivotRow(level: 1, title: "50s", value: PivotRow.Value(count: 1, percentage: nil), subRows: nil),
            ]),
            PivotRow(level: 0, title: "Mrs", value: PivotRow.Value(count: 0, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "Ms", value: PivotRow.Value(count: 0, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "Rev", value: PivotRow.Value(count: 0, percentage: nil), subRows:nil),
            PivotRow(level: 0, title: "(blank)", value: PivotRow.Value(count: 3, percentage: nil), subRows: [
                PivotRow(level: 1, title: "50s", value: PivotRow.Value(count: 3, percentage: nil), subRows: nil),
            ]),
        ]
        
        XCTAssertEqual(pivotRows, expected)
        
    }
    
    func testTwoLevels_TwoFilters_TwoIncludes_ZerosDisabled() {
        builder.fields = ["title", "age_range"]
        builder.filters = [
            BuildPivotFilter(fieldName: "age_range", include: ["50s"]),
        ]
        builder.zeroRowsEnabled = false
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "Honorable", value: PivotRow.Value(count: 1, percentage: nil), subRows: [
                PivotRow(level: 1, title: "50s", value: PivotRow.Value(count: 1, percentage: nil), subRows: nil),
            ]),
            PivotRow(level: 0, title: "Mr", value: PivotRow.Value(count: 1, percentage: nil), subRows: [
                PivotRow(level: 1, title: "50s", value: PivotRow.Value(count: 1, percentage: nil), subRows: nil),
            ]),
            PivotRow(level: 0, title: "(blank)", value: PivotRow.Value(count: 3, percentage: nil), subRows: [
                PivotRow(level: 1, title: "50s", value: PivotRow.Value(count: 3, percentage: nil), subRows: nil),
            ]),
        ]
        
        XCTAssertEqual(pivotRows, expected)
        
    }
    
    func testTwoLevels_TwoFilters_TwoIncludes_ZerosDisabled_PercentagesEnabled() {
        builder.fields = ["title", "age_range"]
        builder.filters = [
            BuildPivotFilter(fieldName: "age_range", include: ["50s"]),
        ]
        builder.zeroRowsEnabled = false
        builder.percentagesEnabled = true
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "Honorable", value: PivotRow.Value(count: 1, percentage: 1/5), subRows: [
                PivotRow(level: 1, title: "50s", value: PivotRow.Value(count: 1, percentage: 1/5), subRows: nil),
            ]),
            PivotRow(level: 0, title: "Mr", value: PivotRow.Value(count: 1, percentage: 1/5), subRows: [
                PivotRow(level: 1, title: "50s", value: PivotRow.Value(count: 1, percentage: 1/5), subRows: nil),
            ]),
            PivotRow(level: 0, title: "(blank)", value: PivotRow.Value(count: 3, percentage: 3/5), subRows: [
                PivotRow(level: 1, title: "50s", value: PivotRow.Value(count: 3, percentage: 3/5), subRows: nil),
            ])
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
}
