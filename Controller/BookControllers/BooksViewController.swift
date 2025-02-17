//
//  BooksViewController.swift
//  TabBarDemo
//
//  Created by admin on 12/30/24.
//

import UIKit

class BooksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    var iconName = "book-icon"
    var booksData: [Book] = []
    @IBOutlet weak var addBookTextField: UITextField!
    @IBOutlet weak var booksTitleLabel: UILabel!
    
    let userDefault = UserDefaults.standard
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return booksData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //heightForRowAt
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "booksCell", for: indexPath) as! BooksTableViewCell
        cell.bookCellText?.text = booksData[indexPath.row].title
        cell.booksIcon?.image = UIImage(named: (booksData[indexPath.row].coverLink ?? iconName))
        cell.authorText?.text = booksData[indexPath.row].author
        return cell
    }
    
    ///didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("row selcted")
        let PDFLink = booksData[indexPath.row].pdfLink
        userDefault.set(PDFLink, forKey: "pdfLink")
        self.performSegue(withIdentifier: "toPDFView", sender: self)
    }
    
    @objc func reloadBookTableDataFromAddView(){
        print("book selector activated")
        reloadFromCoreData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        let username = userDefault.string(forKey: "username")!
        booksTitleLabel.text = "\(username)'s Books"
        NotificationCenter.default.addObserver(self, selector: #selector(reloadBookTableDataFromAddView), name: UIApplication.didBecomeActiveNotification, object: nil)
        reloadFromCoreData()
    }
    
    ///forRowAt
    ///delete functionality
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let rowTitle = booksData[indexPath.row].title
            BookDBHelper.shared.deleteData(title: rowTitle!)
            reloadFromCoreData()
        }
    }

    func reloadFromCoreData() {
        let booksFromCoreData = BookDBHelper.shared.getData()
        booksData = booksFromCoreData
        tableView.reloadData()
    }
    
//Adventures of Sherlock Holmes
//Arthur Conan Doyle
}
