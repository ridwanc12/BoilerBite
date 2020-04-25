//
//  ResidentialMenusController.swift
//  BoilerBite
//
//  Created by Ridwan Chowdhury on 3/26/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import SwiftUI

class ResidentialMenusController: UIViewController {
    
    // Variable for chosen hall
    var chosenHall: String = "earhart"
    
    // MARK: Properties
    @IBAction func buttonEarhart(_ sender: UIButton) {
        chosenHall = "earhart"
    }
    @IBAction func buttonFord(_ sender: UIButton) {
        chosenHall = "ford"
    }
    @IBAction func buttonHillenbrand(_ sender: UIButton) {
        chosenHall = "hillenbrand"
    }
    @IBAction func buttonWiley(_ sender: UIButton) {
        chosenHall = "wiley"
    }
    @IBAction func buttonWindsor(_ sender: UIButton) {
        chosenHall = "windsor"
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        overrideUserInterfaceStyle = .light
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is MealTimeViewController
        {
            let vc = segue.destination as? MealTimeViewController
            vc?.diningHall = chosenHall
            vc?.mealTimes = getFirstDayMeals(hall: chosenHall)
        }
    }
}
