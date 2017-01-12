//
//  ViewController.swift
//  SettingTheDate
//
//  Created by Angela Lin on 1/10/17.
//  Copyright © 2017 Angela Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var setDateButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Date"
        
        // add function to SetDate button
        setDateButton.setTitle("Set Date", for: .normal)
        setDateButton.addTarget(self, action: #selector(clickSetDate(sender:)), for: .touchUpInside)
        
        // add function to datePicker
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(selectDate(sender:)), for: .valueChanged)
    }

    func clickSetDate(sender: UIButton) {
        print("clicked uibutton")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        self.navigationItem.title = dateFormatter.string(from: datePicker.date)
    }
    
    func selectDate(sender: UIDatePicker) {
        print("uidatepicker was changed")
        
    }
}

