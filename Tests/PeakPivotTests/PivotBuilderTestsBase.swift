//
//  PivotBuilderTestsBase.swift
//  UnitTests
//
//  Created by Luke Stringer on 22/01/2020.
//  Copyright © 2020 3Squared Ltd. All rights reserved.
//

import XCTest
@testable import PeakPivot

class PivotBuilderTestsBase: XCTestCase {
        
    let builder = PivotBuilder.Custom()
    var pivot: Pivot!
    
    var pivotRows: [PivotRow] {
        get {
            return pivot.rows
        }
    }
    
    override func setUp() {
        super.setUp()
        builder.table = TestData.people
        builder.percentagesEnabled = false
    }
    
    func runBuilder() {
        guard let pivot = try? builder.build() else {
            XCTFail("Pivot failed to build")
            return
        }
        
        self.pivot = pivot
    }

}
