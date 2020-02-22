//
//  cardData.swift
//  NoteAntidote
//
//  Created by Лиза  Малиновская on 2/19/20.
//  Copyright © 2020 Лиза  Малиновская. All rights reserved.
//

import UIKit
import SQLite3

class CardData {
    //MARK: - properties
    
    let dbPath: String = "cardDb.sqlite"
    var db:OpaquePointer?
    var cards: [Card] = []
    
    init() {
        db = openDatabase()
        createTable(tableStringPart: "card(Id INTEGER PRIMARY KEY,cardTitle TEXT,cardDescription TEXT);")
        createTable(tableStringPart: "task(Id INTEGER PRIMARY KEY,itemTitle TEXT);")
    }
    
    func refresh() {
        db = openDatabase()
    }
    
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    ///example card(Id INTEGER PRIMARY KEY, cardTitle TEXT, cardDescription TEXT);
    func createTable(tableStringPart: String) {
        let createTableString = "CREATE TABLE IF NOT EXISTS \(tableStringPart);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("table created.")
            } else {
                print("table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func insertTask(id: Int, taskTitle: String, taskId: Int)
    {
        let tasks = readTasks(cardId: id) ?? []
        for task in tasks
        {
            if task.taskId == taskId
            {
                return
            }
        }
        //todo
        let insertStatementString = "INSERT INTO task (Id, cardTitle, taskId) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (taskTitle as NSString).utf8String, -1, nil)
            sqlite3_bind_int(insertStatement, 3, Int32(taskId))
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func insertCard(id:Int, cardTitle:String, cardDescription:String)
    {
        let cards = readCards()
        for card in cards
        {
            if card.id == id
            {
                return
            }
        }
        let insertStatementString = "INSERT INTO card (Id, cardTitle, cardDescription) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (cardTitle as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (cardDescription as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    //TODO reading tasks by card id
    
    func readTasks(cardId: Int) -> [Task]? {
        var tasks: [Task] = []
        let itemQcueryStatementString = "SELECT * FROM task;"
        var taskQueryStatement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, itemQcueryStatementString, -1, &taskQueryStatement, nil) == SQLITE_OK {
            while sqlite3_step(taskQueryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int((taskQueryStatement), 0)
                let taskTitle = String(describing: String(cString: sqlite3_column_text(taskQueryStatement, 1)))
                let card = sqlite3_column_int(taskQueryStatement, 3)
                if(cardId == id)
                {
                    tasks.append(Task(cardId: Int(card), taskId: Int(id), title: taskTitle))
                }
                print("Query Result:")
                print("\(card) |\(id) | \(taskTitle)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(taskQueryStatement)
        return cards
    }
    
    
    public func readCards() -> [Card] {
        
        let cardQueryStatementString = "SELECT * FROM card;"
        var cardQueryStatement: OpaquePointer? = nil
        
        var cards : [Card] = []
        if sqlite3_prepare_v2(db, cardQueryStatementString, -1, &cardQueryStatement, nil) == SQLITE_OK {
            while sqlite3_step(cardQueryStatement) == SQLITE_ROW {
                
                let id = sqlite3_column_int(cardQueryStatement, 0)
                let cardTitle = String(describing: String(cString: sqlite3_column_text(cardQueryStatement, 1)))
                let cardDescription = String(describing: String(cString: sqlite3_column_text(cardQueryStatement, 2)))
                
                cards.append(Card(cardId: Int(id), cardTitle: cardTitle, cardDescription: cardDescription,  tasks: readTasks(cardId: Int(id)) ?? []))
                
                print("Query Result:")
                print("\(id) | \(cardTitle) | \(cardDescription)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(cardQueryStatement)
        return cards
    }
    
    func deleteCard(cardId: Int) {
        deleteByID(id: cardId, table: "card")
        deleteByID(id: cardId, table: "task")
    }
    
    
    func deleteTask(taskId: Int) {
        let deleteStatementStirng = "DELETE FROM task WHERE taskId = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
           sqlite3_bind_int(deleteStatement, 1, Int32(taskId))
           if sqlite3_step(deleteStatement) == SQLITE_DONE {
               print("Successfully deleted row.")
           } else {
               print("Could not delete row.")
           }
        } else {
           print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    
    
    
    private func deleteByID(id:Int, table: String) {
        let deleteStatementStirng = "DELETE FROM \(table) WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
}
