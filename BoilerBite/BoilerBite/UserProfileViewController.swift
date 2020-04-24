//
//  UserProfileViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 3/30/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController , UITextFieldDelegate{
    
    //Labels
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    
    
    // Outlet for the Name (First Last) displayed at the top of the screen
    // Which should be updated to show the name of the current user
    @IBOutlet weak var nameLabel: UILabel! {
      didSet {
         nameLabel.text = "\(user)"
      }
    }
    var user = global_username
    
    // Outlets for the user information
    @IBOutlet weak var heightText: UITextField! {
        didSet {
            heightText.text = String(global_height)
            heightText.textColor = UIColor.darkGray
        }
    }
    @IBOutlet weak var weightText: UITextField! {
        didSet {
            weightText.text = String(global_weight)
            weightText.textColor = UIColor.darkGray
        }
    }
    @IBOutlet weak var ageText: UITextField! {
        didSet {
            ageText.text = String(global_age)
            ageText.textColor = UIColor.darkGray
        }
    }
    @IBOutlet weak var caloriesText: UITextField! {
        didSet {
            caloriesText.text = String(global_calories)
            caloriesText.textColor = UIColor.darkGray
        }
    }
    
    // Outlet for the Update Button
    @IBOutlet weak var updateButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        heightText.delegate = self
        weightText.delegate = self
        ageText.delegate = self
        caloriesText.delegate = self
        
        heightLabel.textColor = UIColor.darkGray
        weightLabel.textColor = UIColor.darkGray
        ageLabel.textColor = UIColor.darkGray
        caloriesLabel.textColor = UIColor.darkGray

        // Do any additional setup after loading the view.
    }
    
    //@IBAction func updateTapped(_ sender: UIButton) {
    //}
    @IBAction func updateTapped(_ sender: UIButton) {
        let height: Int = Int(heightText.text ?? "0") ?? 0
        let weight: Int = Int(weightText.text ?? "0") ?? 0
        let age: Int = Int(ageText.text ?? "0") ?? 0
        let calories: Int = Int(caloriesText.text ?? "0") ?? 0
        
        var flag = 0
        if height <= 0 || weight <= 0 || age <= 0 || calories <= 0{
            flag = 1;
            let alert = UIAlertController(title: "Error" , message: "Enter all information correctly!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Some field Empty or incorrect")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        print("height: " ,height)
        print("calories: " ,calories)
        if flag == 0 {
            update_info(username: global_username, height: height, weight: weight, age: age);
            update_calories(username: global_username, calories: calories)
        }
        
        global_height = height
        global_weight = weight
        global_age = age
        global_calories = calories
        
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

func update_info(username: String, height: Int, weight: Int, age: Int) {
    print("username: " ,username)
    print("height: " ,height)
    let semaphore = DispatchSemaphore (value: 0)
    
    let urlString = String(format: "http://boilerbite.000webhostapp.com/php/update_info.php?userName=%@&height=%@&weight=%@&age=%@", username, String(height), String(weight), String(age))
    var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
    
    request.httpMethod = "POST"

    global_username = username
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

func update_calories(username: String, calories: Int) {
    print("username: " ,username)
    print("calories: " ,calories)
    let semaphore = DispatchSemaphore (value: 0)
    //var arg = 0
    //let username: String = usernameField.text ?? ""
    //let password: String = passwordField.text ?? ""
    
    // user changed to username
    
    //print("hashpass2 : ", password)
    
    let urlString = String(format: "http://boilerbite.000webhostapp.com/php/change_calorie.php?userName=%@&calories_total=%@", username, String(calories))
    var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
    
    request.httpMethod = "POST"

    global_username = username
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        return
      }
      print(String(data: data, encoding: .utf8)!)
      //print(String(data: data, encoding: .utf8)!)
      //print("data is ovverated")
      //print(String(data:data))
       //let str = String(data: data, encoding: .utf8)
       //print("printing:" , str)
       //if(str == "\n\n1") {
         //print("llllloooolllll")
           //arg = 1
       //}
      //semaphore.signal()
    }
    task.resume()
    semaphore.wait()
    //return arg
}
