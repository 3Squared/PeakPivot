//
//  PivotBuilderMetaFieldTests.swift
//  UnitTests
//
//  Created by Luke Stringer on 18/05/2020.
//  Copyright © 2020 Luke Stringer. All rights reserved.
//

import XCTest
@testable import PeakPivot

class MetaTableBuilderTests: XCTestCase {
    
    let source: Table = [
        ["first_name" : "Alice"],
        ["first_name" : "Alex"],
        ["first_name" : "Amy"],
        ["first_name" : "Bob"],
        ["first_name" : "Charlie"],
        ["first_name" : "Dan"],
        ["first_name" : "Darcy"],
        ["first_name" : "Elvis"],
        ["first_name" : "Freddie"],
        ["first_name" : "Fiona"],
    ]
    
    func firstLetterTransform(_ name: FieldValue) -> FieldValue {
        guard
            let firstLetter = name.first
        else { return name }
        
        return firstLetter.lowercased()
    }
    
    func nameCountTransform(_ name: FieldValue) -> FieldValue {
        return "\(name.count)"
    }
    
    // MARK: - Tests
    
    func testBuildsSameTableWithNoRules() {
        let builder = MetaTableBuilder()
        builder.source = source
        
        let metaTable = try! builder.build()
        
        XCTAssertEqual(metaTable, source)
    }
    
    func testBuildsWithSingleRule() {
    
        let expected: Table = [
            ["first_name" : "Alice", "first_letter_of_name": "a"],
            ["first_name" : "Alex", "first_letter_of_name": "a"],
            ["first_name" : "Amy", "first_letter_of_name": "a"],
            ["first_name" : "Bob", "first_letter_of_name": "b"],
            ["first_name" : "Charlie", "first_letter_of_name": "c"],
            ["first_name" : "Dan", "first_letter_of_name": "d"],
            ["first_name" : "Darcy", "first_letter_of_name": "d"],
            ["first_name" : "Elvis", "first_letter_of_name": "e"],
            ["first_name" : "Freddie", "first_letter_of_name": "f"],
            ["first_name" : "Fiona", "first_letter_of_name": "f"],
        ]
        
        let builder = MetaTableBuilder()
        builder.source = source
        builder.rules = [
            CustomMetaFieldRule(sourceFieldName: "first_name",
                          destinationFieldName: "first_letter_of_name",
                          transform: firstLetterTransform
            )
        ]
        
        let metaTable = try! builder.build()
        
        XCTAssertEqual(metaTable, expected)
    }
    
    func testBuildsWithTwoRules() {
    
        let expected: Table = [
            ["first_name" : "Alice", "first_letter_of_name": "a", "first_name_count": 5.toString],
            ["first_name" : "Alex", "first_letter_of_name": "a", "first_name_count": 4.toString],
            ["first_name" : "Amy", "first_letter_of_name": "a","first_name_count": 3.toString],
            ["first_name" : "Bob", "first_letter_of_name": "b", "first_name_count": 3.toString],
            ["first_name" : "Charlie", "first_letter_of_name": "c", "first_name_count": 7.toString],
            ["first_name" : "Dan", "first_letter_of_name": "d", "first_name_count": 3.toString],
            ["first_name" : "Darcy", "first_letter_of_name": "d", "first_name_count": 5.toString],
            ["first_name" : "Elvis", "first_letter_of_name": "e", "first_name_count": 5.toString],
            ["first_name" : "Freddie", "first_letter_of_name": "f", "first_name_count": 7.toString],
            ["first_name" : "Fiona", "first_letter_of_name": "f", "first_name_count": 5.toString],
        ]
        
        let builder = MetaTableBuilder()
        builder.source = source
        builder.rules = [
            CustomMetaFieldRule(sourceFieldName: "first_name",
                          destinationFieldName: "first_letter_of_name",
                          transform: firstLetterTransform
            ),
            CustomMetaFieldRule(sourceFieldName: "first_name",
                          destinationFieldName: "first_name_count",
                          transform: nameCountTransform
            )
        ]
        
        let metaTable = try! builder.build()
        
        XCTAssertEqual(metaTable, expected)
    }

}

fileprivate extension Int {
    var toString: String {
        get {
            return String(self)
        }
    }
}
