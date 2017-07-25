//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Jeremy Kim on 7/10/17.
//  Copyright © 2017 Jeremy Kim. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper {
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    //static methods will go here
    static func newNote() ->Note {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: managedContext) as! Note
        return note
    }
    static func saveNote() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
        static func delete(note: Note) {
            managedContext.delete(note)
            saveNote()
        }
    static func retrieveNotes() -> [Note] {
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        do {
            let results = try managedContext.fetch(fetchRequest)
            return results.sorted(by: { (($0.modificationTime!) as Date) > ($1.modificationTime! as Date)})
            
            
//            return results.sorted { (note: Note ,noteTwo: Note) -> Bool in
//                let date1 = note.modificationTime! as Date
//                let date2 = noteTwo.modificationTime! as Date
//                return date1 > date2
    
            
        } catch let error as NSError {
            print("Could not fetch \(error)")
        }
        return []
    }
    }
