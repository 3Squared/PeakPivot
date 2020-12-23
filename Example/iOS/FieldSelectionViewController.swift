//
//  FieldSelectionViewController.swift
//  Bugfender-CSV-Viewer
//
//  Created by Luke Stringer on 31/12/2019.
//  Copyright © 2019 3Squared Ltd. All rights reserved.
//

import UIKit
import PeakPivot
import SwiftCSV

class FieldSelectionViewController: UITableViewController {
    
    var csv: CSV! {
        didSet {
            guard let csvHeaders = csv?.header else { return }
            
            fieldNames = generateFieldNames(usingHeaders: csvHeaders)
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    var metaFieldRules: [MetaFieldRule] = []
    
    fileprivate var fieldNames: [String]?
    fileprivate var selectedFieldNames = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Field Names", style: .plain, target: nil, action: nil)
        tableView.isEditing = true
        
        navigationController?.navigationBar.prefersLargeTitles = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}

// MARK: - Segues
extension FieldSelectionViewController {
    
    @objc func showPivot() {
         let segue = "showPivotFromFieldSelection"
         if shouldPerformSegue(withIdentifier: segue, sender: nil) {
             performSegue(withIdentifier: segue, sender: self)
         }
     }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "showPivotFromFieldSelection" && selectedFieldNames.count > 0 {
            return true
        }
        else {
            let alert = UIAlertController(title: "Cannot Create Pivot", message: "Please select at least 1 field name.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let pivotViewController = segue.destination as? PivotViewController else {
            fatalError("Cannot get Pivot View Controller from destination segue")
        }
        
        let sortedSelectedFieldNames = fieldNames?.compactMap { fieldName -> FieldName? in
            if selectedFieldNames.contains(fieldName) {
                return fieldName
            }
            return nil
        }
        
        pivotViewController.dataSource = .fields(fieldNames: sortedSelectedFieldNames)
        pivotViewController.metaFieldRules = metaFieldRules
        pivotViewController.csv = csv
    }
}

// MARK: - Table view
extension FieldSelectionViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let fieldNames = self.fieldNames {
            return fieldNames.count
        }
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let fieldNames = fieldNames else {
            return tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "fieldNameCell", for: indexPath)
        
        let fieldName = fieldNames[indexPath.row]
        cell.textLabel?.text = fieldName
        cell.editingAccessoryType = selectedFieldNames.contains(fieldName) ? .checkmark : .none


        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if fieldNames != nil {
            return "CSV Fields Names"
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return csv != nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let fieldNames = fieldNames else { return }
        
        let fieldName = fieldNames[indexPath.row]
        if selectedFieldNames.contains(fieldName) {
            guard let index = selectedFieldNames.firstIndex(of: fieldName) else { return }
            selectedFieldNames.remove(at: index)
        }
        else {
            selectedFieldNames.append(fieldName)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        guard fieldNames != nil else { return }
        
        let fieldName = fieldNames![fromIndexPath.row]
        fieldNames!.remove(at: fromIndexPath.row)
        fieldNames!.insert(fieldName, at: to.row)
    }

    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}


fileprivate extension FieldSelectionViewController {
    func generateFieldNames(usingHeaders headers: [String]) -> [String] {
        
        let metaRuleFieldNames = metaFieldRules.map { $0.destinationFieldName }
        let allFields = metaRuleFieldNames + headers
        
        return allFields.sorted { $0.lowercased() < $1.lowercased() }
    }

}

