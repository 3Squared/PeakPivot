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
            
            builder = PivotBuilder.Custom()

            builder.fields = fieldNames
            builder.sortDescriptor = BuildPivotDescriptor.byTitle(ascending: true)
        }
        
        // We'll only have a CSV if coming from an app selection
        // We won't have a CSV if we come from history, instead a builder with a table will be supplied instead
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
        
        runBuilder(reload: false)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setToolbarHidden(true, animated: true)
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? PivotTableViewCell else {
            fatalError("Cannot dequeue PivotCell")
        }
        
        let row = pivotRows[indexPath.row]
        
        let rowTitle = row.title
        let indent = String.init(repeating: "  ", count: row.level*3)
        let rowText = row.level > 0 ? "\(indent)| \(rowTitle)" : "\(rowTitle)"
        
        cell.valueLabel.text = rowText
        cell.countLabel.text = "\(Int(row.value.count))"
        
        // TODO: Fix crash - Float value cannot be converted to Int because it is either infinite or NaN
        
        if let percentage = row.value.percentage, !percentage.isNaN {
            cell.percentageLabel.text = "\(Int(percentage * 100))%"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

// MARK: - Actions and segues
extension PivotViewController {
    
    override internal func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {

        case "charts":
//            if let chartViewController = segue.destination as? ChartViewController {
//                chartViewController.app = app
//                chartViewController.rows = pivotRows
//                    // Only use the top level rows
//                    .filter { $0.level == 0 }
//                    // Reverse so chart and table view look same
//                    // Chart will plot from bottom to top, whereas table plots from top to bottom
//                    .reversed()
//                chartViewController.fieldName = builder.fields?.first
//            }
        break

        case "options":
            guard
                let navController = segue.destination as? UINavigationController,
                let optionsVC = navController.topViewController as? OptionsViewController else { return }
            optionsVC.filters = builder.filters
            optionsVC.fields = pivot.filterFields
            optionsVC.selectedSortDescriptor = builder.sortDescriptor
            optionsVC.zeroRowsEnabled = builder.zeroRowsEnabled

            navController.modalPresentationStyle = .popover
            navController.popoverPresentationController?.barButtonItem = optionsButton

        default:
            return
        }
    }
    
    
    @IBAction func unwindToPivot(_ unwindSegue: UIStoryboardSegue) {
        
        guard let optionsVC = unwindSegue.source as? OptionsViewController else { return }
        
        builder.filters = optionsVC.filters
        optionsVC.zeroRowsEnabled.flatMap { builder.zeroRowsEnabled = $0 }
        optionsVC.selectedSortDescriptor.flatMap { builder.sortDescriptor = $0 }
        runBuilder()
    }
    
    @IBAction func exportTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Export Data", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Full CSV", style: .default, handler: { _ in
            self.exportCSV()
        }))
        alert.addAction(UIAlertAction(title: "Pivot Table", style: .default, handler: { _ in
            self.exportPivot()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        alert.popoverPresentationController?.barButtonItem = exportButton
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func saveTapped(_ sender: Any) {
//        let alert = UIAlertController(title: "Save as Template", message: nil, preferredStyle: .alert)
//        alert.addTextField { textField in
//            textField.placeholder = "Template title"
//        }
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
//          alert.dismiss(animated: true, completion: nil)
//        }))
//
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
//            guard let templateTitle = alert.textFields?.first?.text else { return }
//            
//            let savedBuilder = PivotBuilder.Saved.insertObject(in: context) { savedBuilder in
//                savedBuilder.setValues(from: self.builder)
//            }
//            savedBuilder.appBugfenderID = self.app.bugfenderID
//            savedBuilder.title = templateTitle
//            try? context.save()
//        }))
//        
//        present(alert, animated: true, completion: nil)
        
    }
    

}

// MARK: - Exporting
fileprivate extension PivotViewController {
     func exportPivot() {
//        let text = """
//        \(app.title) - \(app.platform)
//        Total: \(pivot.total)
//        \(pivotRows.exportDescription)
//        """
//
//        exportText(text, fileName: "\(app.fileName)_pivot", extension: "txt")
    }
    
    func exportCSV() {
//        exportText(csv.description, fileName: "\(app.fileName)", extension: "csv")
    }
    
    func exportText(_ text: String, fileName fileNamePrefix: String, extension suffix: String) {
//        let textData = text.data(using: .utf8)
//
//        let dateString = Date().fileNameDateString
//        let fileName = "\(fileNamePrefix)_\(dateString).\(suffix)"
//        let textURL = textData?.dataToFile(fileName: fileName)
//
//        var filesToShare = [Any]()
//        filesToShare.append(textURL!)
//
//        let activityViewController = UIActivityViewController(activityItems: filesToShare, applicationActivities: nil)
//        activityViewController.popoverPresentationController?.barButtonItem = exportButton
//        self.present(activityViewController, animated: true, completion: nil)
    }
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
