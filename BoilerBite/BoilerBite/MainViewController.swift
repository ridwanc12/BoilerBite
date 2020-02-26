//
//  MainViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 2/22/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Getting the username and password entered
        usernameField.delegate = self
        passwordField.delegate = self
        
        // Testing dining hours functions in main
//        diningHoursExample()
        
        // Testing meal and item requests functions in main
//        mealRequest()
        
    }
    
    func diningHoursExample() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMeal(hall: "windsor", date: "2020-01-13")

        print("All Hours")
        let diningHours = getDiningHours(menu: testMenu)
        print(diningHours)
        
        print("BLD Hours")
        let BLDHours = getBLDHours(menu: testMenu)
        print(BLDHours)
        
        print("Late Lunch Hours")
        let LLHours = getLLHours(menu: testMenu)
        print(LLHours)
        
        let testMenu2 = getMeal(hall: "windsor", date: "2020-01-18")
        
        print("Weekend Meal Hours")
        let weekendHours = getDiningHours(menu: testMenu2)
        print(weekendHours)
    }
    
    func mealRequest() {
        let testMenu = getMeal(hall: "windsor", date: "2020-01-13")
        let hall = testMenu?.Location
        let date = testMenu?.Date
        print(hall ?? "No hall")
        print(date ?? "No date")
        
        let dinner = getDinner(menu: testMenu)
        print(dinner ?? "No dinner")
        
        let lunch = getLunch(menu: testMenu)
        print(lunch ?? "No lunch")
        
        // NOTE: Windsor doesn't have breakfast
        let itemID = testMenu?.Meals[1]?.Stations[0]?.Items[0].ID
        let stringID = String(itemID ?? "No item ID")
        print(stringID)
        
        let firstItem = getItem(itemID: stringID)
        print(firstItem)
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        // Validating the Inputs from the User
        let username: String = usernameField.text ?? ""
        let password: String = passwordField.text ?? ""
        
        if username == "" || password == "" {
            let alert = UIAlertController(title: "Error" , message: "Enter Username and Password", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Username or Password Empty")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        /*
        if username.count < 6 || password.count < 6 {
            let alert = UIAlertController(title: "Username or Password Incorrect" , message: "Username/Password too short!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Username or Password too Short")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        if username.count > 12 || password.count > 12{
            let alert = UIAlertController(title: "Username or Password Incorrect" , message: "Username/Password too long!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Username or Password too Long")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
 
        */
        
        
        
    }
    
    
    
    @IBAction func unwindToMainViewController(unwindSegue: UIStoryboardSegue) {
        // Do not need to do anything
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

extension MainViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
