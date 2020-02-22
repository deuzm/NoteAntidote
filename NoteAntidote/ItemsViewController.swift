//
//  ItemsViewController.swift
//  NoteAntidote
//
//  Created by Лиза  Малиновская on 2/19/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class ItemsViewController: UITableViewController {

    
    var tasks: [Task] = []
    var cardData: CardData = CardData()
    var cardId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tasks = cardData.readTasks(cardId: cardId) ?? []
        
        // Do any additional setup after loading the view.
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
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    
    @IBAction func getDataTroughSegue(sender: UIStoryboardSegue) {
        if sender.source is CardTableViewController {
            if let senderVC = sender.source as? CardTableViewController {
                cardId = senderVC.cardId
                tasks = cardData.readTasks(cardId: cardId) ?? []
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
