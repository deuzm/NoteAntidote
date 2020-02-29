//
//  CardSetterViewController.swift
//  NoteAntidote
//
//  Created by Лиза  Малиновская on 2/18/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

protocol EmbeddedVCDelegate: class {
    func returnCardId() -> Int
}

class CardSetterViewController: UITableViewController, UITextFieldDelegate, EmbeddedVCDelegate {
    
    func returnCardId() -> Int {
        print("\(cardId)")
        return cardId
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.children.first?.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let embeddedVC = segue.destination as? RootViewController {
            embeddedVC.delegate = self
        }
        cards = cardData.readCards()
    }
    
    func tasksAssigned(type: [Task]) {
        self.tasks = type
        print("Shit")
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
//        vc.delegate = self
        cards = cardData.readCards()
        cardId = (cards.last?.cardId ?? Int.random(in: 1...1000)) + 100
        card.cardId = cardId
        
    }
    
    @IBAction func createButtonPressed(_ sender: Any) {
        var count = 0
        for task in tasks {
            task.cardId = card.cardId
            task.taskId = card.cardId + count
            cardData.insertTask(id: task.cardId, taskTitle: task.titleText, taskId: task.taskId)
            count += 1
        }
        card.tasks = tasks
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
    
    //MARK: - outlets
    @IBOutlet weak var cardNameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    //MARK: - make button funcion

    func makeButtonWithText(text:String) -> UIButton {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.frame = CGRect(x: 10, y: 10, width: self.view.frame.width - 60, height: 30)
        button.setTitle(text, for: .normal)
        button.setTitleColor( .black, for: .normal)
        button.backgroundColor = .red

        return button
    }
    //    MARK: - keyboard dissmiss setup

        func textFieldShouldReturn(_ textField: UITextField) -> Bool {

            textField.resignFirstResponder()  //if desired
            return true
        }

}
