//
//  MainViewController.swift
//  ChangeDateAndTime
//
//  Created by Angela Lin on 1/13/17.
//  Copyright © 2017 Angela Lin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    // MARK:- UI Variables
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Date"
        return label
    }()
    
    var changeDateButton: UIButton = {
        
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Change Date", for: .normal)
        button.sizeToFit()
        return button
    }()
    
    var todaysDate: Date = Date()
    
    
    // MARK:- ViewController Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)

        updateTodaysDateLabel()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        view.addSubview(dateLabel)
        view.addSubview(changeDateButton)
        setupLabelAndButton()
        
        updateTodaysDateLabel()
        
        // attach function to button
        changeDateButton.addTarget(self, action: #selector(clickChangeDate(sender:)), for: .touchUpInside)
        
        
    }

    // MARK:- Functions
    
    private func setupLabelAndButton() {
        
        dateLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        changeDateButton.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20).isActive = true
        changeDateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
    
    func clickChangeDate(sender: UIButton) {

        let selectDateVC = SelectDateViewController()
        selectDateVC.dateToDisplay = self.todaysDate
        
        let nextVC = UINavigationController(rootViewController: selectDateVC)
        
        self.present(nextVC, animated: true, completion: nil)
        
    }

    func updateTodaysDateLabel() {
        
        let dateFormatter = DateFormatter()
        // need to use single quotes to insert a string in date formatter
        dateFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        dateLabel.text = dateFormatter.string(from: todaysDate)
        
    }
 
}



