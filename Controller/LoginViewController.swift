//
//  ViewController.swift
//  TabBarDemo
//
//  Created by admin on 12/27/24.
//

import UIKit

class LoginViewController: UIViewController {
    var temporaryUsername = "user"
    var temporaryPassword = "pass"
    
    let userDefault = UserDefaults.standard
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func loginAlert(title: String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func retrieveLoginCredentials(givenUsername: String) {
        let request : [String : Any] = [kSecClass as String : kSecClassGenericPassword,
                                        kSecAttrAccount as String : givenUsername,
                                        kSecReturnAttributes as String : true,
                                        kSecReturnData as String : true]
        var response : CFTypeRef?
        
        if SecItemCopyMatching(request as CFDictionary, &response) == noErr {
            let data = response as? [String : Any]
            let retreivedUsername = data?[kSecAttrAccount as String] as? String
            let retrievedPassword = (data![kSecValueData as String] as? Data)!
            var passwordString = String(data: retrievedPassword, encoding: .utf8)
            
            temporaryUsername = retreivedUsername!
            temporaryPassword = passwordString!
        }
    }
    
    func persistUsername(){
        userDefault.set(temporaryUsername, forKey: "username")
    }
    
    @IBAction func logInValidation(_ sender: Any) {
        //quick login
        self.performSegue(withIdentifier: "goToTabBar", sender: self)
        //
        let givenUsername = usernameField.text!
        let givenPassword = passwordField.text!
        
        retrieveLoginCredentials(givenUsername: givenUsername)
        
        if(givenUsername.isEmpty || givenPassword.isEmpty){
            print("Enter username and password")
            loginAlert(title: "Enter Credentials", message: "Username or Password field is empty")
        } else if (givenUsername != temporaryUsername) {
            print("Incorrect username")
            loginAlert(title: "Username Incorrect", message: "Provided username does not match an account")
        } else if (givenPassword != temporaryPassword) {
            print("Incorrect password")
            loginAlert(title: "Incorrect Password", message: "Provided password is incorrect")
        } else {
            print("Correct credentials")
            persistUsername()
            self.performSegue(withIdentifier: "goToTabBar", sender: self)
        }
    }
    
}

