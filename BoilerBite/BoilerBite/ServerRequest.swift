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

        print("response = \(String(describing: response))")

        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("responseString = \(String(describing: responseString))")
    }
    task.resume()
}

// Function to test php script to delete user from database
func deleteUser(name: String, pass: String){
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

        print("response = \(String(describing: response))")

        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("responseString = \(String(describing: responseString))")
    }
    task.resume()
}

// Function to add food item to progress table
func insertFood(name: String, pass: String, cal_total: Int){
//    let name = "Isha"
//    let pass = "isha"
    let link = "https://boilerbite.000webhostapp.com/php/insertFood.php"
    
//    let cal_total = 0;
    let cal_fat = 0;
    let g_fat = 0;
    let g_protein = 0;
    let g_carb = 0;
    
    let request = NSMutableURLRequest(url: NSURL(string: link)! as URL)
    request.httpMethod = "POST"
    // Send values to php script
    let postString = "userName=\(name)&food_name=\(pass)&total_calorie=\(cal_total)&calorie_fat=\(cal_fat)&gram_fat=\(g_fat)&gram_protein=\(g_protein)&gram_carb=\(g_carb)"
    request.httpBody = postString.data(using: String.Encoding.utf8)
    
    let task = URLSession.shared.dataTask(with: request as URLRequest) {
        data, response, error in

        if error != nil {
            //print(error)
            return
        }

        print("response = \(String(describing: response))")

        let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("responseString = \(String(describing: responseString))")
    }
    task.resume()
}
