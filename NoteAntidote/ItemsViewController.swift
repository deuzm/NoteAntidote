//
//  ItemsViewController.swift
//  NoteAntidote
//
//  Created by Лиза  Малиновская on 2/19/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController, UITextFieldDelegate {

    
    var tasks: [Task] = []
    var cardData: CardData = CardData()
    var cardId: Int = 0
    var textFieldString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(cardId)")
        tasks = cardData.readTasks(cardId: cardId) ?? []
        // Do any additional setup after loading the view.
    }
    
    //MARK: - actions
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add task", message: nil, preferredStyle: .alert)
            
        alert.addTextField(configurationHandler: addTaskTextField)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: self.okButtonPressed))
        self.present(alert, animated: true)

    }
    
    var textField: UITextField?
    
    func addTaskTextField(_ textField: UITextField) {
        self.textField = textField
        textField.placeholder = "add task"
        textFieldString = textField.text ?? ""
        textField.delegate = self
    }
    
    func okButtonPressed(action: UIAlertAction!) {
        var taskId = tasks.last?.taskId ?? 0
        taskId += 1
        print("\(taskId) + \(textFieldString) + \(cardId)")
        cardData.insertTask(id: cardId, taskTitle: textFieldString, taskId: taskId)
        tasks.append(Task(cardId: cardId, taskId: taskId, title: textFieldString))
        
        tableView.beginUpdates()

        tableView.insertRows(at: [IndexPath(row: tasks.count - 1, section: 0)], with: .top)
        tableView.endUpdates()
        
        print("Shiegv")
        
    }
    //MARK: - editing did finish
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if(textField.text != "" && textField.text != nil) {
            textFieldString = textField.text!
        }
    }
    
    //MARK: - Data sourse
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].titleText
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
            let taskId = tasks[indexPath.row].taskId

            DispatchQueue.global(qos: .userInitiated).async {
                self.cardData.deleteTask(taskId: taskId)
            }
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        cardData.refresh()
//    }
    
    
    @IBAction func getDataTroughSegue(sender: UIStoryboardSegue) {
        if sender.source is CardTableViewController {
            if let senderVC = sender.source as? CardTableViewController {
                cardId = senderVC.cardId
//                tasks = cardData.readTasks(cardId: cardId) ?? []
            }
            tableView.reloadData()
        }
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
