//
//  PivotBuilderFilteringTests.swift
//  UnitTests
//
//  Created by Luke Stringer on 22/01/2020.
//  Copyright © 2020 3Squared Ltd. All rights reserved.
//

import XCTest
@testable import PeakPivot

class PivotBuilderSingleFilterTests: PivotBuilderTestsBase {
    
    func testThreeLevels_fourExcludesAtLevelOne() {
        builder.fields = ["age_range", "gender", "title"]
        builder.filters = [BuildPivotFilter(fieldName: "age_range", exclude: ["30s", "40s", "50s", "60s"])]
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "20s", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Honorable", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Mr", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ])
            ]),
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func testThreeLevels_threeExcludesAtLevelOne() {
        builder.fields = ["age_range", "gender", "title"]
//        builder.filters = [BuildPivotFilter(fieldName: "age_range", include: ["20s", "50s"])]
        builder.filters = [BuildPivotFilter(fieldName: "age_range", exclude: ["30s", "40s", "60s"])]
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "20s", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Honorable", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Mr", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ])
            ]),
            PivotRow(level: 0, title: "50s", value: PivotRow.Value(count: 5, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Honorable", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Mr", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil)
                ]),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
            ]),
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func testThreeLevels_twoExcludesAtLevelTwo_sortByValueAscending_noPercentages() {
        builder.sortDescriptor = .byCount(ascending: true)
        builder.fields = ["age_range", "gender"]
//        builder.filters = [BuildPivotFilter(fieldName: "age_range", include: ["20s", "30s", "60s"])]
        builder.filters = [BuildPivotFilter(fieldName: "age_range", exclude: ["40s", "50s"])]
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "20s", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil)
            ]),
            PivotRow(level: 0, title: "60s", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil)
            ]),
            PivotRow(level: 0, title: "30s", value: PivotRow.Value(count: 4, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: nil),
            ]),
            
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func testOneLevels_blankInclude() {
        builder.fields = ["gender"]
        builder.filters = [BuildPivotFilter(fieldName: "gender", exclude: ["Female", "Male"])]
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "(blank)", value: PivotRow.Value(count: 5, sum: nil, percentage: nil), subRows: nil)
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
}
