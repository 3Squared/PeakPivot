//
//  Pivot.swift
//  Bugfender-CSV-Viewer
//
//  Created by Luke Stringer on 12/11/2019.
//  Copyright © 2019 3Squared Ltd. All rights reserved.
//

import Foundation

/// The column name from the CSV
public typealias FieldName = String

/// The value of a cell in the CSV
public typealias FieldValue = String

/// A row in the CSV
public typealias TableRow = [FieldName : FieldValue]

/// Input data (e.g CSV) to create a pivot from
public typealias Table = [TableRow]

/// Convieince constant to represent "blank" in the table of pivot output
public let Blank: String = "(blank)"
