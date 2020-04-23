//
//  ServerRequest.swift
//  BoilerBite
//
//  Created by Ridwan Chowdhury on 3/29/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit
import Foundation

var global_username: String = "Not logged in"
var global_password: String = "Not logged in"
var global_height: Int = 0
var global_weight: Int = 0
var global_age: Int = 0
var global_calories: Int = 0

func checkProgress(name: String) -> String{
//    let name = "Isha"
//    let mail = "isha@gmail.com"
//    let pass = "isha"
    let link = "https://boilerbite.000webhostapp.com/php/checkMeal.php"
    let request = NSMutableURLRequest(url: NSURL(string: link)! as URL)
    request.httpMethod = "POST"
    // Send values to php script
    let postString = "userName=\(name)"
    request.httpBody = postString.data(using: String.Encoding.utf8)
    var s = "ERROR"
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in

        if error != nil {
            //print(error)
            return
        }
        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        //print("responseString = \(String(describing: responseString))")
        s = String(describing: responseString!)
        semaphore.signal()
    }
    task.resume()
    semaphore.wait()
    return s
}

// Function to test php script to delete user from database
func deleteUser(name: String, pass: String) -> String {
//    let name = "Isha"
//    let pass = "isha"
    print(name)
    let link = "https://boilerbite.000webhostapp.com/php/deleteUser.php"
    let request = NSMutableURLRequest(url: NSURL(string: link)! as URL)
    request.httpMethod = "POST"
    // Send values to php script
    let postString = "userName=\(name)&pass=\(pass)"
    request.httpBody = postString.data(using: String.Encoding.utf8)
    var s = "ERROR"
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in

        if error != nil {
            //print(error)
            return
        }

        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as String?
        let response = String(describing: responseString!)
        print(response)
        if (response.contains("User not in database.")) {
            s = "No such user"
        } else if (response.contains("password")){
            s = "Incorrect password"
        } else {
            s = "User deleted"
        }
        semaphore.signal()
        //print("responseString = ")
    }
    task.resume()
    semaphore.wait()

    return s
}

// Can use functions like the following
//insertUser(name: "Rid", mail: "rid", pass: "rid")
//insertFood(name: "Rid", food: "Protein", cal_total: 1234)

// Function to add food item to progress table
func insertFood(name: String, food: String, cal_total: Int) -> String{
//    let name = "Isha"
//    let pass = "isha"
//    let cal_total = 0;
    let link = "https://boilerbite.000webhostapp.com/php/insertFood.php"
    
    let cal_fat = 0;
    let g_fat = 0;
    let g_protein = 0;
    let g_carbs = 0;
    
    let request = NSMutableURLRequest(url: NSURL(string: link)! as URL)
    request.httpMethod = "POST"
    // Send values to php script
    var s = "ERROR"
    let semaphore = DispatchSemaphore(value: 0)
    let postString = "userName=\(name)&food_name=\(food)&total_calorie=\(cal_total)&calorie_fat=\(cal_fat)&gram_fat=\(g_fat)&gram_protein=\(g_protein)&gram_carbs=\(g_carbs)"
    request.httpBody = postString.data(using: String.Encoding.utf8)
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in

        if error != nil {
            //print(error)
            return
        }

        //print("response = \(String(describing: response))")

        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        //print("responseString = \(String(describing: responseString))")
        s = String(describing: responseString!)
        semaphore.signal()
    }
    task.resume()
    semaphore.wait()
    return s
}

func insert_items(total_calories:Int, meal:String) {
    // date except in form yyyy/mm/dd
    
    print("cl: " ,total_calories)
    print("meal: ", meal)
    
    let semaphore = DispatchSemaphore (value: 0)
    //var arg = 0
    //let username: String = usernameField.text ?? ""
    //let password: String = passwordField.text ?? ""
    
    // user changed to username
    
    //print("hashpass2 : ", password)
    let date = Date()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let current_date = dateFormatter.string(from: date)
    print("current_date-->",current_date)
    //let te = String(current_date)
    //let fin_date = Int(te)
    
    let urlString = String(format: "http://boilerbite.000webhostapp.com/php/meal_insert.php?userName=%@&calories_total=%@&meal=%@&date=%@", global_username, String(total_calories), meal, current_date);
    var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
    
    request.httpMethod = "POST"

    //global_username = username
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
      guard let data = data else {
        print(String(describing: error))
        return
      }
      //print(String(data: data, encoding: .utf8)!)
      print(String(data: data, encoding: .utf8)!)
      semaphore.signal()
    }
    task.resume()
    semaphore.wait()
    //return arg
}

func get_meal (date: String) {
    
    print("date: ", date)
    
    let semaphore = DispatchSemaphore (value: 0)
    let urlString = String(format: "http://boilerbite.000webhostapp.com/php/getcalorie.php?userName=%@&date=%@", global_username, date);
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
        
     //print(str);
        //str.spit
        let arr = str?.split(separator: " ")
        print(arr![0]);
        
        let length = Int(arr![1])
        var i = 0;
        while(i < length!) {
            i = i + 2;
            let temp = (arr![i]).split(separator: ",")
            print(temp[0]);
            print(temp[1]);
        }
        //print(arr![1]);
        //print(arr![2]);
        //print(arr![3]);
        //print(arr![4]);
        //global_username = username
        //global_email = arr![1];
        //let a = String(arr![2]);
        //let b = String(arr![3]);
        //let c = String(arr![4]);
        
        //global_height = Int(a)!
        //global_weight = Int(b)!
        //global_age = Int(c)!;
        
     semaphore.signal()
    }
    task.resume()
    semaphore.wait()
}
