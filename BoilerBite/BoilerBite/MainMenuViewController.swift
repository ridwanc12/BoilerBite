//
//  MainMenuViewController.swift
//  BoilerBite
//
//  Created by Ridwan Chowdhury on 3/30/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        getStuff(userName: global_username);
    }
}
