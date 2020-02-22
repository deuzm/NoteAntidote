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

class RootViewController: UITableViewController {

    

    //MARK: - properties
    var tasks: [Task] = []
    var card: Card = Card(tasks: [], cardTitleText: "Default", cardDescription: "Default")
    var cardData = CardData()
    var firstCell = true
    var cardSetterVC: CardSetterViewController?
    var delegate:TasksProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.allowsSelection = false
        cardSetterVC = CardSetterViewController()
        
        // Do any additional setup after loading the view.
    }
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    

    //MARK: - outlets
//    @IBOutlet weak var taskTitle: UILabel!
//    @IBOutlet weak var taskTextField: UITextField!
//    @IBOutlet weak var taskCell: UIView!
//
//    MARK: - actions

    
    
    @IBAction func taskTextFieldEditingFinished(_ sender: Any) {
        cardSetterVC?.completionHandler = { self.tasks }
        let textField = sender as! UITextField
        var a = "lol"
        if(textField.text != "" && textField.text != nil)
        {
            //TODO
            
            let cardId = cardSetterVC?.cardId
            tasks.append(Task(cardId: cardId ?? 0, taskId: tasks.count + (cardId ?? 0), title: "\(textField.text ?? a)"))
            
           
            tableView.beginUpdates()

            tableView.insertRows(at: [IndexPath(row: tasks.count, section: 0)], with: .top)
            tableView.endUpdates()
            
            textField.text = ""
//            tableView.beginUpdates()
//            tableView.deleteRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
//            tableView.endUpdates()
            
            print(tasks[tasks.count - 1].titleText)
            
            delegate?.tasksAssigned(type: tasks)
            
        }
        
    }
    
//    @IBAction func taskEditingDIdEnd(_ sender: Any) {
//        taskTitle.text = taskTextField.text
//        taskTextField.isHidden = true
//    }
    
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
    
    //MARK: - Passing items to cardSetter view controller
    

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
