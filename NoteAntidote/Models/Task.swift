//
//  Task.swift
//  NoteAntidote
//
//  Created by Лиза  Малиновская on 2/17/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit

class Task {
    
    var titleText: String
    var cardId: Int
    var taskId: Int
    
    init(cardId: Int, taskId: Int, title: String)
    {
        self.cardId = cardId
        self.taskId = taskId
        titleText = title
    }
    
    init() {
        titleText = ""
        cardId = 0
        taskId = 0
    }
}
