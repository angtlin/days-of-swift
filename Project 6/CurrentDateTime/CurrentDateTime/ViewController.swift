//
//  ViewController.swift
//  CurrentDateTime
//
//  Created by Angela Lin on 1/10/17.
//  Copyright © 2017 Angela Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK:- IBOutlets
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var refreshButton: UIButton!
    
    // MARK:- Data variables
    
    var date = Date()
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        return dateFormatter
    }()
    
    
    // MARK:- ViewController Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dateLabel.text = dateFormatter.string(from: date)
        
        
        refreshButton.addTarget(self, action: #selector(clickRefresh(sender:)), for: .touchUpInside)
        
    }
    
    func clickRefresh(sender: UIButton) {
        date = Date()
        self.dateLabel.text = dateFormatter.string(from: date)
        
    }
}

