//
//  Card.swift
//  NoteAntidote
//
//  Created by Лиза  Малиновская on 2/17/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class Card: Task {
    
    var id: Int
    var tasks: [Task]
    var cardDescription: String
    
    ///for views
    init(tasks: [Task], cardTitleText: String, cardDescription: String)
    {
        self.id = Int.random(in: 1...10000) + cardTitleText.first.hashValue
        self.tasks = tasks
        self.cardDescription = cardDescription
        super.init(cardId: self.id,taskId: Int.random(in: 100...1000) + self.id, title: cardTitleText)
    }
    
    override init()
    {
        self.id = Int.random(in: 1...10000)
        self.cardDescription = ""
        tasks = []
        super.init()
        titleText = "Default"
    }
    ///for database
    init(cardId: Int, cardTitle: String, cardDescription: String, tasks: [Task])
    {
        self.id = cardId
        self.tasks = []
        self.cardDescription = cardDescription
        super.init(cardId: cardId, taskId: Int.random(in: 100...1000) + cardId, title: cardTitle)
        
    }
    
    func generateId() {
        
    }
    
}
