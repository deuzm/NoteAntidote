//
//  ViewController.swift
//  NoteAntidote
//
//  Created by Лиза  Малиновская on 2/17/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    //properties:
//    var cardTableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Cards"
        
//        setCardTableView()
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
        // Do any additional setup after loading the view.
    }

    //MARK: View Making methods
    func makeButtonWithText(text:String) -> UIButton {
        let myButton = UIButton(type: UIButton.ButtonType.system)
        myButton.frame = CGRect(x: 30, y: 30, width: 150, height: 150)
        return myButton
    }
    
//    func setCardTableView() {
//
//        //setting up appearance
//        cardTableView.frame = self.view.frame
//        cardTableView.backgroundColor = .red
//        cardTableView.separatorColor = .clear
//
//        cardTableView.cellLayoutMarginsFollowReadableWidth = true
//
//        //delegating cardTableView
//        cardTableView.delegate = self
//        cardTableView.dataSource = self
//
//        //adding cardTableView to main view
//        self.view.addSubview(cardTableView)
//
//        //registering a class for creation of new cells
//        cardTableView.register(CardTableViewCell.self, forCellReuseIdentifier: "Cell")
//
//    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .systemIndigo
        footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:
        50)
        let button = UIButton()
        button.frame = CGRect(x: 5, y: 5, width: 300, height: 30)
        button.setTitle("CustomButton", for: .normal)
        button.setTitleColor( .black, for: .normal)
        button.backgroundColor = .white
        footerView.addSubview(button)
        return footerView
    }
    
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 50
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
//    }

 
}



