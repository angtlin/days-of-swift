//
//  TipCalcViewController.swift
//  TipCalculator
//
//  Created by Angela Lin on 1/5/17.
//  Copyright © 2017 Angela Lin. All rights reserved.
//

import UIKit

class MealPrice {
    var basePrice: Double = 0
    
    var tipPercentage: Int = 0
    
    var decimalTipPercentage: Double {
        return Double(tipPercentage)/100.0
    }
    
    var calculatedTip: String {
        return String(format: "$%0.2f", basePrice * decimalTipPercentage)
    }
    
    var calculatedTotal: String {
        return String(format: "$%0.2f", basePrice + basePrice * decimalTipPercentage)
    }
    
    var formattedBasePrice: String {
        return String(format: "$%0.2f", basePrice)
    }
    
    init(basePrice: Double, tipPercentage: Int) {
        self.basePrice = basePrice
        self.tipPercentage = tipPercentage
    }
    
}

class TipCalcViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: UI Elements
    
    let mealPriceInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.font = UIFont.systemFont(ofSize: 70)
        //textField.backgroundColor = UIColor.yellow
        textField.keyboardType = .decimalPad
        textField.placeholder = "$0.00"
        return textField
    }()
    
    let tipTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor.blue
        label.textAlignment = .right
        label.text = "Tip (15%):"
        return label
    }()
    
    
    let tipAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor.blue
        label.textAlignment = .right
        label.text = "$0.00" // calculate tip here
        return label
    }()
    
    
    let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor.blue
        label.textAlignment = .right
        label.text = "Total:"
        return label
    }()
    

    let totalAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = UIColor.blue
        label.textAlignment = .right
        label.text = "$0.00" // calculate total here
        return label
    }()
    
    
    var tipSlider: UISlider = {
        let slider = UISlider(frame: CGRect(x: 20, y: 20, width: 100, height: 20))
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.isContinuous = true
        slider.value = 15
        slider.addTarget(self, action: #selector(sliderValueDidChange(sender:)), for: .valueChanged)
        return slider
        }()
    
    
    // MARK: Data variables
    
    var mealPrice = MealPrice(basePrice: 0.0, tipPercentage: 15)
    
    // need computed property here for tip amount
    // " total amount
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        navigationItem.title = "Tip Calculator"
        
        // add all UI elements
        view.addSubview(mealPriceInput)
        view.addSubview(tipTitleLabel)
        view.addSubview(tipAmountLabel)
        view.addSubview(totalTitleLabel)
        view.addSubview(totalAmountLabel)
        view.addSubview(tipSlider)
        
        // set up constraints
        setupUIConstraints()
        
        
        // set up first responder as text field
        mealPriceInput.delegate = self
        mealPriceInput.becomeFirstResponder()
        
    }

    func setupUIConstraints() {
        
        let viewsDictionary = ["mealPriceInput":mealPriceInput, "tipTitleLabel":tipTitleLabel, "tipAmountLabel":tipAmountLabel, "totalTitleLabel":totalTitleLabel, "totalAmountLabel":totalAmountLabel, "tipSlider":tipSlider]
        
        let viewWidth = view.bounds.width
        
        
        // set up constraints for input text box
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-80-[mealPriceInput(80)]", options: [], metrics: nil, views: viewsDictionary))
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[mealPriceInput]-20-|", options: [], metrics: nil, views: viewsDictionary))
        
        // set up constraints for the tip title/amount
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[tipTitleLabel(40)]", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-200-[tipAmountLabel(40)]", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[tipTitleLabel(\(viewWidth/2))]-10-[tipAmountLabel]-20-|", options: [], metrics: nil, views: viewsDictionary))
        
        // set up constraints for the total title/amount
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-250-[totalTitleLabel(40)]", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-250-[totalAmountLabel(40)]", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[totalTitleLabel(\(viewWidth/2))]-10-[totalAmountLabel]-20-|", options: [], metrics: nil, views: viewsDictionary))
        
        
        // set up tip slider
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-300-[tipSlider]", options: [], metrics: nil, views: viewsDictionary))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[tipSlider]-20-|", options: [], metrics: nil, views: viewsDictionary))

    }
    
    
    // set status bar as hidden
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func sliderValueDidChange(sender: UISlider) {
        print("value: \(sender.value)")
        
        self.mealPrice.tipPercentage = Int(sender.value)
        
        updateCalculation()
    }

    //MARK: - Helper Methods
    
    // This is called to remove the first responder for the text field.
    func resign() {
        self.resignFirstResponder()
    }
    
    // This triggers the textFieldDidEndEditing method that has the textField within it.
    //  This then triggers the resign() method to remove the keyboard.
    //  We use this in the "done" button action.
    func endEditingNow(){
        self.view.endEditing(true)
    }
    
    
    //MARK: - Delegate Methods
    
    // When clicking on the field, use this method.
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        // reset the input fieldg
        mealPrice.basePrice = 0
        mealPriceInput.text = ""
        mealPriceInput.placeholder = "$0.00"

        // deactivate slider
        self.tipSlider.isEnabled = false
        
        // Create a button bar for the number pad
        let keyboardDoneButtonView = UIToolbar()
        keyboardDoneButtonView.sizeToFit()
        
        // Setup the buttons to be put in the system.
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.plain, target: self, action: #selector(TipCalcViewController.endEditingNow) )

        let toolbarButtons = [doneButton]
        
        //Put the buttons into the ToolBar and display the tool bar
        keyboardDoneButtonView.setItems(toolbarButtons, animated: false)
        textField.inputAccessoryView = keyboardDoneButtonView
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let basePriceString = textField.text,
            let basePrice = Double(basePriceString) {
            
            self.mealPrice.basePrice = basePrice
            mealPriceInput.text = mealPrice.formattedBasePrice
            print("\n[entered]formatted price: \(mealPrice.formattedBasePrice)")
            
        }
        
        // activate slider
        self.tipSlider.isEnabled = true
        
        updateCalculation()
        
        resign()
    }
    
    // Clicking away from the keyboard will remove the keyboard.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // called when 'return' key pressed. return NO to ignore.
    // Requires having the text fields using the view controller as the delegate.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Sends the keyboard away when pressing the "done" button
        resign()
        return true
    }
    
    
    // update labels to show calculation/inputs
    
    func updateCalculation() {
        self.tipTitleLabel.text = "Tip (\(mealPrice.tipPercentage)%):"
        self.tipAmountLabel.text = mealPrice.calculatedTip
        self.totalAmountLabel.text = mealPrice.calculatedTotal
    }
}

