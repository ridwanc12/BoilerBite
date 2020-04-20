//
//  MealTimeViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 4/4/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class MealTimeViewController: UIViewController {
    
    let image = UIImage(named:"text-box")
    
    @IBOutlet weak var stackview: UIStackView!
    
    var diningHall: String = "earhart";
    var chosenMealTime: String = "Lunch"
    
    // Sample Array of Buttons
    var mealTimes = ["Breakfast", "Lunch", "Late Lunch", "Dinner"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(white: 0.25, alpha: 1.0)
        // view.addSubview(makeButtonWithText(text: "Button 1"))
        
        // Creating the Buttons
        for item in mealTimes {
           stackview.addArrangedSubview(makeButtonWithText(text: item))
        }
        
//        print(mealTimes)
        
    }
    
    // Make a button with the String passed in
    func makeButtonWithText(text:String) -> UIButton {
        let myButton = UIButton(type: UIButton.ButtonType.system)
        myButton.frame = CGRect(x: 72, y: 360, width: 230, height: 45)
        myButton.setTitle(text, for: UIControl.State.normal)
        myButton.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        myButton.setBackgroundImage(image, for: UIControl.State.normal)
        
        //Assign a target (i.e. action) to the button
        myButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return myButton
    }
    
    //MARK: - Actions and Selectors
    @IBAction func buttonPressed(sender:UIButton) {
//        print(sender.title(for: .normal))
        chosenMealTime = sender.title(for: .normal)!
        self.performSegue(withIdentifier: "MealTimeSegue", sender: self)
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "MealTimeSegue" {
            if segue.destination is MenuViewController {
                let vc = segue.destination as? MenuViewController
                vc?.diningHall = diningHall
                vc?.mealTime = chosenMealTime
            }
            else if segue.destination is SelectableMenuViewController {
                let vc = segue.destination as? SelectableMenuViewController
                vc?.diningHall = diningHall
                vc?.mealTime = chosenMealTime
            }
        }
        
        
    }

}
