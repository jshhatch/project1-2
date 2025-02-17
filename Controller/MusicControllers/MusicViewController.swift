//
//  MusicTableViewController.swift
//  TabBarDemo
//
//  Created by admin on 12/30/24.
//

import UIKit

var musicData: [Music] = []
var iconName = "music-icon"

class MusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var musicTextEntry: UITextField!
    //@IBOutlet weak var musicImage: UIImageView!
    @IBOutlet weak var sceneTitle: UILabel!
    
    let userDefault = UserDefaults.standard
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicData.count
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let username = userDefault.string(forKey: "username")!
        sceneTitle.text = "\(username)'s Music"
        reloadFromCoreData()
    }
    
    //heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func reloadFromCoreData() {
        let musicFromCoreData = MusicDBHelper.shared.getData()
        musicData = musicFromCoreData
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    ///forRowAt
    ///delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            let rowTitle = musicData[indexPath.row].title
            MusicDBHelper.shared.deleteData(title: rowTitle!)
            reloadFromCoreData()
        }
    }

    
    ///cellForRowAt
    ///Fills cell with content
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "musicCell", for: indexPath) as! MusicTableViewCell
        cell.musicCellText?.text = musicData[indexPath.row].title
        cell.musicIcon?.image = UIImage(named: musicData[indexPath.row].imageLink ?? iconName)
        cell.musicArtistText?.text = musicData[indexPath.row].artist
        return cell
    }
    
    ///didSelectRowAt
    ///persists song data in userDefault and moves to music plalyer
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selcted")
        
        let songTitle = musicData[indexPath.row].title
        userDefault.set(songTitle, forKey: "songTitle")
        
        let songLink  = musicData[indexPath.row].link
        userDefault.set(songLink, forKey: "songLink")
        
        let songImage = musicData[indexPath.row].imageLink
        userDefault.set(songImage, forKey: "songImage")
        
        self.performSegue(withIdentifier: "toMusicPlayer", sender: self)
    }
}

