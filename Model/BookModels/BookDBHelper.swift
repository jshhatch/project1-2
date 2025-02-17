//
//  BookDBHelper.swift
//  TabBarDemo
//
//  Created by admin on 1/5/25.
//

import Foundation
import CoreData

class BookDBHelper {
    let context = PersistentStorage.shared.context
    static var shared = BookDBHelper()
    
    func addData(title: String, author: String, pdfLink: String, coverLink: String?){
        let newBook = NSEntityDescription.insertNewObject(forEntityName: "Book", into: context) as? Book
        newBook?.title = title
        newBook?.author = author
        newBook?.pdfLink = pdfLink
        newBook?.coverLink = coverLink
        do{
            try context.save()
            print("data saved")
        } catch let error {
            print("Error adding data: ", error)
        }
    }
    
    func deleteData(title: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        do{
            let request = try context.fetch(fetchRequest) as! [Book]
            let entryToBeDeleted = request.first
            context.delete(request.first!)
            try context.save()
            print("Deletion Succesful")
        } catch let error {
            print("Deletion error: ", error)
        }
    }
    
    func getData() -> [Book]{
        var books : [Book] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        
        do{
            books = try context.fetch(fetchRequest) as! [Book]
        } catch let error {
            print("Error fetching book data: ", error)
        }
        
        return books
    }
}
