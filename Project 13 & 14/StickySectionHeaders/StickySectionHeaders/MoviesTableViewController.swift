//
//  MoviesTableViewController.swift
//  StickySectionHeaders
//
//  Created by Angela Lin on 1/20/17.
//  Copyright © 2017 Angela Lin. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    // MARK:- Properties/Variables
    
    var moviesDataSource = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData() }
            }
        }
    
    var cellId = "cellId"
    
    var sortedFirstLetters = [String]()
    
    var sections = [[Movie]]()
    
    var filteredMovies = [Movie]()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK:- UI View
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Movies"
        
        // Register tableview cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        // Get data from Json file
        let movieManager = MoviesManager()
        moviesDataSource = movieManager.getMovieDataFromJson()
        
        // SEt up index
        setupSectionsIndex(movieSource: moviesDataSource)
        tableView.sectionIndexBackgroundColor = UIColor.clear
        tableView.sectionIndexTrackingBackgroundColor = UIColor.clear
        
        // Add search bar set up
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        
    }
    
    // MARK:- Helper functions
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredMovies = moviesDataSource.filter { movie in
            return movie.title.lowercased().contains(searchText.lowercased())
        }
        
        print("filtered count: \(self.filteredMovies.count) . nonfiltered count: \(self.moviesDataSource.count)")
        setupSectionsIndex(movieSource: filteredMovies)
        tableView.reloadData()
    }
    
    func setupSectionsIndex(movieSource: [Movie]) {
        // Map all first letters into separate array
        let firstLetters = movieSource.map { $0.titleFirstLetter }
        
        // Remove duplicates
        let uniqueFirstLetters = Array(Set(firstLetters))
        
        // Sort them, this is the index
        self.sortedFirstLetters = uniqueFirstLetters.sorted()
        self.sections = sortedFirstLetters.map { firstLetter in
            return movieSource
                .filter { $0.titleFirstLetter == firstLetter } // get the titles with matching first letter
                .sorted { $0.title < $1.title } // sort them and saved into new array (sections)
        }

    }
    
    // MARK: - Table view data source

    // SECTION METHODS
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            setupSectionsIndex(movieSource: filteredMovies)
        } else {
            setupSectionsIndex(movieSource: moviesDataSource)
        }
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sortedFirstLetters[section]
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        // this is the method for the floating index on right side of tableview
        
        return sortedFirstLetters
    }
    
    
    // ROW METHODS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            setupSectionsIndex(movieSource: filteredMovies)
        } else {
            setupSectionsIndex(movieSource: moviesDataSource)
        }
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        if searchController.isActive && searchController.searchBar.text != "" {
            setupSectionsIndex(movieSource: filteredMovies)
        } else {
            setupSectionsIndex(movieSource: moviesDataSource)
        }
        
        cell.textLabel?.text = sections[indexPath.section][indexPath.row].title

        return cell
    }
    
}

extension Movie {
    var titleFirstLetter: String {
        return String(self.title[self.title.startIndex]).uppercased()
    }
}

extension MoviesTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        print(">> running UISearchResultsUpdating for \(searchBar.text)")
        filterContentForSearchText(searchText: searchBar.text!)
    }
}
