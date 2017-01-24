//
//  MoviesTableViewController.swift
//  StickySectionHeaders
//
//  Created by Angela Lin on 1/20/17.
//  Copyright © 2017 Angela Lin. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    
    var moviesDataSource = [Movie]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData() }
            }
        }
    
    var cellId = "cellId"
    
    var sortedFirstLetters = [String]()
    
    var sections = [[Movie]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Movies"
        
        // Register tableview cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        // Get data from Json file
        let movieManager = MoviesManager()
        moviesDataSource = movieManager.getMovieDataFromJson()
        
        
        // Map all first letters into separate array
        let firstLetters = moviesDataSource.map { $0.titleFirstLetter }
        
        // Remove duplicates
        let uniqueFirstLetters = Array(Set(firstLetters))
        
        // Sort them, this is the index
        self.sortedFirstLetters = uniqueFirstLetters.sorted()
        self.sections = sortedFirstLetters.map { firstLetter in
            return moviesDataSource
                .filter { $0.titleFirstLetter == firstLetter } // get the titles with matching first letter
                .sorted { $0.title < $1.title } // sort them and saved into new array (sections)
        }
        
    }
    
    // MARK: - Table view data source

    // SECTION METHODS
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
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
        
        return sections[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        cell.textLabel?.text = sections[indexPath.section][indexPath.row].title

        return cell
    }
    
}

extension Movie {
    var titleFirstLetter: String {
        return String(self.title[self.title.startIndex]).uppercased()
    }
}
