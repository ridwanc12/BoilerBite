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
//        showInputDialog()
//        global_username = "ridwan"
//        global_password = "ridwan"
        let incorrect_pass = global_password + global_username
        let alert = UIAlertController(title: "Delete User", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Password"
        })

        alert.addAction(UIAlertAction(title: "Confirm", style: .default, handler: { action in

            if let pass = alert.textFields?.first?.text {
                print("Password is: \(pass)")
            }
        }))

        self.present(alert, animated: true)
        
        deleteUser(name: global_username, pass: incorrect_pass)
        sleep(1)
        deleteUser(name: global_username, pass: global_password)
        print("Delete action performed")
        global_username = "Not logged in"
        global_password = "Not logged in"
    }
    
    // Fucntion for when the "logout" button is pressed
    @IBAction func logoutButton(_ sender: UIButton) {
        global_username = ""
        global_password = ""
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func showInputDialog() {
        //Creating UIAlertController and
        //Setting title and message for the alert dialog
        let alertController = UIAlertController(title: "Enter login information", message: "Enter your username and password", preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "Enter", style: .default) { (_) in
            
            //getting the input values from user
            let username = alertController.textFields?[0].text
            let password = alertController.textFields?[1].text
            
            
            if (username! != "" && password! != "") {
                print(username!)
                print(password!)
            }
            else {
                print("nay")
            }
            
        }
        
        //the cancel action doing nothing
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (_) in }
        
        //adding textfields to our dialog box
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Username"
        }
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter Password"
        }
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
    }
    
    // Fucntion for when the "send feedback" button is pressed
    @IBAction func sendFeedbackButton(_ sender: UIButton) {
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


