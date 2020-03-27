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
    @IBAction func earhartButton(_ sender: UIButton) {
        chosenHall = "earhart"
    }
    @IBAction func fordButton(_ sender: UIButton) {
        chosenHall = "ford"
    }
    @IBAction func hillenbrandButton(_ sender: UIButton) {
        chosenHall = "hillenbrand"
    }
    @IBAction func wileyButton(_ sender: UIButton) {
        chosenHall = "wiley"
    }
    @IBAction func windsorButton(_ sender: UIButton) {
        chosenHall = "windsor"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is MenuViewController
        {
            let vc = segue.destination as? MenuViewController
            vc?.diningHall = chosenHall
        }
    }
}
