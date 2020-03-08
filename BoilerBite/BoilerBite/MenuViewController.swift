//
//  MenuViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 2/24/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var MenuTableView: UITableView!
    
    struct MenuItem {
        var calories: Int
        var name: String
    }
    
    let items = [
        MenuItem(calories: 100, name: "One"),
        MenuItem(calories: 200, name: "Two"),
        MenuItem(calories: 300, name: "Three"),
        MenuItem(calories: 400, name: "Four"),
        MenuItem(calories: 500, name: "Five"),
    ]
    
    // let items = ["One", "Two", "Three", "Four", "Five"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Menu Cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel?.text = String(item.calories)
        return cell
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
