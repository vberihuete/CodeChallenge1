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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        EventConfigurator.shared.loadEvents{ events, statusCode in
            guard let code = statusCode, code == 200 else{
                SVProgressHUD.showError(withStatus: "Couldn't load the events (Error \(statusCode ?? 0))") //TODO: Change to localized string
                return
            }
            self.events = events
            self.tableView.reloadData()
        }
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


//MARK: - Tableview Datasource

extension HomeViewController: UITableViewDataSource{
//    homeeventscell
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "homeeventscell") as? HomeEventsTableViewCell else{
            return UITableViewCell()
        }
        
        cell.setup(with: events[indexPath.row], in: indexPath)
        cell.delegate = self
        return cell
    }
}


//MARK: - Home event cell delegate

extension HomeViewController: HomeEventsCellDelegate{
    func homeEvent(favorite at: IndexPath, select: Bool) {
        self.events[at.row].favorite = select
        print("favorite selected at \(at.row)")
    }
    
    func homeEvent(selectEvent at: IndexPath) {
        print("Event selected at \(at.row)")
    }
    
    
}
