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
    
//    let items = [
//        MenuItem(calories: 100, name: "One"),
//        MenuItem(calories: 200, name: "Two"),
//        MenuItem(calories: 300, name: "Three"),
//        MenuItem(calories: 400, name: "Four"),
//        MenuItem(calories: 500, name: "Five"),
//    ]

    var items: [Item] = []
    
    // let items = ["One", "Two", "Three", "Four", "Five"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let testMenu = getCurrentMenu(hall: "windsor")

        items = (testMenu?.Meals[3]?.Stations[0]!.Items)!
        
//        print(getItemCalories(itemID: "84835539-119a-4efd-b714-786015923e3c"))
//        print(getItem(itemID: "84835539-119a-4efd-b714-786015923e3c"))
//        items = (testMenu?.Meals[1]?.Stations[0]?.Items.map{$0.Name})!
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
        cell.textLabel?.text = item.Name
        cell.detailTextLabel?.text = String(getItemCalories(itemID: item.ID))
//        cell.textLabel?.text = item.name
//        cell.detailTextLabel?.text = String(item.calories)
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
