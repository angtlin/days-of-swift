//
//  MovieTableViewCell.swift
//  BasicTableView
//
//  Created by Angela Lin on 1/17/17.
//  Copyright © 2017 Angela Lin. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    var movieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        return label
    }()
    
    // Note: awakwFromNib only gets called if use xib or storyboard so use init(style:..) instead.
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "cellId")
        print(" >> cell init")

        addSubview(movieLabel)
        setupLabel()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupLabel() {
        movieLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        movieLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
    }
}
