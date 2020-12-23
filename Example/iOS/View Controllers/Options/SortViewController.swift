//
//  SortViewController.swift
//  PeakPivot
//
//  Created by Luke Stringer on 08/01/2020.
//  Copyright © 2020 3Squared Ltd. All rights reserved.
//

import UIKit
import PeakPivot

class SortViewController: UITableViewController {
    
    var selectedSortDescriptor: BuildPivotDescriptor?
    
    fileprivate let sortDescriptors = BuildPivotDescriptor.allCases
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortDescriptors.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sortCell", for: indexPath)
        
        let sortDescriptor = sortDescriptors[indexPath.row]
        
        cell.textLabel?.text = sortDescriptor.title
        cell.accessoryType = sortDescriptor == selectedSortDescriptor ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedSortDescriptor = sortDescriptors[indexPath.row]
        tableView.reloadSections(IndexSet([0]), with: .automatic)
    }
    
}

fileprivate extension BuildPivotDescriptor {
    var title: String {
        get {
            switch self {
            case .byTitle(let ascending):
                return "By Title (\(ascending ? "Ascending" : "Descending"))"
            case .byValue(let ascending):
                return "By Value (\(ascending ? "Ascending" : "Descending"))"
            }
        }
    }
}
