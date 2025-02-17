//
//  Note+CoreDataProperties.swift
//  TabBarDemo
//
//  Created by admin on 1/5/25.
//

import Foundation
import CoreData

extension Note {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var title: String?
    @NSManaged public var body: String?}

extension Note : Identifiable {
    
}
