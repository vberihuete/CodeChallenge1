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
    
    private let searchController = UISearchController(searchResultsController: nil)
    private let refreshControl = UIRefreshControl()
    
    var filterView : FilterView!
    private var events: [Event] = []
    private var filteredEvents: [Event] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadEvents()
    }
    
    // MARK: - Setup
    
    
    /// Initial setup for views
    func setup(){
        searchController.isActive = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = NSLocalizedString("home.searchbar.placeholder", comment: "The search bar placeholder in the home tab")
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = false
        
        self.refreshControl.addTarget(self, action: #selector(self.refreshAction(_:)), for: .valueChanged)
        self.refreshControl.tintColor =  COLORS.RED
        self.refreshControl.attributedTitle = NSAttributedString(string: NSLocalizedString("home.event.load.refresh.message", comment: "Loading message to refresh"))
        
        self.tableView.addSubview(refreshControl)
        self.tableView.dataSource = self
        
        filterView = FilterView(items: ["Suggested", "Viewed", "Favorites"], color: .lightGray, selectedColor: COLORS.RED, selectedIndex: 0)
        filterView.delegate = self
        
        self.containerSV.insertArrangedSubview(filterView, at: 0)
        
        self.containerSV.addConstraint(NSLayoutConstraint(item: self.filterView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
        
        //nav bar buttons
        
        let locationFilter = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        locationFilter.addConstraint(NSLayoutConstraint(item: locationFilter, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 20))
        locationFilter.addConstraint(NSLayoutConstraint(item: locationFilter, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 24))
        locationFilter.setImage(#imageLiteral(resourceName: "location_nbar"), for: UIControlState())
        locationFilter.alpha = 0.7
//        locationFilter.addTarget(self, action: #selector(self.likeAction), for:  UIControlEvents.touchUpInside)
        let locationButton = UIBarButtonItem(customView: locationFilter)
        
        let tuneFilter = UIButton(frame: CGRect(x: 0, y: 0, width: 24, height: 24))
        tuneFilter.addConstraint(NSLayoutConstraint(item: tuneFilter, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 24))
        tuneFilter.addConstraint(NSLayoutConstraint(item: tuneFilter, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 24))
        tuneFilter.setImage(#imageLiteral(resourceName: "filter_tune_nbar"), for: UIControlState())
        tuneFilter.alpha = 0.7
        //        locationFilter.addTarget(self, action: #selector(self.likeAction), for:  UIControlEvents.touchUpInside)
        let tuneButton = UIBarButtonItem(customView: tuneFilter)
        
        self.navigationItem.rightBarButtonItems = [tuneButton, locationButton]
    }
    
    // MARK: - Action
    
    /// Handles the event load
    func loadEvents(){
        if events.isEmpty{
            SVProgressHUD.show()
        }
        EventConfigurator.shared.loadEvents{ events, statusCode in
            SVProgressHUD.dismiss()
            guard let code = statusCode, code == 200 else{
                SVProgressHUD.showError(withStatus: String.localizedStringWithFormat(NSLocalizedString("home.event.load.error", comment: "The error shown when loading the events"), statusCode ?? 0))
                return
            }
            self.events = events
            self.tableView.reloadData()
        }
        self.refreshControl.endRefreshing()
    }
    
    /// The refresh action
    ///
    /// - Parameter sender: The sender usually self
    @objc func refreshAction(_ sender: Any){
        loadEvents()
    }

}


//MARK: - Search bar


// MARK: - Search Results Delegate
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
