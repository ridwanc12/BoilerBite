//
//  CreateProfileViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 2/24/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController {
    
    //var username = String?

    @IBOutlet weak var caloriesField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light

        // Do any additional setup after loading the view.
        // Getting the macros entered
        //nameLabel.text = username
        caloriesField.delegate = self
    }
    
    // Action function for when the Enter button is tapped
    @IBAction func enterTapped(_ sender: Any) {
        
        let calories: Int = Int(caloriesField.text ?? "0") ?? 0
        
        // Validating the Inputs from the User
        
        if calories == 0 {
            let alert = UIAlertController(title: "Error" , message: "Enter all information!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Some field Empty")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        if calories < 0 {
            let alert = UIAlertController(title: "Error" , message: "Enter a valid number of calories!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Calories less than 0")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        //let username:String = "qwertyuiop"
        global_calories = calories
        calorie_input(calories:calories, username:global_username);
    }
    
    func calorie_input(calories: Int ,username: String) {
        let semaphore = DispatchSemaphore (value: 0)

        //let username: String = usernameField.text ?? ""
        //let password: String = passwordField.text ?? ""
        
        // user changed to username
        //let username = "sssssss"
        //print("calories: " ,calories)
        //print("username: " ,username)
        
        //let userr:String = String(global_username ?? "0") ?? "ss"
        //let calories: Int = Int(caloriesField.text ?? "0") ?? 0
        
        let urlString = String(format: "http://boilerbite.000webhostapp.com/php/calorie_update.php?userName=%@&calories_total=%@", global_username, String(calories))
        
        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
    
    // Hide the Number Pad when clicked on the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        caloriesField.resignFirstResponder()
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



extension CreateProfileViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}


