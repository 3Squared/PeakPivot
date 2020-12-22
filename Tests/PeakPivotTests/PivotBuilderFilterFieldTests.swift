//
//  FieldRowTests.swift
//  UnitTests
//
//  Created by Luke Stringer on 03/01/2020.
//  Copyright © 2020 3Squared Ltd. All rights reserved.
//

import XCTest
@testable import PeakPivot

class PivotBuilderFilterFieldTests: PivotBuilderTestsBase {

    func testOneField_exampleA() {
        builder.fields = ["age_range"]
        
        runBuilder()
        
        let expected = [
            FilterField(name: "age_range", values: [
                "20s",
                "30s",
                "40s",
                "50s",
                "60s",
            ]),
        ]
        
        XCTAssertEqual(pivot.filterFields, expected)
    }
    
    func testOneField_exampleB() {
        builder.fields = ["gender"]
        
        runBuilder()
        
        let expected = [
            FilterField(name: "gender", values: [
                "Female",
                "Male",
                Blank
            ]),
        ]
        
        XCTAssertEqual(pivot.filterFields, expected)
    }
    
    func testTwoFields() {
        builder.fields = ["age_range", "title"]
        
        runBuilder()
        
        let expected = [
            FilterField(name: "age_range", values: [
                "20s",
                "30s",
                "40s",
                "50s",
                "60s",
            ]),
            FilterField(name: "title", values: [
                "Dr",
                "Honorable",
                "Mr",
                "Mrs",
                "Ms",
                "Rev",
                Blank,
            ]),
        ]
        
        XCTAssertEqual(pivot.filterFields, expected)
    }
    
    func testThreeFields() {
        builder.fields = ["age_range", "gender", "title"]
        
        runBuilder()
        
        let expected = [
            FilterField(name: "age_range", values: [
                "20s",
                "30s",
                "40s",
                "50s",
                "60s",
            ]),
            FilterField(name: "gender", values: [
                "Female",
                "Male",
                Blank
            ]),
            FilterField(name: "title", values: [
                "Dr",
                "Honorable",
                "Mr",
                "Mrs",
                "Ms",
                "Rev",
                Blank,
            ]),
        ]
        
        XCTAssertEqual(pivot.filterFields, expected)
    }
}
