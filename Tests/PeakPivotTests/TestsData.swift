//
//  TestData.swift
//  UnitTests
//
//  Created by Luke Stringer on 30/12/2019.
//  Copyright © 2019 3Squared Ltd. All rights reserved.
//

import Foundation
import SwiftCSV
@testable import PeakPivot

struct TestData {
    
    static var people: Table {
        get {
            return tableFromCSV(named: "people")
        }
    }
    
    fileprivate static func tableFromCSV(named name: String) -> Table {
        
        // This is hacky way to get to the resource URLs
        // Assumes this file at a set location so we can get to the Resource adjacent to it
        // TODO: Update to Package.swift to use .resource when Swift 5.3 is avaiable (more here: https://github.com/apple/swift-evolution/blob/master/proposals/0271-package-manager-resources.md)
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        let resourceURL = thisDirectory.appendingPathComponent("../Resources/\(name).csv")
        
        let csv = try! CSV(url: resourceURL)
        return csv.namedRows
    }
}
