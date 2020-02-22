//
//  CardTableViewController.swift
//  NoteAntidote
//
//  Created by Лиза  Малиновская on 2/17/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit


class CardTableViewController: UITableViewController {

    //MARK: - properties
    var cards: [Card] = [Card(tasks: [Task(cardId: 1, taskId: 1, title: "TODO")], cardTitleText: "Liliac", cardDescription: "Bronze")]
    var cardData = CardData()
    var cardId: Int = 0
    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//    }
//    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Cards"
        
        cards = cardData.readCards()
        
        tableView.separatorColor = .black
        
        tableView.register(CardTableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    //MARK: - actions
    
    
    //MARK: - make button with text
    
    func makeButtonWithText(text:String) -> UIButton {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 10, y: 5, width: self.view.frame.width - 20, height: 30)
        button.setTitle(text, for: .normal)
        button.setTitleColor( .black, for: .normal)
        button.backgroundColor = .white
        return button
    }
    
    //MARK: - adding card(going to card setter page)
    @objc func addCard()
    {
        self.performSegue(withIdentifier: "cardSetter", sender: self)

    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            
            cardData.deleteCard(cardId: cards[indexPath.row].id)
            cards.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CardTableViewCell
        cell.cardTitleLabel.text = cards[indexPath.row].titleText
        cell.cardDescriptionLabel .text = cards[indexPath.row].cardDescription
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cardId = cards[indexPath.row].cardId
        self.performSegue(withIdentifier: "Items", sender: self)
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let navVC = segue.destination as? UINavigationController
        {
            if let tableVC = navVC.viewControllers.first as? ItemsViewController
            {
                tableVC.cardId = cardId
            }
        }
    }

  
    
    //MARK: - adding footer
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .systemIndigo
        footerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:
        50)
        let button = makeButtonWithText(text: "Add")
        footerView.addSubview(button)
        button.addTarget(self, action: #selector(addCard), for: .touchUpInside)
        return footerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    //MARK: - segues
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {
    }
    
    @IBAction func done(segue:UIStoryboardSegue) {
         
    }

    
    @IBAction func unwindFromCardSetterVC(sender: UIStoryboardSegue) {
        if sender.source is CardSetterViewController {
            if let senderVC = sender.source as? CardSetterViewController {
                cards = senderVC.cards
            }
            tableView.reloadData()
        }
    }


    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
