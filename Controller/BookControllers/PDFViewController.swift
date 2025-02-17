//
//  PDFViewController.swift
//  TabBarDemo
//
//  Created by admin on 1/3/25.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {

    @IBOutlet weak var pdfViewport: UIView!
    
    let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        openPDF()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
        if let tabBarController = self.presentingViewController as? UITabBarController {
            tabBarController.selectedIndex = 2
        }
    }
    
    func openPDF() {
        let pdfLink = userDefault.string(forKey: "pdfLink")
        
        let pdfView = PDFView(frame: pdfViewport.bounds)
        
        pdfView.autoScales = true
        let filepath = Bundle.main.url(forResource: pdfLink, withExtension: "pdf")
        pdfView.document = PDFDocument(url: filepath!)
        
        pdfViewport.addSubview(pdfView)
    }

}
