//
//  MusicDBHelper.swift
//  TabBarDemo
//
//  Created by admin on 1/6/25.
//

import Foundation
import CoreData

class MusicDBHelper {
    let context = PersistentStorage.shared.context
    static var shared = MusicDBHelper()
    
    func addData(title: String, artist: String, link: String, imageLink: String?){
        let newMusic = NSEntityDescription.insertNewObject(forEntityName: "Music", into: context) as? Music
        newMusic?.title = title
        newMusic?.artist = artist
        newMusic?.link = link
        newMusic?.imageLink = imageLink
        
        do{
            try context.save()
            print("data saved")
        } catch let error {
            print("Error adding music data: ", error)
        }
    }
    
    func deleteData(title: String) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        fetchRequest.predicate = NSPredicate(format: "title == %@", title)
        do{
            let request = try context.fetch(fetchRequest) as! [Music]
            let entryToBeDeleted = request.first
            context.delete(request.first!)
            try context.save()
            print("Deletion Succesful")
        } catch let error {
            print("Music deletion error: ", error)
        }
    }
    
    func getData() -> [Music]{
        var music : [Music] = []
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Music")
        
        do{
            music = try context.fetch(fetchRequest) as! [Music]
        } catch let error {
            print("Error fetching music data: ", error)
        }
        
        return music
    }

}

