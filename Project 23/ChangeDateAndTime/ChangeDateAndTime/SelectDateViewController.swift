//
//  SelectDateViewController.swift
//  ChangeDateAndTime
//
//  Created by Angela Lin on 1/13/17.
//  Copyright © 2017 Angela Lin. All rights reserved.
//

import UIKit

class SelectDateViewController: UIViewController {
    
    // MARK:- UI Variables
    
    var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        picker.backgroundColor = UIColor.white
        return picker
    }()
    
    var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .time
        picker.backgroundColor = UIColor.white
        return picker
    }()
    
    var todaysDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Today is: "
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = UIColor.gray
        label.numberOfLines = 1
        return label
    }()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        //todaysDateFormatter.dateFormat = "MMMM d, yyyy"
        dateFormatter.dateFormat = "MMMM d, yyyy 'at' h:mm a"
        return dateFormatter
    }()
    
    var todaysDate: Date = Date()
    var dateToDisplay: Date = Date()
    
    // MARK:- ViewController Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Set Date and Time"
        view.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 235/255, alpha: 1.0)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(clickCancel(sender:)))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(clickDone(sender:)))
        
        // set up picker views
        view.addSubview(todaysDateLabel)
        view.addSubview(datePicker)
        view.addSubview(timePicker)
        setupPickerViews()
        
        // add functions to picker view to detect when value changed 
        
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(sender:)), for: .valueChanged)
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: .valueChanged)
        
        // set up todays date (always show today's date)
        updateTodaysDateLabel()
        
        // IF ALREADY SELECTED FROM PICKER BEFORE....
        updatePickerDate()
        
    }

    // MARK:- Functions
    func clickCancel(sender: UIBarButtonItem) {
        print(">>Cancel")
        dismiss(animated: true, completion: nil)
    }
    
    func clickDone(sender: UIBarButtonItem) {
        print(">>Done")
        
        // get the Date from the todaysDate that was passed over from 1st view controller
//        guard let todaysDateValue = todaysDateLabel.text else {
//           print("error")
//            return
//        }
        //let previousDate = dateFormatter.date(from: todaysDateValue)
        
        var combinedDate = Date()
        
        // Read the date/time from the 2 UIDatePickers
        let date = datePicker.date
        let time = timePicker.date
        
        // Get BOTH datepicker and timepicker INTO ONE DATE
        let calendar = NSCalendar.current
        
        let timeComponents = calendar.dateComponents([.hour, .minute], from: time)
        var dateComponents = calendar.dateComponents([.month, .day, .year], from: date)
        dateComponents.hour = timeComponents.hour
        dateComponents.minute = timeComponents.minute
        
        guard let fullDateFromComponents = calendar.date(from: dateComponents) else {
            fatalError("ERROR: could not combine time and date")
        }
        combinedDate = fullDateFromComponents
  
        if let parentVC = self.presentingViewController as? MainViewController {
            print("PASSS selectedDate back to 1st view -> \(dateFormatter.string(from:datePicker.date))")
            parentVC.todaysDate = combinedDate
        }
        
        // close the viewcontroller
        dismiss(animated: true, completion: nil)
    }
    
    
    func setupPickerViews() {
        todaysDateLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true
        todaysDateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        todaysDateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        todaysDateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        todaysDateLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        datePicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        datePicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        datePicker.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        datePicker.topAnchor.constraint(equalTo: todaysDateLabel.bottomAnchor, constant: 0).isActive = true

        timePicker.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        timePicker.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        timePicker.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 20).isActive = true

    }
    
    func datePickerValueChanged(sender: UIDatePicker) {
        print("changed DATE")
    }
    
    func timePickerValueChanged(sender: UIDatePicker) {
        print("changed TIME")
    }
    
    func updateTodaysDateLabel() {
        todaysDateLabel.text = "Today's date: \(dateFormatter.string(from: todaysDate))"
    }
    
    func updatePickerDate() {
        datePicker.date = dateToDisplay
        //timePicker.date =
    }
}
