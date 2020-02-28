//
//  RootViewController.swift
//  NoteAntidote
//
//  Created by Лиза  Малиновская on 2/18/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

protocol TasksProtocol
{
    func tasksAssigned(type: [Task])
}

class RootViewController: UITableViewController, UITextFieldDelegate {

    

    //MARK: - properties
    var tasks: [Task] = []
    var card: Card = Card(tasks: [], cardTitleText: "Default", cardDescription: "Default")
    var cardData = CardData()
    var cardId: Int?
    var firstCell = true
    weak var delegate: EmbeddedVCDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
//        cardSetterVC = CardSetterViewController()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cardId = delegate?.returnCardId()
    }
//    MARK: - keyboard dissmiss setup

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        let textField = sender as! UITextField
        if(textField.text != "" && textField.text != nil)
        {
            tasks.append(Task(cardId: cardId ?? 0, taskId: tasks.count + (cardId ?? 0), title: "\(textField.text ?? "")"))
            
            if let parentVC = self.parent as? CardSetterViewController {
                parentVC.tasks = tasks
            }
            
            tableView.beginUpdates()

            tableView.insertRows(at: [IndexPath(row: tasks.count, section: 0)], with: .top)
            tableView.endUpdates()
            
            textField.text = ""
            print(tasks[tasks.count - 1].titleText)
        }
//        textField.resignFirstResponder()  //if desired
        performAction()
        return true
    }

    func performAction() {
        print("RETURN")
    }
    
    //MARK: - data sourse

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(firstCell || indexPath.row == 0)
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "editor", for: indexPath)
            firstCell = false
            cell.setEditing(false, animated: true)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCellId", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row - 1].titleText
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        if indexPath.row == tasks.count
        {
            return UITableViewCell.EditingStyle.none
        }
        return UITableViewCell.EditingStyle.delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
}
