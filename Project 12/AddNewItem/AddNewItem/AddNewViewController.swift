//
//  ViewController.swift
//  AddNewItem
//
//  Created by Angela Lin on 1/17/17.
//  Copyright © 2017 Angela Lin. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController, UITextFieldDelegate {
    
    // MARK:- UI Variables
    // use a input box for add new movie
    var movieInput: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = UIColor.white
        return textField
    }()

    // MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        self.navigationItem.title = "New Movie"
        
        // add UI
        view.addSubview(movieInput)
        
        setupConstraints()
        
        // set keyboard to show when loaded
        movieInput.becomeFirstResponder()
        
        // set return key as "Done"
        movieInput.returnKeyType = .done
        
        movieInput.delegate = self
        // keyboard must have Done button function .... so that it can be saved to array in previous VC & dismiss view controller
        
    }
    
    // MARK:- Functions
    func setupConstraints() {
        
        movieInput.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        movieInput.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
        
        // note: shoudl use topLayoutGuide's bottomAnchor (instead of view) if want the uiItem to appear below the navigation bar
        movieInput.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 10).isActive = true
        movieInput.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        print("textFieldShouldReturn")
        
        textField.resignFirstResponder()
        
        guard let newMovieString = movieInput.text else {
            // do popup error
            fatalError()
        }
        
    print("The first viewcontroller in nav stack --> \(self.navigationController?.viewControllers.first)")
        
        if let previousVC = self.navigationController?.viewControllers.first as? MovieTableViewController {
            
            previousVC.localMovieSource.append(newMovieString)
            
            self.navigationController?.popViewController(animated: true)
        }
        
        return true
    }
    
    deinit {
        print("[DEINIT] AddNewViewController")
    }
}

