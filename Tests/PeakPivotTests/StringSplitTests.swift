//
//  StringSplitTests.swift
//  UnitTests
//
//  Created by Luke Stringer on 27/02/2020.
//  Copyright © 2020 Luke Stringer. All rights reserved.
//

import XCTest
@testable import PeakPivot

class StringSplitTests: XCTestCase {
    
    func testSplitOneWord() {
        let string = "Lorem"
        
        let processed = string.splitIntoChunks(ofSize: 5)
        
        XCTAssertEqual(processed, ["Lorem"])
    }
    
    func testSplitMultipleWords() {
        let string = "Loremsum sit amet consectetur"
        
        let processed = string.splitIntoChunks(ofSize: 8)
        
        let expected = [
            "Loremsum",
            "sit amet",
            "consectetur",
        ]
        XCTAssertEqual(processed, expected)
    }
    
    func testSplitDeviceModel() {
        let string = "iPad Pro (12.9 inch, 2nd generation) (iPad7,2)"
        
        let processed = string.splitIntoChunks(ofSize: 11)
        
        let expected = [
            "iPad Pro (12.9",
            "inch, 2nd generation)",
            "(iPad7,2)",
        ]
        XCTAssertEqual(processed, expected)
        
    }
    
}
