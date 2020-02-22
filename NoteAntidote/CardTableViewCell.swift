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
    
    lazy var backView: UIView = {
//        let view = UIView(frame: CGRect(x: 10, y: 6, width: self.frame.width, height: self.backViewSize))
        let view = UIView(frame: CGRect(x: 10, y: 0, width: self.frame.width, height: self.frame.height))
        view.backgroundColor = UIColor.cyan
        return view
    }()
    
    
    let cardTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "This is shit"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let cardDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This is other shit"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        addSubview(backView)
//        // Configure the view for the selected state
//    }
//    
    func setUpViews() {
        self.addSubview(cardTitleLabel)
        self.addSubview(cardDescriptionLabel)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-20-[v0][v1]-20-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cardTitleLabel, "v1": cardDescriptionLabel]))

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-35-[v0]-0-[v1]-10-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cardTitleLabel, "v1": cardDescriptionLabel]))
        
//
//        self.addSubview(cardDescriptionLabel)
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-100-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cardDescriptionLabel]))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V|-5-[v0]|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0": cardDescriptionLabel]))
        //background view
               
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
