//
//  ViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 2/15/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let testMenu = getMeal(hall: "windsor", date: "2020-01-13")
//        print(testMenu)
        
//        let testMenu = getMeal(hall: "windsor", date: "2020-01-13")
        if testMenu != nil {
            for meal in testMenu!.Meals {
                print(meal?.Name ?? "No Meal")
                print(meal?.Hours ?? "No Time")
            }
        }
        else {
            print("nil in testMenu")
        }
        
    }


}

