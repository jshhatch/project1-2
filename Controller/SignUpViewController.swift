//
//  SignUpViewController.swift
//  TabBarDemo
//
//  Created by admin on 12/30/24.
//

import UIKit

class SignUpViewController: UIViewController {

   
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var noticeLabel: UILabel!
    
    //userDefault save funtionality (temporary)
    //let userDefault = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func signUpAlert(title: String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    func passwordIsTooShort(password: String) -> Bool {
        if(password.count < 16){
            return true
        }
        return false
    }
    
    func passwordHasNoCapitalLetter(password: String) -> Bool{
        let range = NSRange(location: 0, length: password.count)
        let regex = try! NSRegularExpression(pattern: ".*[A-Z]+.*")
        let hasNoCapital = regex.firstMatch(in: password, options: [], range: range) == nil
        return hasNoCapital
    }
    
    func passwordHasNoSpecialCharacters(password: String) -> Bool{
        let range = NSRange(location: 0, length: password.count)
        let regex = try! NSRegularExpression(pattern: ".*[^A-Za-z].*", options: [])
        let hasNoSpecial = regex.firstMatch(in: password, range: range) == nil
        return hasNoSpecial
    }
    
    func validateGivenPassword(givenPassword: String) -> Bool{
        if(passwordIsTooShort(password: givenPassword)){
            print("Password must be at least 16 characters.")
            signUpAlert(title: "Passsword Error", message: "Password must be 16 characters or longer")
            return false
        } else if (passwordHasNoCapitalLetter(password: givenPassword)) {
            signUpAlert(title: "Password Error", message: "Password musst conatin a capital letter")
            return false
        } else if(passwordHasNoSpecialCharacters(password: givenPassword)) {
            print("password must have at least 1 special character")
            signUpAlert(title: "Password Error", message: "Password must contain at least 1 special character")
            return false
        }
        return true
    }
    
    func validateGivenUsername(givenUsername: String) -> Bool{
        if givenUsername.isEmpty {
            print("username cannot be empty")
            signUpAlert(title: "Username Error", message: "Username cannot be empty")
            return false
        }
        //TODO: duplicate checks
        return true
    }
    
    func persistLoginData(givenPassword: String, givenUsername: String) {
        //userDefault.set(givenUsername, forKey: "username")
        //userDefault.set(givenPassword, forKey: "password")
        //above is temporary
        let attributes: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                                         kSecAttrAccount as String: givenUsername,
                                         kSecValueData as String: givenPassword.data(using: .utf8)!]
        if SecItemAdd(attributes as CFDictionary, nil) == errSecSuccess {
            print("login data saved")
        } else {
            print("Data not saved, duplicate data is  not saved")
        }
        
    }
    
    @IBAction func signUpButton(_ sender: Any){
        let givenUsername = usernameField.text!
        let givenPassword = passwordField.text!
        
        let passwordIsValid = validateGivenPassword(givenPassword: givenPassword)
        
        let usernameIsValid = validateGivenUsername(givenUsername: givenUsername)
        
        if(passwordIsValid && usernameIsValid) {
            print("Sign up successful")
            persistLoginData(givenPassword: givenPassword, givenUsername: givenUsername)
            self.performSegue(withIdentifier: "toLogin", sender: self)
        }
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
