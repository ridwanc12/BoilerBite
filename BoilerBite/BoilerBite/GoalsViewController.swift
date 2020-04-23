//
//  GoalsViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 4/18/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class GoalsViewController: UIViewController {
    
    // UI Label Outlets to display the calories on the screen
    @IBOutlet weak var breakfast_cal: UILabel!
    @IBOutlet weak var lunch_cal: UILabel!
    @IBOutlet weak var late_lunch_cal: UILabel!
    @IBOutlet weak var dinner_cal: UILabel!
    @IBOutlet weak var total_daily_cal: UILabel!
    
    @IBOutlet weak var total_goals_cal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Changing all Labels to a Dark Grey color
        // Label.textColor = UIColor.darkGray

        // Do any additional setup after loading the view.
    }
    
    func alert(s: String) {
        let alertController = UIAlertController(title: "Message", message: s, preferredStyle: .alert)
        
        //the confirm action taking the inputs
        let confirmAction = UIAlertAction(title: "OK", style: .default)
        
        //adding the action to dialogbox
        alertController.addAction(confirmAction)
        
        //finally presenting the dialog box
        self.present(alertController, animated: true, completion: nil)
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
