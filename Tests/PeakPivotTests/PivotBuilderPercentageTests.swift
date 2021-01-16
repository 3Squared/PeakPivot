//
//  PivotBuilderPercentagesTests.swift
//  UnitTests
//
//  Created by Luke Stringer on 22/01/2020.
//  Copyright © 2020 3Squared Ltd. All rights reserved.
//

import XCTest
@testable import PeakPivot

class PivotBuilderPercentageTests: PivotBuilderTestsBase {
    
    override func setUp() {
        super.setUp()
        
        builder.percentagesEnabled = true
    }

    func testOneLevel() {

        builder.fields = ["title"]
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "Dr", value: PivotRow.Value(count: 3, sum: nil, percentage: 3/20), subRows: nil),
            PivotRow(level: 0, title: "Honorable", value: PivotRow.Value(count: 2, sum: nil, percentage: 2/20), subRows: nil),
            PivotRow(level: 0, title: "Mr", value: PivotRow.Value(count: 2, sum: nil, percentage: 2/20), subRows: nil),
            PivotRow(level: 0, title: "Mrs", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "Ms", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "Rev", value: PivotRow.Value(count: 3, sum: nil, percentage: 3/20), subRows: nil),
            PivotRow(level: 0, title: "(blank)", value: PivotRow.Value(count: 8, sum: nil, percentage: 8/20), subRows: nil)
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func testTwoLevels() {
        builder.fields = ["title", "age_range"]
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "Dr", value: PivotRow.Value(count: 3, sum: nil, percentage: 3/20), subRows: [
                PivotRow(level: 1, title: "30s", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: nil),
                PivotRow(level: 1, title: "40s", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: nil),
                PivotRow(level: 1, title: "60s", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: nil),
            ]),
            PivotRow(level: 0, title: "Honorable", value: PivotRow.Value(count: 2, sum: nil, percentage: 2/20), subRows: [
                PivotRow(level: 1, title: "20s", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: nil),
                PivotRow(level: 1, title: "50s", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: nil),
            ]),
            PivotRow(level: 0, title: "Mr", value: PivotRow.Value(count: 2, sum: nil, percentage: 2/20), subRows: [
                PivotRow(level: 1, title: "20s", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: nil),
                PivotRow(level: 1, title: "50s", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: nil),
            ]),
            PivotRow(level: 0, title: "Mrs", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: [
                PivotRow(level: 1, title: "40s", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: nil),
            ]),
            PivotRow(level: 0, title: "Ms", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: [
                PivotRow(level: 1, title: "30s", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: nil),
            ]),
            PivotRow(level: 0, title: "Rev", value: PivotRow.Value(count: 3, sum: nil, percentage: 3/20), subRows: [
                PivotRow(level: 1, title: "30s", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: nil),
                PivotRow(level: 1, title: "40s", value: PivotRow.Value(count: 2, sum: nil, percentage: 2/20), subRows: nil),
            ]),
            PivotRow(level: 0, title: "(blank)", value: PivotRow.Value(count: 8, sum: nil, percentage: 8/20), subRows: [
                PivotRow(level: 1, title: "20s", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: nil),
                PivotRow(level: 1, title: "30s", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: nil),
                PivotRow(level: 1, title: "40s", value: PivotRow.Value(count: 1, sum: nil, percentage: 1/20), subRows: nil),
                PivotRow(level: 1, title: "50s", value: PivotRow.Value(count: 3, sum: nil, percentage: 3/20), subRows: nil),
                PivotRow(level: 1, title: "60s", value: PivotRow.Value(count: 2, sum: nil, percentage: 2/20), subRows: nil),
            ])
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }

}
