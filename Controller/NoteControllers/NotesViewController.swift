//
//  NotesViewController.swift
//  TabBarDemo
//
//  Created by admin on 12/30/24.
//

import UIKit

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView: UITableView!
    var notesIcon = "note-icon"
    var noteData : [Note] = []
    
    let userDefault = UserDefaults.standard
    
    @IBOutlet weak var addNoteTextField: UITextField!
    @IBOutlet weak var notesTitleLabel: UILabel!
    
    //numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notesCell", for: indexPath) as! NotesTableViewCell
        cell.noteCellText?.text = noteData[indexPath.row].title
        cell.notesIcon?.image = UIImage(named: notesIcon)
        cell.noteCellBodyPreview?.text = noteData[indexPath.row].body
        
        return cell
    }
    
    ///forRowAt
    ///Handles deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete {
            let rowTitle = noteData[indexPath.row].title
            DBHelper.shared.deleteData(title: rowTitle!)
            reloadFromCoreData()
        }
    }
    
    @objc private func reloadDataWhenBackInForeground() {
        print("selector called")
        reloadFromCoreData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let username = userDefault.string(forKey: "username")!
        notesTitleLabel.text = "\(username)'s Notes"
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataWhenBackInForeground), name: UIApplication.didBecomeActiveNotification, object: nil)
        reloadFromCoreData()
    }
    
    //heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
        //expand when selected?
    }
    
    ///didSelectRowAt
    ///Segues to the note edit view when a row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let rowTitle = noteData[indexPath.row].title
        userDefault.set(rowTitle, forKey: "selectedNoteTitle")
        
        let rowBody = noteData[indexPath.row].body
        userDefault.set(rowBody, forKey: "selectedNoteBody")
        
        self.performSegue(withIdentifier: "toNoteEditor", sender: self)
    }
    

    func reloadFromCoreData() {
        let notesFromCoreData = DBHelper.shared.getData()
        noteData = notesFromCoreData
        tableView.reloadData()
    }
    
    @IBAction func addButtonPress(_ sender: Any) {
        let noteTitle = addNoteTextField.text!
        
        if(noteTitle.isEmpty){
            return
        }
        
        DBHelper.shared.addData(title: noteTitle)
        
        reloadFromCoreData()
    }
}
