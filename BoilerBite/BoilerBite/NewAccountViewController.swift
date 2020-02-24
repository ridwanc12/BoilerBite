//
//  NewAccountViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 2/24/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class NewAccountViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Getting the username and password entered
        usernameField.delegate = self
        passwordField.delegate = self
        firstnameField.delegate = self
        lastnameField.delegate = self
        heightField.delegate = self
        weightField.delegate = self
        ageField.delegate = self
    
    }
    
    // Action function for when the Create button is pressed
    @IBAction func createTapped(_ sender: Any) {
        let username: String = usernameField.text ?? ""
        let firstname: String = firstnameField.text ?? ""
        let lastname: String = lastnameField.text ?? ""
        let height: Int = Int(heightField.text ?? "0") ?? 0
        let weight: Int = Int(weightField.text ?? "0") ?? 0
        let age: Int = Int(ageField.text ?? "0") ?? 0
        let password: String = passwordField.text ?? ""
        
        // Validating the Inputs from the User
        
        if username == "" || password == "" || firstname == "" || lastname == "" || height == 0 || weight == 0 || age == 0 {
            let alert = UIAlertController(title: "Error" , message: "Enter all information!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Some field Empty")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        // TODO: Check if the username already exists
        
        if username.count < 6 || password.count < 6 {
            let alert = UIAlertController(title: "Error" , message: "Username/Password too short!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Username or Password too Short")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        if username.count > 12 || password.count > 12 {
            let alert = UIAlertController(title: "Error" , message: "Username/Password too long!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Username or Password too Long")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        if height < 0 || weight < 0 || age < 0 {
            let alert = UIAlertController(title: "Error" , message: "Enter a valid Height/Weight/Age", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Height/Weight/Age less than 0")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    // Action function for when the Back button is pressed
    @IBAction func backTapped(_ sender: Any) {
    }
    
    // Hide the Number Pad when clicked on the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightField.resignFirstResponder()
        weightField.resignFirstResponder()
        ageField.resignFirstResponder()
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

extension NewAccountViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
