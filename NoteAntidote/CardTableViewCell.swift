//
//  CardTableViewCell.swift
//  NoteAntidote
//
//  Created by Лиза  Малиновская on 2/17/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    
    //MARK: - properties
    
    var safeArea = UILayoutGuide()
    var backViewSize: CGFloat = 55
    var cards: [Card] = []
    
    lazy var backView: UIView = {
        let rect = CGRect(x: 10, y: 0, width: self.frame.width, height: self.frame.height)
        let view = UIView(frame: rect)
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.backgroundColor = UIColor.cyan
        return view
    }()
    
    
    let cardTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "This is shit"
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This is other shit"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    //initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        safeArea = self.layoutMarginsGuide
        addSubview(backView)
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - setting up labels and backview constraints
    func setUpViews() {
        self.addSubview(cardTitleLabel)
        self.addSubview(cardDescriptionLabel)
        
        let views = ["title": cardTitleLabel,
                     "description": cardDescriptionLabel]
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-20-[title]-0-[description(40)]", options: NSLayoutConstraint.FormatOptions.alignAllLeading, metrics: nil, views: views)
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-30-[title]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: views)
        addConstraints(verticalConstraints)
        addConstraints(horizontalConstraints)
 
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": backView]))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[v0]-5-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": backView]))
   

       backView.translatesAutoresizingMaskIntoConstraints = false
       
       backView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
       backView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
       backView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
       backView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
       backView.backgroundColor = .systemYellow
        
        
    }

}
