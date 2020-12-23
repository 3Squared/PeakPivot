//
//  FieldValueCell.swift
//  Bugfender-CSV-Viewer
//
//  Created by Luke Stringer on 03/01/2020.
//  Copyright © 2020 3Squared Ltd. All rights reserved.
//

import UIKit

class FieldValueCell: UITableViewCell {
    
    var enabled = true {
        didSet {
            isUserInteractionEnabled = enabled
            textLabel?.isUserInteractionEnabled = enabled
            textLabel?.alpha = enabled ? 1.0 : 0.4
            tintColor = enabled ? nil : .gray
            setNeedsLayout()
        }
    }
}
