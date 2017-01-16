//
//  MovieTableViewController.swift
//  BasicTableView
//
//  Created by Angela Lin on 1/17/17.
//  Copyright © 2017 Angela Lin. All rights reserved.
//

import UIKit

class MovieTableViewController: UITableViewController {
    
    private let cellId = "cellId"
    var localMovieSource = ["Iron Man", "Spiderman", "Batman"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set up navigation
        
        self.navigationItem.title = "Movies"

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.leftBarButtonItem = editButtonItem
        
        // Set up table view, register reuse id
        tableView?.register(MovieTableViewCell.self, forCellReuseIdentifier: cellId)
        
        tableView.separatorStyle = .singleLine
    }

    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return localMovieSource.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! MovieTableViewCell
        
        print("\(indexPath.row) / \(localMovieSource.count): \(localMovieSource[indexPath.row])")
        
        // set movie Text from local array
        cell.textLabel?.text = localMovieSource[indexPath.row]

        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        return cell
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data source
            let index = indexPath.row
            localMovieSource.remove(at: index)
            
            print("deleted index: \(index). now total array count: \(localMovieSource.count)")
            
            
            // animate removal
            tableView.deleteRows(at: [indexPath], with: .fade)

            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
