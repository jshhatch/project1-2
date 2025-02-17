//
//  AddMusicViewController.swift
//  TabBarDemo
//
//  Created by admin on 1/6/25.
//

import UIKit

class AddMusicViewController: UIViewController {

    @IBOutlet weak var musicTitleTextField: UITextField!
    @IBOutlet weak var musicArtistTextField: UITextField!
    @IBOutlet weak var musicLinkTextField: UITextField!
    @IBOutlet weak var musicImageLinkField: UITextField!
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //ONLY RUN to programtically add a song
        //MusicDBHelper.shared.addData(title: "Lost in Dreams", artist: "Zakhar Valaha", link: "price-of-freedom", imageLink: "freedoom-cover")

    }
    
    func anyTextFieldIsEmpty(newTitle: String, newArtist: String, newLink: String) -> Bool {
        if newTitle.isEmpty || newArtist.isEmpty || newLink.isEmpty {
            return true
        }
        return false
    }
    
    func musicAddAlert() {
        let alert = UIAlertController(title: "Success", message: "Music Added Successfully", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func emptyTextFieldALert() {
        let alert = UIAlertController(title: "Misssing Data", message: "Title, artist, and filename are required.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addButtonPress(_ sender: Any) {
        let newTitle = musicTitleTextField.text!
        let newArtist = musicArtistTextField.text!
        let newLink = musicLinkTextField.text!
        var newImageLink : String?
        newImageLink = musicImageLinkField.text!
        
        if newImageLink!.isEmpty {
            newImageLink = nil
        }
        
        if anyTextFieldIsEmpty(newTitle: newTitle, newArtist: newArtist, newLink: newLink){
            print("Text Field Empty")
            emptyTextFieldALert()
            return
        }
        
        MusicDBHelper.shared.addData(title: newTitle, artist: newArtist, link: newLink, imageLink: newImageLink)
        print("Music Added")
        musicAddAlert()
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
