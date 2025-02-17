//
//  DBHelper.swift
//  TabBarDemo
//
//  Created by admin on 1/5/25.
//

import Foundation
import CoreData

class DBHelper {
    let context = PersistentStorage.shared.context
    static var shared = DBHelper()
    
    func addData(title: String){
        let newNote = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as? Note
        newNote?.title = title
        newNote?.body = ""
        do{
            try context.save()
            print("data saved")
        } catch let error {
            print(error)
        }
    }
    
    func deleteData(title: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        do{
            let request = try context.fetch(fetchRequest) as! [Note]
            let entryToBeDeleted = request.first
            if entryToBeDeleted == nil {
                print("Deletion error 100")
                return
            }
            context.delete(request.first!)
            try context.save()
            print("Deletion Succesful")
        } catch let error {
            print("Deletion error: ", error)
        }
    }
    
    func updateData(title: String, body: String){
        var note : Note? = Note()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        do{
            let request = try context.fetch(fetchRequest) as! [Note]
            if request.count > 0 {
                note = request.first
                note?.body = body
                try context.save()
            }
        } catch let error {
            print("Update Error: ", error)
        }
    }
    
    func getData() -> [Note]{
        var notes : [Note] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        
        do{
            notes = try context.fetch(fetchRequest) as! [Note]
        } catch let error {
            print("Error fetching note data: ", error)
        }
        
        return notes
    }
    
    func getOneData(title: String) -> Note{
        var note : Note? = Note()
        var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        do{
            let request = try context.fetch(fetchRequest) as! [Note]
            if request.count > 0 {
                note = request.first
            } else {
                note = nil
                print("Note not found")
            }
        } catch let error {
            print("Error fetching one: ", error)
        }
        
        return note!
    }
}
