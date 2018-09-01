//
//  HomeViewController.swift
//  CodeChallengeTableView
//
//  Created by Vincent Berihuete on 8/31/18.
//  Copyright © 2018 vbchallenges. All rights reserved.
//

import UIKit
import SVProgressHUD

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerSV: UIStackView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filterView : FilterView!
    var events: [Event] = []
    var filteredEvents: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        SVProgressHUD.show()
        EventConfigurator.shared.loadEvents{ events, statusCode in
            SVProgressHUD.dismiss()
            guard let code = statusCode, code == 200 else{
                SVProgressHUD.showError(withStatus: String.localizedStringWithFormat(NSLocalizedString("home.event.load.error", comment: "The error shown when loading the events"), statusCode ?? 0))
                return
            }
            self.events = events
            self.tableView.reloadData()
        }
    }
    
    // MARK - Setup
    func setup(){
        searchController.isActive = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("home.searchbar.placeholder", comment: "The search bar placeholder in the home tab")
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = false
        
        self.tableView.dataSource = self
        
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
        self.tableView.reloadData()
    }
    
    func filterData(searchCriteria: String){
        EventConfigurator.shared.filterEvents(with: searchCriteria, on: self.events){ filteredEvents in
            self.filteredEvents = filteredEvents
        }
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
    }
    
}


//MARK: - Tableview Datasource

extension HomeViewController: UITableViewDataSource{
//    homeeventscell
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering() ? filteredEvents.count : events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeeventscell") as? HomeEventsTableViewCell else{
            return UITableViewCell()
        }
        let events : [Event] = isFiltering() ? self.filteredEvents : self.events
        cell.setup(with: events[indexPath.row], in: indexPath)
        cell.delegate = self
        return cell
    }
}


//MARK: - Home event cell delegate

extension HomeViewController: HomeEventsCellDelegate{
    func homeEvent(favorite at: IndexPath, select: Bool) {
        
        self.events[at.row].favorite = select
        if isFiltering(){
            self.filteredEvents[at.row].favorite = select
        }
    }
    
    func homeEvent(selectEvent at: IndexPath) {
    }
    
    
}
