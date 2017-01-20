//
//  GroceriesTableViewController.swift
//  PullToRefreshTableView
//
//  Created by Angela Lin on 1/19/17.
//  Copyright © 2017 Angela Lin. All rights reserved.
//

import UIKit

class GroceryTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class GroceriesTableViewController: UITableViewController {
    
    private let cellId = "cellId"
    var groceryList = ["Milk", "Apple", "Ham", "Eggs", "Pizza", "Flour", "Onions", "Peppers", "Strawberries", "Cheese"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Groceries"
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(clickAddNew(sender:)))
        
        tableView.register(GroceryTableViewCell.self, forCellReuseIdentifier: cellId)
        
        // Refresh control is already built into UITableViewController, need to declare a new one first and then set it to the already built-in one.
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh(sender:)), for: .valueChanged)
        
        self.refreshControl = refreshControl
    }
    
    // MARK: Functions
    
    func clickAddNew(sender: UIBarButtonItem) {
        print("Clicked +")
        
        let alert = UIAlertController(title: "Grocery List", message: "What do you want to add?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: {
            something in
            
            if let textField = alert.textFields?.first,
                let newItem = textField.text {
                
                self.groceryList.append(newItem)
                print("New item added -> \(newItem)")
                
                let doneAlert = UIAlertController(title: "Added!", message: "Pull to refresh to see your added item(s)", preferredStyle: .alert)
                self.present(doneAlert, animated: true, completion: { done in
                    
                    self.perform(#selector(self.dismiss(sender:)), with: doneAlert, afterDelay: 1)
                }
                )
            }
        } ))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: {(textField) in
            textField.placeholder = "Enter item"
            
        })
        
        present(alert, animated: true, completion: nil)
    }
    
    func dismiss(sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func handleRefresh(sender: AnyObject) {
        print("Pulled refresh control")
        
        tableView.reloadData()
        
        refreshControl?.endRefreshing()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groceryList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! GroceryTableViewCell
        
        cell.textLabel?.text = groceryList[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        
        return cell
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            print("Item to remove ->  \(groceryList[indexPath.row])")
            groceryList.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
    
    
}
