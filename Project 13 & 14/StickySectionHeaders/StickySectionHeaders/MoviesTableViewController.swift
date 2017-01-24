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
    
    var sectionHeaders = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Movies"
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        
        let movieManager = MoviesManager()
        moviesDataSource = movieManager.getMovieDataFromJson()
        
        
        // Set up the ABC section headings
        let alphabetLetters = "A B C D E F G H I J K L M N O P Q R S T U V W X Y Z"
        sectionHeaders = alphabetLetters.components(separatedBy: " ")
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return sectionHeaders.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
        //return moviesDataSource.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return sectionHeaders[section]
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        cell.textLabel?.text = moviesDataSource[indexPath.row].title

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
