//
//  Book+CoreDataProperties.swift
//  TabBarDemo
//
//  Created by admin on 1/5/25.
//

import Foundation
import CoreData

extension Book {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }
    
    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var pdfLink: String?
    @NSManaged public var coverLink: String?
}

extension Book : Identifiable {
    
}
