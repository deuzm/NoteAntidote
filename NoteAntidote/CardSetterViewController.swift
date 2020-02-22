//
//  CardSetterViewController.swift
//  NoteAntidote
//
//  Created by Лиза  Малиновская on 2/18/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class CardSetterViewController: UITableViewController, TasksProtocol {
    
    func tasksAssigned(type: [Task]) {
        self.tasks = type
    }
    
    //MARK: - properties
    var tasks: [Task] = []
    var cardData = CardData()
    var cards: [Card] = []
    var card = Card(tasks: [], cardTitleText: "Default", cardDescription: "Default")
    var cardId = 0
    var vc = RootViewController()
    var completionHandler:(() -> [Task])?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Setting up card"
        vc.delegate = self
        
        card.cardId = Int.random(in: 1...10000)
        
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: navigationItem, action: #selector(doneCreatingCard))
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        card.cardId = Int.random(in: 1...10000)

//        var tas = vc.tasks
//        var count = 0
//        for task in tas ?? [] {
//            task.cardId = card.cardId
//            task.taskId = card.cardId + count
//            cardData.insertTask(id: task.cardId, taskTitle: task.titleText, taskId: task.taskId)
//            count += 1
//        }
//
//        card.tasks = tas ?? []
        if let text = cardNameTextField.text {
            card.titleText = text
        }
        if let text = descriptionTextField.text {
            card.cardDescription = text
        }
        cardData.insertCard(id: card.cardId, cardTitle: card.titleText, cardDescription: card.cardDescription)
        
        cardData.refresh()

        print("pressed")
    }
    
    
//    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {}
    
    @objc func doneCreatingCard() {

//        self.performSegue(withIdentifier: "exitSetup", sender: self)
//        dismiss(animated: true, completion: {})
        print("LOL")
    }
    
//    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue)
//    {
//        let sourceViewController = sender.source
//        // Pull any data from the view controller which initiated the unwind segue.
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        cards = cardData.readCards()
    }


    
    //MARK: - outlets
    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    //MARK: - actions
//    @IBAction func cardNameEditingDidEnd(_ sender: Any) {
//        
//    }
//    
//    @IBAction func descriptionEditingDidEnd(_ sender: Any) {
//    }
    
//    @IBAction func pressed(_ sender: Any) {
//        card.cardId = Int.random(in: 1...10000)
//
//        var tas = vc?.tasks ?? []
//        var count = 0
//        for task in tas {
//            task.cardId = card.cardId
//            task.taskId = card.cardId + count
//            cardData.insertTask(id: task.cardId, taskTitle: task.titleText, taskId: task.taskId)
//            count += 1
//        }
//
//        card.tasks = tas
//        if let text = cardNameTextField.text {
//            card.titleText = text
//        }
//        if let text = descriptionTextField.text {
//            card.cardDescription = text
//        }
//        cardData.insertCard(id: card.cardId, cardTitle: card.titleText, cardDescription: card.cardDescription)
//
//        print("pressed")
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//    {
//        if segue.destination is RootViewController
//        {
//            let vc = segue.destination as? RootViewController
//            tasks = vc?.tasks ?? []
//        }
//    }

    //MARK: - button funcion

    func makeButtonWithText(text:String) -> UIButton {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 10, y: 10, width: self.view.frame.width - 60, height: 30)
        button.setTitle(text, for: .normal)
        button.setTitleColor( .black, for: .normal)
        button.backgroundColor = .red

        return button
    }
    //MARK: - add section
    @objc func addSection() {
        
        // TODO
        
        tasks.append(Task(cardId: 1, taskId: 1, title: "LOL"))

        print("\(tasks.count - 1)")
        let indexPath = IndexPath(row: tasks.count - 1, section: 2)

        tableView.beginUpdates()

        tableView.insertRows(at: [indexPath], with: .automatic)

        tableView.endUpdates()
    }

    

}
