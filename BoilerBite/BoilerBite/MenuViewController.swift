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
    var meals: [Meal] = []
    var stations: [Station] = []
    
    let sectionHeight = 27
    
    // let items = ["One", "Two", "Three", "Four", "Five"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Menu for current day Earhart for testing
        let testMenu = getCurrentMenu(hall: "earhart")
        
        // All meals
        meals = testMenu!.Meals as! [Meal]
        
        // Stations for Earhart dinner
        
        // Earhart doesn't serve this Meal
//        stations = meals[3].Stations as! [Station]
        
        stations = meals[1].Stations as! [Station]
        if (stations.isEmpty) {
            stations.append(Station(Name: "This dining court does not serve this meal", Items: []))
        }
        
//        print(getItemCalories(itemID: "84835539-119a-4efd-b714-786015923e3c"))
//        items = (testMenu?.Meals[1]?.Stations[0]?.Items.map{$0.Name})!
        // Do any additional setup after loading the view.
    }
    
    // Helper function for counting number of items due to ambiguousness of count() function
    func countItems(items: [Item]) -> Int {
        var count = 0
        for _ in items {
            count += 1
        }
        return count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        var count = 0
        for _ in stations {
            count += 1
        }
//        print("SectionsCount: %@", count)
        return count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = countItems(items: stations[section].Items)
//        print("RowsCount: %@", count)
        return count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: Int(tableView.bounds.width), height: sectionHeight))
        view.backgroundColor = UIColor(red: 242.0/255.0, green: 182.0/255.0, blue: 97.0/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: Int(tableView.bounds.width - 30), height: sectionHeight))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        label.text = stations[section].Name
        view.addSubview(label)
        return view
    }
    
    private func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> Int {
      // If we wanted to always show a section header regardless of whether or not there were rows in it,
      // then uncomment this line below:
//        return sectionHeight
        
      // First check if there is a valid section of table.
      // Then we check that for the section there is more than 1 row.
        if (countItems(items: stations[section].Items) > 0) {
            return sectionHeight
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Menu Cell", for: indexPath)
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Menu Cell")
        
        items = stations[indexPath.section].Items
//        print(items)
        let item = items[indexPath.row]
//        print(item)
        cell.textLabel?.text = (item.Name).trimmingCharacters(in: .whitespaces)
        cell.textLabel?.numberOfLines = 0
        let calories = String(getItemCalories(itemID: item.ID))
//        print(calories)
        if (calories != "-1") {
            cell.detailTextLabel?.text = calories + " cal"
            cell.detailTextLabel?.textColor = UIColor.darkGray
        }
    
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
