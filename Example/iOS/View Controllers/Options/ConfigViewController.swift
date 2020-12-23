//
//  ConfigViewController.swift
//  PeakPivot
//
//  Created by Luke Stringer on 17/05/2020.
//  Copyright © 2020 Luke Stringer. All rights reserved.
//

import UIKit

class ConfigViewController: UITableViewController {
    
    var zeroRowsEnabled: Bool?
    
    @IBOutlet fileprivate weak var showZeroCountsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showZeroCountsSwitch.isOn = zeroRowsEnabled ?? true
    }
}

fileprivate extension ConfigViewController {
    
    @IBAction func showZerosValueChanged(_ sender: Any) {
        zeroRowsEnabled = showZeroCountsSwitch.isOn
    }
}
