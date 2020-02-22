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
        
        // Menu for Windsor 01-13-2020
        let testMenu = getMeal(hall: "windsor", date: "2020-01-13")

        print("All Hours")
        printDiningHours(menu: testMenu)
        
        print("BLD Hours")
        printBLDHours(menu: testMenu)
        
        print("Late Lunch Hours")
        printLLHours(menu: testMenu)
        
        let testMenu2 = getMeal(hall: "windsor", date: "2020-01-18")
        
        print("Weekend Meal Hours")
        printDiningHours(menu: testMenu2)
    }


}

