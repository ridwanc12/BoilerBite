//
//  CreateProfileViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 2/24/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class CreateProfileViewController: UIViewController {

    @IBOutlet weak var caloriesField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Getting the macros entered
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
