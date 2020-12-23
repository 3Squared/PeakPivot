//
//  FilterViewController.swift
//  PeakPivot
//
//  Created by Luke Stringer on 03/01/2020.
//  Copyright © 2020 3Squared Ltd. All rights reserved.
//

import UIKit
import SwiftCSV
import PeakPivot

class FilterViewController: UITableViewController {
    
    enum SelectAllRow {
        static let index = 0
        static let offset = 1
    }
    
    var filters: [BuildPivotFilter]? {
        didSet {
            setupControlVariables()
        }
    }
    var fields: [FilterField]! {
        didSet {
            setupControlVariables()
        }
    }
    
    // Control variables
    var selectedIndexPaths = [IndexPath]()
    fileprivate var allSelectedSectionIndicies: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // When the contentSize changes we want to ammend the preferredContentSize to
        // size correctly when in popover mode
        self.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard let currentWidth = navigationController?.preferredContentSize.width else { return }
        
        let tableContentHeight = tableView.contentSize.height
        let minimumHeight = CGFloat(200)
        let newHeight = tableContentHeight > minimumHeight ? tableContentHeight : minimumHeight
        navigationController?.preferredContentSize = CGSize(width: currentWidth, height: newHeight)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fields.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let field = fields[section]
        return field.values.count + SelectAllRow.offset
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = fields[indexPath.section]
        
        if indexPath.row == SelectAllRow.index {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "selectAll", for: indexPath) as? FieldValueCell else {  fatalError("Cannot get select all cell") }
            cell.accessoryType = allSelectedSectionIndicies.contains(indexPath.section) ? .checkmark : .none
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "value", for: indexPath) as? FieldValueCell else {  fatalError("Cannot get field value cell") }
            
            let value = field.values[indexPath.row - SelectAllRow.offset]
            cell.textLabel?.text = "\(value)"
            cell.accessoryType = selectedIndexPaths.contains(indexPath) ? .checkmark : .none
            
            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        
        // Helper function to remove a section if the select-all row is unselected
        func unselectSelectAllSection(_ section: Int) {
            guard let index = allSelectedSectionIndicies.firstIndex(of: section) else { return }
            allSelectedSectionIndicies.remove(at: index)
        }
        
        if indexPath.row == SelectAllRow.index {
            
            let lastIndex = tableView.numberOfRows(inSection: indexPath.section) - SelectAllRow.offset
            let indexPathsInSection = Array(0...lastIndex).map { IndexPath(row: $0, section: section) }
            
            if allSelectedSectionIndicies.contains(section) { // Unselect all in this section
                
                selectedIndexPaths.removeAll { indexPathsInSection.contains($0) }
                
                unselectSelectAllSection(section)
            }
            else { // Select all in this section
                let unselected = Set(indexPathsInSection).subtracting(selectedIndexPaths)
                selectedIndexPaths.append(contentsOf: unselected)
                allSelectedSectionIndicies.append(section)
            }
            
            tableView.reloadRows(at: indexPathsInSection, with: .automatic)
        }
        else {
            
            // TODO: Only reload section if selected
            unselectSelectAllSection(section)
            
            let selectAllIndexPath = IndexPath(row: SelectAllRow.index, section: section)
            
            if selectedIndexPaths.contains(indexPath) {
                selectedIndexPaths.removeAll { $0 == indexPath }
            }
            else {
                selectedIndexPaths.append(indexPath)
            }
            
            tableView.reloadRows(at: [selectAllIndexPath, indexPath], with: .automatic)
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "header") as? FieldNameHeaderCell else { fatalError("Cannot dequeue header cell") }
        
        let field = fields[section]
        cell.nameLabel.text = "\(field.name)"
        
        return cell.contentView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
}

fileprivate extension FilterViewController {
    
    func setupControlVariables() {
        guard let fields = self.fields else { return }
        selectedIndexPaths = FilterViewController.selectedIndexPaths(from: fields, filters: filters)
        selectedIndexPaths.forEach { tableView.selectRow(at: $0, animated: false, scrollPosition: .none) }
        // If we have a filter then turn off all selected
        if filters != nil {
             allSelectedSectionIndicies = []
         }
        else {
            allSelectedSectionIndicies = (0...fields.count - 1).map { $0 }
        }
    }
}
