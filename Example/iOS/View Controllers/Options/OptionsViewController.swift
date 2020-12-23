//
//  SortFilterViewController.swift
//  PeakPivot
//
//  Created by Luke Stringer on 08/02/2020.
//  Copyright © 2020 3Squared Ltd. All rights reserved.
//

import UIKit
import PeakPivot

class OptionsViewController: UIPageViewController {

    var fields: [FilterField]!
    var filters: [BuildPivotFilter]? {
        get {
            return newFilters
        }
        set {
            initialFilters = newValue
        }
    }
    
    var selectedSortDescriptor: BuildPivotDescriptor? {
        get {
            return newSelectedSortDescriptor
        }
        set {
            initialSelectedSortDescriptor = newValue
        }
    }
    
    var zeroRowsEnabled: Bool? {
        get {
            return newZeroRowsEnabled
        }
        set {
            initalZeroRowsEnabled = newValue
        }
    }
    
    // Keep initial values so we can reset them on cancel
    fileprivate var initialFilters: [BuildPivotFilter]?
    fileprivate var initialSelectedSortDescriptor: BuildPivotDescriptor?
    fileprivate var initalZeroRowsEnabled: Bool?
    
    fileprivate var newFilters: [BuildPivotFilter]?
    fileprivate var newSelectedSortDescriptor: BuildPivotDescriptor?
    fileprivate var newZeroRowsEnabled: Bool?

    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    enum PageIndex: Int {
        case filter = 0
        case sort = 1
        case config = 2
    }

    var filterVC: FilterViewController!
    var sortVC: SortViewController!
    var configVC: ConfigViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        filterVC = storyboard?.instantiateViewController(identifier: "filter") as? FilterViewController
        filterVC.filters = initialFilters
        filterVC.fields = fields
        
        sortVC = (storyboard?.instantiateViewController(identifier: "sort") as! SortViewController)
        sortVC.selectedSortDescriptor = initialSelectedSortDescriptor
        
        configVC = (storyboard?.instantiateViewController(identifier: "config") as! ConfigViewController)
        configVC.zeroRowsEnabled = initalZeroRowsEnabled
        
        setViewControllers([filterVC], direction: .forward, animated: true, completion: nil)
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        enum PageIndex: Int {
            case filter = 0
            case sort = 1
            case config = 2
        }
        
        guard
            let control = sender as? UISegmentedControl,
            let index = PageIndex(rawValue: control.selectedSegmentIndex) else { return }
        
        switch index {
        case .filter:
            setViewControllers([filterVC], direction: .reverse, animated: true, completion: nil)
        case .sort:
            let comingFromFilter = viewControllers?.contains(filterVC) ?? true
            let direction: UIPageViewController.NavigationDirection = comingFromFilter ? .forward : .reverse
            setViewControllers([sortVC], direction: direction, animated: true, completion: nil)
        case .config:
            setViewControllers([configVC], direction: .forward, animated: true, completion: nil)
        }
    }

}

fileprivate extension OptionsViewController {
    @IBAction func applyTapped(_ sender: Any) {

        if filterVC.selectedIndexPaths.count == 0 {
            let alert = UIAlertController(title: "Cannot Apply Filter", message: "You need to select a field name and at least 1 value to apply as a filter.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        newFilters = FilterViewController.filters(from: fields, selectedIndexPaths: filterVC.selectedIndexPaths)
        newSelectedSortDescriptor = sortVC.selectedSortDescriptor
        newZeroRowsEnabled = configVC.zeroRowsEnabled
        
        performSegue(withIdentifier: "unwindToPivot", sender: self)
    }
    
    @IBAction func cancellTapped(_ sender: Any) {
        newFilters = initialFilters
        newSelectedSortDescriptor = initialSelectedSortDescriptor
        newZeroRowsEnabled = initalZeroRowsEnabled
        performSegue(withIdentifier: "unwindToPivot", sender: self)
    }
}

