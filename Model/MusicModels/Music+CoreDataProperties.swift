//
//  Music+CoreDataProperties.swift
//  TabBarDemo
//
//  Created by admin on 1/6/25.
//
import Foundation
import CoreData

extension Music {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Music> {
        return NSFetchRequest<Music>(entityName: "Music")
    }
    
    @NSManaged public var title: String?
    @NSManaged public var artist: String?
    @NSManaged public var link: String?
    @NSManaged public var imageLink:String?
}

extension Music : Identifiable {
    
}
