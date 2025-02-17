//
//  NoteEditorViewController.swift
//  TabBarDemo
//
//  Created by admin on 1/3/25.
//

import UIKit

class NoteEditorViewController: UIViewController {
    let userDefault = UserDefaults.standard

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var textEditField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let selectedNoteTitle = userDefault.string(forKey: "selectedNoteTitle")
        noteTitle.text = selectedNoteTitle
        
        let selectedNoteBody = DBHelper.shared.getOneData(title: selectedNoteTitle!).body
        textEditField.text = selectedNoteBody
    }
    
    func savedAlert() {
        let alert = UIAlertController(title: "Saved", message: "Changes have been saved.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    @IBAction func button(_ sender: Any) {
        NotificationCenter.default.post(name: UIApplication.didBecomeActiveNotification, object: nil)
        self.dismiss(animated: false, completion: nil)
        if let tabBarController = self.presentingViewController as? UITabBarController {
            tabBarController.selectedIndex = 1
        }
    }
    
    @IBAction func saveButtonPress(_ sender: Any) {
        let selectedNoteTitle = userDefault.string(forKey: "selectedNoteTitle")!
        let selectedNoteBody = textEditField.text!
        DBHelper.shared.updateData(title: selectedNoteTitle, body: selectedNoteBody)
        print("Saved")
        savedAlert()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
