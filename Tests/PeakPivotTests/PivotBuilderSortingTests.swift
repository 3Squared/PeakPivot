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
        builder.sortDescriptor = .byCount(ascending: true)
        
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
    
    func testTwoLevels_byCountAscending() {
        builder.fields = ["age_range", "gender"]
        builder.sortDescriptor = .byCount(ascending: true)
        
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
    
    func testTwoLevels_byCountDescending() {
        builder.fields = ["age_range", "gender", "title"]
        builder.sortDescriptor = .byCount(ascending: false)
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "50s", value: PivotRow.Value(count: 5, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Mr", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil)
                ]),
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Honorable", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
            ]),
            PivotRow(level: 0, title: "40s", value: PivotRow.Value(count: 5, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Rev", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                    PivotRow(level: 2, title: "Dr", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 2, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Mrs", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
          
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Rev", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
            ]),
            PivotRow(level: 0, title: "30s", value: PivotRow.Value(count: 4, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Rev", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                    PivotRow(level: 2, title: "Ms", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                    PivotRow(level: 2, title: "Dr", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
            ]),
            PivotRow(level: 0, title: "60s", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Dr", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ])
            ]),
            PivotRow(level: 0, title: "20s", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: [
                PivotRow(level: 1, title: "Male", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "Female", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Honorable", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ]),
                PivotRow(level: 1, title: "(blank)", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: [
                    PivotRow(level: 2, title: "Mr", value: PivotRow.Value(count: 1, sum: nil, percentage: nil), subRows: nil),
                ])
            ]),

        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func testTwoLevels_bySumAscending() {
        
        builder.fields = ["age_range", "age"]
        builder.sumsEnabled = true
        builder.sortDescriptor = .bySum(ascending: true)
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "20s", value: PivotRow.Value(count: 3, sum: 75, percentage: nil), subRows: [
                PivotRow(level: 1, title: "21", value: PivotRow.Value(count: 1, sum: 21, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "25", value: PivotRow.Value(count: 1, sum: 25, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "29", value: PivotRow.Value(count: 1, sum: 29, percentage: nil), subRows: nil)
            ]),
            PivotRow(level: 0, title: "30s", value: PivotRow.Value(count: 4, sum: 142, percentage: nil), subRows: [
                PivotRow(level: 1, title: "33", value: PivotRow.Value(count: 1, sum: 33, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "35", value: PivotRow.Value(count: 1, sum: 35, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "36", value: PivotRow.Value(count: 1, sum: 36, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "38", value: PivotRow.Value(count: 1, sum: 38, percentage: nil), subRows: nil)
            ]),
            PivotRow(level: 0, title: "60s", value: PivotRow.Value(count: 3, sum: 194, percentage: nil), subRows: [
                PivotRow(level: 1, title: "68", value: PivotRow.Value(count: 1, sum: 68, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "63", value: PivotRow.Value(count: 2, sum: 126, percentage: nil), subRows: nil),
            ]),
            PivotRow(level: 0, title: "40s", value: PivotRow.Value(count: 5, sum: 212, percentage: nil), subRows: [
                PivotRow(level: 1, title: "40", value: PivotRow.Value(count: 1, sum: 40, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "41", value: PivotRow.Value(count: 1, sum: 41, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "42", value: PivotRow.Value(count: 1, sum: 42, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "44", value: PivotRow.Value(count: 1, sum: 44, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "45", value: PivotRow.Value(count: 1, sum: 45, percentage: nil), subRows: nil),
            ]),
            PivotRow(level: 0, title: "50s", value: PivotRow.Value(count: 5, sum: 275, percentage: nil), subRows: [
                PivotRow(level: 1, title: "52", value: PivotRow.Value(count: 1, sum: 52, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "57", value: PivotRow.Value(count: 1, sum: 57, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "58", value: PivotRow.Value(count: 1, sum: 58, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "54", value: PivotRow.Value(count: 2, sum: 108, percentage: nil), subRows: nil),
            ]),
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func testTwoLevels_bySumDescending() {
        
        builder.fields = ["age_range", "age"]
        builder.sumsEnabled = true
        builder.sortDescriptor = .bySum(ascending: false)
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "50s", value: PivotRow.Value(count: 5, sum: 275, percentage: nil), subRows: [
                PivotRow(level: 1, title: "54", value: PivotRow.Value(count: 2, sum: 108, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "58", value: PivotRow.Value(count: 1, sum: 58, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "57", value: PivotRow.Value(count: 1, sum: 57, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "52", value: PivotRow.Value(count: 1, sum: 52, percentage: nil), subRows: nil),
            ]),
            PivotRow(level: 0, title: "40s", value: PivotRow.Value(count: 5, sum: 212, percentage: nil), subRows: [
                PivotRow(level: 1, title: "45", value: PivotRow.Value(count: 1, sum: 45, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "44", value: PivotRow.Value(count: 1, sum: 44, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "42", value: PivotRow.Value(count: 1, sum: 42, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "41", value: PivotRow.Value(count: 1, sum: 41, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "40", value: PivotRow.Value(count: 1, sum: 40, percentage: nil), subRows: nil),
            ]),
            PivotRow(level: 0, title: "60s", value: PivotRow.Value(count: 3, sum: 194, percentage: nil), subRows: [
                PivotRow(level: 1, title: "63", value: PivotRow.Value(count: 2, sum: 126, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "68", value: PivotRow.Value(count: 1, sum: 68, percentage: nil), subRows: nil),
            ]),
            PivotRow(level: 0, title: "30s", value: PivotRow.Value(count: 4, sum: 142, percentage: nil), subRows: [
                PivotRow(level: 1, title: "38", value: PivotRow.Value(count: 1, sum: 38, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "36", value: PivotRow.Value(count: 1, sum: 36, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "35", value: PivotRow.Value(count: 1, sum: 35, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "33", value: PivotRow.Value(count: 1, sum: 33, percentage: nil), subRows: nil),
            ]),
            PivotRow(level: 0, title: "20s", value: PivotRow.Value(count: 3, sum: 75, percentage: nil), subRows: [
                PivotRow(level: 1, title: "29", value: PivotRow.Value(count: 1, sum: 29, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "25", value: PivotRow.Value(count: 1, sum: 25, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "21", value: PivotRow.Value(count: 1, sum: 21, percentage: nil), subRows: nil),
            ]),
        ]
        
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func testOneLevels_sumsDisabled_bySum_usesCountThenTitle() {
        
        builder.fields = ["age_range"]
        builder.sumsEnabled = false
        builder.sortDescriptor = .bySum(ascending: true)
        
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
    
    func testTwoLevels_sumsDisabled_bySum_usesCountThenTitle() {
        builder.fields = ["age_range", "gender"]
        builder.sumsEnabled = false
        builder.sortDescriptor = .bySum(ascending: true)
        
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
}
