//
//  SettingsViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 3/30/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    // Outlets for the Delete Account and Logout Button
    
    // Fucntion for when the "delete" button is pressed
    @IBAction func deleteButton(_ sender: UIButton) {
        showInputDialog()
        //print("Delete action performed")
        
    }
    func alert(s: String) {
        let alertController = UIAlertController(title: "Message", message: s, preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "OK", style: .default)
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Fucntion for when the "logout" button is pressed
    @IBAction func logoutButton(_ sender: UIButton) {
        global_username = ""
        global_password = ""
//        let s = insertFood(name: "admini", food: "Mac", cal_total: 1234)
//        alert(s: s)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        let s = checkProgress(name: "admini")
//        alert(s: s)
    }
    
    func showInputDialog(){
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Enter login information", message: "Enter your password", preferredStyle: .alert)
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let password = alertController.textFields?[0].text
            if (password! != "") {
                print(global_username)
                print(password!)
                let s = deleteUser(name: global_username, pass: password!)
                self.alert(s: s)
                global_username = "Not logged in"
                global_password = "Not logged in"
            }
            else {
                print("nay")
            }
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.isSecureTextEntry = true
            textField.placeholder = "Enter password"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Fucntion for when the "send feedback" button is pressed
    @IBAction func sendFeedbackButton(_ sender: UIButton) {
        let s = insertFood(name: "admini", food: "Mac", cal_total: 1234)
        alert(s: s)
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


