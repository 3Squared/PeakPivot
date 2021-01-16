//
//  PivotBuilderCountTests.swift
//  UnitTests
//
//  Created by Luke Stringer on 22/01/2020.
//  Copyright © 2020 3Squared Ltd. All rights reserved.
//

import XCTest
@testable import PeakPivot

class PivotBuilderCountTests: PivotBuilderTestsBase {
    
    func testTwoLevels() {
        builder.fields = ["age_range", "gender"]
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "20s", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil)
            ]),
            PivotRow(level: 0, title: "30s", value: PivotRow.Value(count: 4, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil)
            ]),
            PivotRow(level: 0, title: "40s", value: PivotRow.Value(count: 5, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil)
            ]),
            PivotRow(level: 0, title: "50s", value: PivotRow.Value(count: 5, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil)
            ]),
            PivotRow(level: 0, title: "60s", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil)
            ])
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }

    
    func testThreeLevels() {
        builder.fields = ["age_range", "gender", "title"]
        
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
            PivotRow(level: 0, title: "30s", value: PivotRow.Value(count: 4, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Dr", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                    PivotRow(level: 2, title: "Ms", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                    PivotRow(level: 2, title: "Rev", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ])
            ]),
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
            ])
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
}
