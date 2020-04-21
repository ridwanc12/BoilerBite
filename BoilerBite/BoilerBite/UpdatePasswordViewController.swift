//
//  UpdatePasswordViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 4/4/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class UpdatePasswordViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var currentPasswordText: UITextField!
    @IBOutlet weak var newPasswordText: UITextField!
    
    // Action function when the update button is pressed
    @IBAction func updateTapped(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
