//
//  ViewController.swift
//  TapCounter
//
//  Created by Angela Lin on 11/28/16.
//  Copyright © 2016 Angela Lin. All rights reserved.
//

import UIKit

class TapViewController: UIViewController {

    @IBOutlet weak var counterLabel: UILabel!
    
    @IBOutlet weak var tapButton: UIButton!
    

    var counterNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Counter"
        
        
        // Reset button as UIBarButtonItem on left side
        
        let resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(myRightSideBarButtonItemTapped(_:)))

        self.navigationItem.leftBarButtonItem = resetButton
        
        // Tap button
        
        tapButton.addTarget(self, action: #selector(tapButtonTapped(_:)), for: .touchUpInside)
        
        // Set up counter display
        
        counterLabel.text = String(counterNumber)
        
        // Set up longpress gesture recognize
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(tapButtonTappedWithLongPress))
    
        longPress.minimumPressDuration = 0.5
        tapButton.addGestureRecognizer(longPress)
        
    }

    func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem)
    {
        self.counterNumber = 0
        
        counterLabel.text = String(counterNumber)
        
        counterLabel.setNeedsDisplay()
    }

    func tapButtonTapped(_ sender: UIButton) {
        self.counterNumber += 1
        
        counterLabel.text = String(counterNumber)
        
        counterLabel.setNeedsDisplay()
    }
    
    func tapButtonTappedWithLongPress(_ sender: UIButton) {
        self.counterNumber += 1
        
        counterLabel.text = String(counterNumber)
        
        counterLabel.setNeedsDisplay()
    }
    
}

