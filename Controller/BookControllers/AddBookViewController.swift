//
//  AddBookViewController.swift
//  TabBarDemo
//
//  Created by admin on 1/5/25.
//

import UIKit

class AddBookViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var pdfTextField: UITextField!
    @IBOutlet weak var coverTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        //BookDBHelper.shared.addData(title: "Farenheit 451", author: "Ray Bradbury", pdfLink: "f451", coverLink: "f-cover")
    }
    
    func anyTextFieldIsEmpty(newTitle: String, newAuthor: String, newPDFLink: String) -> Bool {
        if newTitle.isEmpty || newAuthor.isEmpty || newPDFLink.isEmpty {
            return true
        }
        return false
    }
    
    
    func bookAddAlert() {
        let alert = UIAlertController(title: "Success", message: "Book added successfully", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func emptyTextFieldALert() {
        let alert = UIAlertController(title: "Mising Data", message: "Title, author, and filename are required.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func backButton(_ sender: Any) {
        NotificationCenter.default.post(name: UIApplication.didBecomeActiveNotification, object: nil)
        self.dismiss(animated: false, completion: nil)
        if let tabBarController = self.presentingViewController as? UITabBarController {
            tabBarController.selectedIndex = 2
        }
    }
    
    
    @IBAction func addButtonPush(_ sender: Any) {
        let newTitle = titleTextField.text!
        let newAuthor = authorTextField.text!
        let newPDFLink = pdfTextField.text!
        var newCoverLink : String?
        newCoverLink = coverTextField.text!
        
        if newCoverLink!.isEmpty {
            newCoverLink = nil
        }
        
        if anyTextFieldIsEmpty(newTitle: newTitle, newAuthor: newAuthor, newPDFLink: newPDFLink){
            emptyTextFieldALert()
            return
        }
        
        BookDBHelper.shared.addData(title: newTitle, author: newAuthor, pdfLink: newPDFLink, coverLink: newCoverLink)
        print("book added")
        bookAddAlert()
        
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
