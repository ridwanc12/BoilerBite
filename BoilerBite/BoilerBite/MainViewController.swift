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
        passwordField.isSecureTextEntry = true
        
        // Testing dining hours functions in main
//        diningHoursExample()
        
        // Testing meal and item requests functions in main
//        mealRequest()
        
        //print(username)
        //print(password)
        
        //databaseRequest4(user: username, password: password) // prev was "" ""
    }
    
    func diningHoursExample() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-13")

        print("All Hours")
        let diningHours = getDiningHours(menu: testMenu)
        print(diningHours)
        
        print("BLD Hours")
        let BLDHours = getBLDHours(menu: testMenu)
        print(BLDHours)
        
        print("Late Lunch Hours")
        let LLHours = getLLHours(menu: testMenu)
        print(LLHours)
        
        let testMenu2 = getMenu(hall: "windsor", date: "2020-01-18")
        
        print("Weekend Meal Hours")
        let weekendHours = getDiningHours(menu: testMenu2)
        print(weekendHours)
    }
    
    func mealRequest() {
        let testMenu = getMenu(hall: "windsor", date: "2020-01-13")
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
        
        var flag = 0
        
        print("username: ", username)
        print("password: ", password)
        
        if username.count < 6 || username.count > 12 {
            flag = 1;
            let alert = UIAlertController(title: "Error" , message: "Length should be between 6 and 12", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Username or Password Empty")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        if username == "" || password == "" {
            flag = 1;
            let alert = UIAlertController(title: "Error" , message: "Enter Username and Password", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Username or Password Empty")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        var arg = 0;
        if flag == 0 {
            arg = databaseRequest4(user: username, password: password) // added by uc
            global_username = username
            global_password = password
            
            //getStuff(userName: username);
        }
               
               if arg == 0 {
                   flag = 1;
                   let alert = UIAlertController(title: "Error" , message: "Wrong password or username", preferredStyle: .alert)
                   
                   let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                       print("Wrong password or username")
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
    
    let URL_SAVE_TEAM = URL(string: "http://10.192.122.81/MyWebService/api/createteam.php")
       
       //TextFields declarations
       @IBOutlet weak var textFieldName: UITextField!
       @IBOutlet weak var textFieldMember: UITextField!
    
       // the content inside UC
       //Button action method
       @IBAction func buttonSave(sender: UIButton) {
        
        
        
       }
    // added by UC
    
    // added by UC
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        func databaseRequest4(user: String, password: String) -> Int {
            
            print("username: ", user)
            print("password: ", password)
            global_username = user
            global_password = password
            let semaphore = DispatchSemaphore (value: 0)
            
            var arg = 0;
            //let username: String = usernameField.text ?? ""
            //let password: String = passwordField.text ?? ""
            
            // user changed to username
            
            //let urlString = String(format: "http://10.192.122.81/MyWebService/api/createteam.php?name=%@&member=%@", user, password)  // might have to change the use
            
            let urlString = String(format: "https://boilerbite.000webhostapp.com/php/createteam.php?userName=%@&hashPass=%@", user, password);
            var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            request.httpMethod = "POST"

            let task = URLSession.shared.dataTask(with: request) { data, response, error in
              guard let data = data else {
                print(String(describing: error))
                return
              }
              
             
               print(String(data: data, encoding: .utf8)!)
               //print("data is ovverated")
               //print(String(data:data))
                let str = String(data: data, encoding: .utf8)!
                //print("printing:" , str)
                if(str.last == "1") {
                  //print("llllloooolllll")
                    arg = 1
                }
              semaphore.signal()
            }
            task.resume()
            semaphore.wait()
            return arg;
        }

    }

    func getStuff(userName: String) {
        let semaphore = DispatchSemaphore (value: 0)
        let urlString = String(format: "https://boilerbite.000webhostapp.com/php/getteams.php?userName=%@", userName);
        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          
         
           //print(String(data: data, encoding: .utf8)!)
           //print("data is ovverated")
           //print(String(data:data))
         let str = String(data: data, encoding: .utf8)
            
         // print(str);
            //str.spit
            let arr = str?.split(separator: " ")
            print(arr![0]);
            print(arr![1]);
            print(arr![2]);
            print(arr![3]);
            print(arr![4]);
            print(arr![5]);
            //global_username = username
            //global_email = arr![1];
            let a = String(arr![2]);
            let b = String(arr![3]);
            let c = String(arr![4]);
            let d = String(arr![5]);
            
            global_height = Int(a)!
            global_weight = Int(b)!
            global_age = Int(c)!;
            global_calories = Int(d)!;
            
            print("height: ", global_height);
            print("weight: ", global_weight);
            print("age: ", global_age);
            print("calories: ", global_calories);

            
         semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }


    extension MainViewController : UITextFieldDelegate {
        
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    }
