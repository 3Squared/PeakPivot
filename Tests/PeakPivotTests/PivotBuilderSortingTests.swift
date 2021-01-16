//
//  PivotBuilderSortingTests.swift
//  UnitTests
//
//  Created by Luke Stringer on 22/01/2020.
//  Copyright © 2020 3Squared Ltd. All rights reserved.
//

import XCTest
@testable import PeakPivot

class PivotBuilderSortingTests: PivotBuilderTestsBase {
    
    func testOneLevel_byTitleDescending() {
        builder.fields = ["age_range"]
        builder.sortDescriptor = .byTitle(ascending: false)
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "60s", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "50s", value: PivotRow.Value(count: 5, sum: nil, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "40s", value: PivotRow.Value(count: 5, sum: nil, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "30s", value: PivotRow.Value(count: 4, sum: nil, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "20s", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: nil),
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func testOneLevel_byTitleAscending() {
        builder.fields = ["age_range"]
        builder.sortDescriptor = .byValue(ascending: true)
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "20s", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "60s", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "30s", value: PivotRow.Value(count: 4, sum: nil, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "40s", value: PivotRow.Value(count: 5, sum: nil, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "50s", value: PivotRow.Value(count: 5, sum: nil, percentage: nil), subRows: nil),
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func testTwoLevels_byValueAscending() {
        builder.fields = ["age_range", "gender"]
        builder.sortDescriptor = .byValue(ascending: true)
        
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
            PivotRow(level: 0, title: "40s", value: PivotRow.Value(count: 5, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: nil),
            ]),
            PivotRow(level: 0, title: "50s", value: PivotRow.Value(count: 5, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: nil),
            ]),
            
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func testTwoLevels_byValueDescending() {
        builder.fields = ["age_range", "gender", "title"]
        builder.sortDescriptor = .byValue(ascending: false)
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "40s", value: PivotRow.Value(count: 5, sum: nil, percentage: nil), subRows: [
                
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Mrs", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Dr", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                    PivotRow(level: 2, title: "Rev", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Rev", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
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
            PivotRow(level: 0, title: "30s", value: PivotRow.Value(count: 4, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Dr", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                    PivotRow(level: 2, title: "Ms", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                    PivotRow(level: 2, title: "Rev", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
            ]),
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
            PivotRow(level: 0, title: "60s", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Dr", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ])
            ]),
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
}
