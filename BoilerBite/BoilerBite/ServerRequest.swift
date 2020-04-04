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

func insertUser(name: String, mail: String, pass: String){
//    let name = "Isha"
//    let mail = "isha@gmail.com"
//    let pass = "isha"
    let link = "https://boilerbite.000webhostapp.com/php/insertUser.php"
    let request = NSMutableURLRequest(url: NSURL(string: link)! as URL)
    request.httpMethod = "POST"
    // Send values to php script
    let postString = "userName=\(name)&userEmail=\(mail)&pass=\(pass)"
    request.httpBody = postString.data(using: String.Encoding.utf8)
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in

        if error != nil {
            //print(error)
            return
        }

        //print("response = \(String(describing: response))")

        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("responseString = \(String(describing: responseString))")
    }
    task.resume()
}

// Function to test php script to delete user from database
func deleteUser(name: String, pass: String) {
//    let name = "Isha"
//    let pass = "isha"
    let link = "https://boilerbite.000webhostapp.com/php/deleteUser.php"
    let request = NSMutableURLRequest(url: NSURL(string: link)! as URL)
    request.httpMethod = "POST"
    // Send values to php script
    let postString = "userName=\(name)&pass=\(pass)"
    request.httpBody = postString.data(using: String.Encoding.utf8)
    
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in

        if error != nil {
            //print(error)
            return
        }

        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as String?
        let response = String(describing: responseString)
        print(response)
        if (response.contains("User not in database.")) {
            print("No such user")
        } else if (response.contains("password")){
            print("Incorrect password")
        } else {
            print("User deleted")
        }
        //print("responseString = ")
    }
    task.resume()
    
}

// Can use functions like the following
//insertUser(name: "Rid", mail: "rid", pass: "rid")
//insertFood(name: "Rid", food: "Protein", cal_total: 1234)

// Function to add food item to progress table
func insertFood(name: String, food: String, cal_total: Int){
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
        print("responseString = \(String(describing: responseString))")
    }
    task.resume()
}
