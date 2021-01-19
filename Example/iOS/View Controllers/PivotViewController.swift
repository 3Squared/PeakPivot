//
//  PivotViewController.swift
//  PeakPivot Example
//
//  Created by Luke Stringer on 31/12/2019.
//

import UIKit
import PeakPivot
import SwiftCSV

class PivotViewController: UITableViewController {
    
    /// Defines how the Pivot is created, either from an existing builder or from scratch using fields
    enum DataSource {
        case builder(builder: BuildPivot)
        case fields(fieldNames: [FieldName]?)
    }
    
    // MARK: Public Vars
    var dataSource: DataSource!
    var csv: CSV!
    var metaFieldRules: [MetaFieldRule]? = nil
    
    // MARK: Private Vars
    fileprivate var pivot: Pivot!
    fileprivate var pivotRows: [PivotRow]!
    fileprivate var builder: BuildPivot!
    
    // MARK: IBOutlets
    @IBOutlet weak var optionsButton: UIBarButtonItem!
    @IBOutlet weak var exportButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch dataSource! {
            
        case .builder(let existingBuilder):
            builder = existingBuilder
            
        case .fields(let fieldNames):
            
            builder = PivotBuilder()

            builder.fields = fieldNames
            builder.sortDescriptor = BuildPivotDescriptor.byTitle(ascending: true)
        }
        
        if let table = csv?.namedRows {
            
            // If we have meta rules then generate an augmented table containing them
            if let rules = metaFieldRules {
                let metaBuilder = MetaTableBuilder()
                metaBuilder.source = table
                metaBuilder.rules = rules

                let metaTable = try! metaBuilder.build()

                builder.table = metaTable
            }
            else {
                builder.table = table
            }
        }
        
        builder.sumsEnabled = true
        
        runBuilder(reload: false)
        
    }

    
}

// MARK: - Table view
extension PivotViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pivotRows.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = pivotRows[indexPath.row]
        let sumValue = row.value.sum
        let identifer = sumValue != nil ? "countAndSumCell" : "countCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifer, for: indexPath) as? PivotTableViewCell else {
            fatalError("Cannot dequeue PivotCell")
        }
        
        
        let rowTitle = row.title
        let indent = String.init(repeating: "  ", count: row.level*3)
        let rowText = row.level > 0 ? "\(indent)| \(rowTitle)" : "\(rowTitle)"
        
        cell.valueLabel.text = rowText
        cell.countLabel.text = "\(row.value.count)"
        if let sum = sumValue {
            cell.sumLabel.text = "\(sum) ∑"
        }
        
        // TODO: Fix crash - Float value cannot be converted to Int because it is either infinite or NaN
        if let percentage = row.value.percentage, !percentage.isNaN {
            cell.percentageLabel.text = "\(Int(percentage * 100))%"
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = pivotRows[indexPath.row]
        if let _ = row.value.sum {
            return 70
        }
        return 60
    }
}

// MARK: - Actions and segues
extension PivotViewController {

}

fileprivate extension PivotViewController {
    
    func runBuilder(reload: Bool = true) {
        pivot = try! builder.build()
        pivotRows = pivot.rows.flatten()
        
        title = "Total: \(pivot.total)"
        
        if reload {
            tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
}

extension Array where Element == PivotRow {
    func flatten() -> [PivotRow] {
        return compactMap { flattenRow($0) }.flatMap { $0 }
    }
    
    private func flattenRow(_ row: PivotRow) -> [PivotRow]? {
        guard let subRows = row.subRows, subRows.count > 0 else {
            return [row]
        }
        
        let flattenedSubRows = subRows.compactMap { flattenRow($0) }.flatMap { $0 }
        return [row] + flattenedSubRows
    }
}
