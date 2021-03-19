//
//  PivotBuilderIntegrationTests.swift
//  UnitTests
//
//  Created by Luke Stringer on 22/01/2020.
//  Copyright © 2020 3Squared Ltd. All rights reserved.
//

import XCTest
@testable import PeakPivot

class PivotBuilderIntegrationTests: PivotBuilderTestsBase {

    func testTwoLevels_oneFilterAtLevelOne_withPercentages() {
        builder.percentagesEnabled = false
        builder.table = TestData.people
        builder.fields = ["age_range", "gender"]
        
        builder.filters = [BuildPivotFilter(fieldName: "age_range", exclude: ["20s", "30s", "50s", "60s"])]
        builder.percentagesEnabled = true
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "40s", value: PivotRow.Value(count: 5, sum: nil, percentage: 1), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 2, sum: nil, percentage: 2/5), subRows: nil),
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 2, sum: nil, percentage: 2/5), subRows: nil),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/5), subRows: nil),
            ]),
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func testTwoLevels_threeFiltersAtLevelOne_withPercentages() {
        builder.percentagesEnabled = false
        builder.table = TestData.people
        builder.fields = ["age_range", "gender"]
        builder.filters = [BuildPivotFilter(fieldName: "age_range", exclude: ["20s", "30s", "50s"])]
        builder.sortDescriptor = .byCount(ascending: false)
        builder.percentagesEnabled = true
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "40s", value: PivotRow.Value(count: 5, sum: nil, percentage: 5/8), subRows: [
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 2, sum: nil, percentage: 2/8), subRows: nil),
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 2, sum: nil, percentage: 2/8), subRows: nil),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/8), subRows: nil),
            ]),
            PivotRow(level: 0, title: "60s", value: PivotRow.Value(count: 3, sum: nil, percentage: 3/8), subRows: [
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/8), subRows: nil),
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/8), subRows: nil),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/8), subRows: nil),
            ])
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func testThreeLevels_oneFilterAtLevelTwo_sortByValueDescending_() {
        builder.percentagesEnabled = true
           builder.sortDescriptor = .byCount(ascending: false)
           builder.fields = ["age_range", "gender", "title"]
        builder.filters = [BuildPivotFilter(fieldName: "gender", exclude: ["Male", Blank])]
           
          runBuilder()
           
           let expected: [PivotRow] = [
               PivotRow(level: 0, title: "30s", value: PivotRow.Value(count: 3, sum: nil, percentage: 3/9), subRows: [
                   PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 3, sum: nil, percentage: 3/9), subRows: [
                    PivotRow(level: 2, title: "Rev", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/9), subRows: nil),
                    PivotRow(level: 2, title: "Ms", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/9), subRows: nil),
                       PivotRow(level: 2, title: "Dr", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/9), subRows: nil),
                   ]),
               ]),
            PivotRow(level: 0, title: "50s", value: PivotRow.Value(count: 2, sum: nil, percentage: 2/9), subRows: [
                     PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 2, sum: nil, percentage: 2/9), subRows: [
                         PivotRow(level: 2, title: "Honorable", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/9), subRows: nil),
                         PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/9), subRows: nil),
                     ]),
                 ]),
               PivotRow(level: 0, title: "40s", value: PivotRow.Value(count: 2, sum: nil, percentage: 2/9), subRows: [
                        PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 2, sum: nil, percentage: 2/9), subRows: [
                            PivotRow(level: 2, title: "Mrs", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/9), subRows: nil),
                            PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/9), subRows: nil),
                        ]),
                    ]),
            PivotRow(level: 0, title: "60s", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/9), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/9), subRows: [
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/9), subRows: nil),
                ]),
            ]),
               PivotRow(level: 0, title: "20s", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/9), subRows: [
                   PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/9), subRows: [
                       PivotRow(level: 2, title: "Honorable", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/9), subRows: nil),
                   ]),
               ]),
        
               
           ]
           
           XCTAssertEqual(pivotRows, expected)
       }

}
