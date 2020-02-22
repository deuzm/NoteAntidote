//
//  CardSetterViewController.swift
//  NoteAntidote
//
//  Created by Лиза  Малиновская on 2/18/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class CardSetterViewController: UITableViewController {
    
    //MARK: - properties
    var tasks: [Task] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Setting up card"
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Outlets
    
    
    
    //MARK: - adding footer
       override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           let footerView = UIView()
           footerView.backgroundColor = .systemIndigo
           footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:
           50)
           let button = makeButtonWithText(text: "Add")
           footerView.addSubview(button)
           button.addTarget(self, action: #selector(addSection), for: .touchUpInside)
           return footerView
       }
       
       override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
           return 50
       }
    
    //MARK: - button funcion
    
    func makeButtonWithText(text:String) -> UIButton {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 10, y: 5, width: self.view.frame.width - 20, height: 30)
        button.setTitle(text, for: .normal)
        button.setTitleColor( .black, for: .normal)
        button.backgroundColor = .white
        return button
    }
    //MARK: - add section
    @objc func addSection() {
        tasks.append()

        print("\(cards.count - 1)")
        let indexPath = IndexPath(row: cards.count - 1, section: 0)

        tableView.beginUpdates()

        tableView.insertRows(at: [indexPath], with: .automatic)

    tableView.endUpdates()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
