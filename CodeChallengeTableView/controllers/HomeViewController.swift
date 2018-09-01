//
//  HomeViewController.swift
//  CodeChallengeTableView
//
//  Created by Vincent Berihuete on 8/31/18.
//  Copyright © 2018 vbchallenges. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerSV: UIStackView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filterView : FilterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - Setup
    func setup(){
        searchController.isActive = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = false
        
        filterView = FilterView(items: ["Suggested", "Viewed", "Favorites"], color: .lightGray, selectedColor: UIColor(red: 233/255, green: 16/255, blue: 27/255, alpha: 1), selectedIndex: 0)
        filterView.delegate = self
        
        self.containerSV.insertArrangedSubview(filterView, at: 0)
        
        self.containerSV.addConstraint(NSLayoutConstraint(item: self.filterView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
    }

}


//MARK: - Search bar

extension HomeViewController: UISearchResultsUpdating{
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterData(searchCriteria: searchController.searchBar.text ?? "")
//        self.tableView.reloadData()
    }
    
    func filterData(searchCriteria: String){
//        filteredData = data.filter({ (message) -> Bool in
//            return (message[DATA.MESSAGE.EMAIL] as? String)?.lowercased().contains(searchCriteria.lowercased()) ?? false || (message[DATA.MESSAGE.NAME] as? String)?.lowercased().contains(searchCriteria.lowercased()) ?? false
//        })
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
}


//MARK: - FilterView Delegate
extension HomeViewController: FilterViewDelegate{
    
    func filterView(selected index: Int) {
//        contentLabel.text = "Selected \(index)"
    }
    
}
