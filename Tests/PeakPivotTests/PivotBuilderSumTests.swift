//
//  File.swift
//  
//
//  Created by Luke Stringer on 16/01/2021.
//

import Foundation

import XCTest
@testable import PeakPivot

class PivotBuilderSumTests: PivotBuilderTestsBase {
    
    func test_onLevels_summingNumbers() {
        
        builder.fields = ["age"]
        builder.sumsEnabled = true
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "21", value: PivotRow.Value(count: 1, sum: 21, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "25", value: PivotRow.Value(count: 1, sum: 25, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "29", value: PivotRow.Value(count: 1, sum: 29, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "33", value: PivotRow.Value(count: 1, sum: 33, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "35", value: PivotRow.Value(count: 1, sum: 35, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "36", value: PivotRow.Value(count: 1, sum: 36, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "38", value: PivotRow.Value(count: 1, sum: 38, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "40", value: PivotRow.Value(count: 1, sum: 40, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "41", value: PivotRow.Value(count: 1, sum: 41, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "42", value: PivotRow.Value(count: 1, sum: 42, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "44", value: PivotRow.Value(count: 1, sum: 44, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "45", value: PivotRow.Value(count: 1, sum: 45, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "52", value: PivotRow.Value(count: 1, sum: 52, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "54", value: PivotRow.Value(count: 2, sum: 108, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "57", value: PivotRow.Value(count: 1, sum: 57, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "58", value: PivotRow.Value(count: 1, sum: 58, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "63", value: PivotRow.Value(count: 2, sum: 126, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "68", value: PivotRow.Value(count: 1, sum: 68, percentage: nil), subRows: nil),
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func test_onLevels_summingNumbers_percentagesEnabled() {
        
        builder.fields = ["age"]
        builder.sumsEnabled = true
        builder.percentagesEnabled = true
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "21", value: PivotRow.Value(count: 1, sum: 21, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "25", value: PivotRow.Value(count: 1, sum: 25, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "29", value: PivotRow.Value(count: 1, sum: 29, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "33", value: PivotRow.Value(count: 1, sum: 33, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "35", value: PivotRow.Value(count: 1, sum: 35, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "36", value: PivotRow.Value(count: 1, sum: 36, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "38", value: PivotRow.Value(count: 1, sum: 38, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "40", value: PivotRow.Value(count: 1, sum: 40, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "41", value: PivotRow.Value(count: 1, sum: 41, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "42", value: PivotRow.Value(count: 1, sum: 42, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "44", value: PivotRow.Value(count: 1, sum: 44, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "45", value: PivotRow.Value(count: 1, sum: 45, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "52", value: PivotRow.Value(count: 1, sum: 52, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "54", value: PivotRow.Value(count: 2, sum: 108, percentage: 2/20), subRows: nil),
            PivotRow(level: 0, title: "57", value: PivotRow.Value(count: 1, sum: 57, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "58", value: PivotRow.Value(count: 1, sum: 58, percentage: 1/20), subRows: nil),
            PivotRow(level: 0, title: "63", value: PivotRow.Value(count: 2, sum: 126, percentage: 2/20), subRows: nil),
            PivotRow(level: 0, title: "68", value: PivotRow.Value(count: 1, sum: 68, percentage: 1/20), subRows: nil),
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func test_twoLevels_summingNumbers() {
        builder.fields = ["age_range", "age"]
        builder.sumsEnabled = true
        
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
            PivotRow(level: 0, title: "40s", value: PivotRow.Value(count: 5, sum: 212, percentage: nil), subRows: [
                PivotRow(level: 1, title: "40", value: PivotRow.Value(count: 1, sum: 40, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "41", value: PivotRow.Value(count: 1, sum: 41, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "42", value: PivotRow.Value(count: 1, sum: 42, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "44", value: PivotRow.Value(count: 1, sum: 44, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "45", value: PivotRow.Value(count: 1, sum: 45, percentage: nil), subRows: nil),
            ]),
            PivotRow(level: 0, title: "50s", value: PivotRow.Value(count: 5, sum: 275, percentage: nil), subRows: [
                PivotRow(level: 1, title: "52", value: PivotRow.Value(count: 1, sum: 52, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "54", value: PivotRow.Value(count: 2, sum: 108, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "57", value: PivotRow.Value(count: 1, sum: 57, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "58", value: PivotRow.Value(count: 1, sum: 58, percentage: nil), subRows: nil),
            ]),
            PivotRow(level: 0, title: "60s", value: PivotRow.Value(count: 3, sum: 194, percentage: nil), subRows: [
                PivotRow(level: 1, title: "63", value: PivotRow.Value(count: 2, sum: 126, percentage: nil), subRows: nil),
                PivotRow(level: 1, title: "68", value: PivotRow.Value(count: 1, sum: 68, percentage: nil), subRows: nil),
            ])
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
    
    func test_oneLevel_summingWithoutNumbers() {
        builder.fields = ["age_range"]
        builder.sumsEnabled = true
        
        runBuilder()
        
        let expected: [PivotRow] = [
            PivotRow(level: 0, title: "20s", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "30s", value: PivotRow.Value(count: 4, sum: nil, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "40s", value: PivotRow.Value(count: 5, sum: nil, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "50s", value: PivotRow.Value(count: 5, sum: nil, percentage: nil), subRows: nil),
            PivotRow(level: 0, title: "60s", value: PivotRow.Value(count: 3, sum: nil, percentage: nil), subRows: nil)
        ]
        
        XCTAssertEqual(pivotRows, expected)
    }
}
