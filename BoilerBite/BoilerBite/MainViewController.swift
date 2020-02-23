//
//  MainViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 2/22/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Menu for Windsor 01-13-2020
        let testMenu = getMeal(hall: "windsor", date: "2020-01-13")

        print("All Hours")
        let diningHours = getDiningHours(menu: testMenu)
        print(diningHours)
        
        print("BLD Hours")
        let BLDHours = getBLDHours(menu: testMenu)
        print(BLDHours)
        
        print("Late Lunch Hours")
        let LLHours = getLLHours(menu: testMenu)
        print(LLHours)
        
        let testMenu2 = getMeal(hall: "windsor", date: "2020-01-18")
        
        print("Weekend Meal Hours")
        let weekendHours = getDiningHours(menu: testMenu2)
        print(weekendHours)
    }
    
    @IBAction func unwindToMainViewController(unwindSegue: UIStoryboardSegue) {
        // Do not need to do anything
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
