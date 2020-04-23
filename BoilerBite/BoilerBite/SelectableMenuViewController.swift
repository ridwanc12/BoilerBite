//
//  SelectableMenuViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 3/26/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class SelectableMenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var diningHallLabel: UILabel!
    
    @IBOutlet weak var createMealButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    
    var diningHall: String = "earhart"
    var mealTime: String = "Lunch"
    
    // Var to store the running total
    var totalcalories = 0
    var itemList: [String: Int] = [:]
    
    struct MenuItem {
        var calories: Int
        var name: String
    }
    
    var items: [Item] = []
    var meals: [Meal] = []
    var stations: [Station] = []
    
    var meal_num: Int = 1

    let sectionHeight = 27
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diningHallLabel?.text = diningHall.capitalizingFirstLetter()
        diningHallLabel?.sizeToFit()
        diningHallLabel?.adjustsFontSizeToFitWidth = true
        diningHallLabel?.minimumScaleFactor = 0.5
        
        // Menu for current day for the given dining hall for testing
        let testMenu = getFirstDayMenu(hall: diningHall)

        // All meals
        meals = testMenu!.Meals as! [Meal]
                
        // Stations for Earhart dinner
                
        // Earhart doesn't serve this Meal
        //        stations = meals[3].Stations as! [Station]
        
        switch mealTime {
        case "Breakfast":
            meal_num = 0
        case "Lunch":
            meal_num = 1
        case "Late Lunch":
            meal_num = 2
        case "Dinner":
            meal_num = 3
        default:
            meal_num = 1
        }
                
        stations = meals[meal_num].Stations as! [Station]
        if (stations.isEmpty) {
            stations.append(Station(Name: "This dining court does not serve this meal", Items: []))
        }

        // print(getItemCalories(itemID: "84835539-119a-4efd-b714-786015923e3c"))
        // items = (testMenu?.Meals[1]?.Stations[0]?.Items.map{$0.Name})!
        
        // Do any additional setup after loading the view.

    }
    
    // Function for the Create Button
    @IBAction func createMealButton(_ sender: Any) {
//        global_username = "test1"
//        let food_name = itemList.first?.value
        print("meal button")
//        print(food_name!)
        for (key, value) in itemList {
            insertFood(name: global_username, food: key, cal_total: value)
        }
        if (mealTime == "Late Lunch") {
            mealTime = "Late_Lunch"
        }
        insert_items(total_calories: totalcalories, meal: mealTime)
//        insertFood(name: global_username, food: "test", cal_total: totalcalories)
        totalcalories = 0
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
        // print("SectionsCount: %@", count)
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let count = countItems(items: stations[section].Items)
        // print("RowsCount: %@", count)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Menu Cell", for: indexPath) as! MenuTableViewCell
//      let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Menu Cell") as! MenuTableViewCell

        items = stations[indexPath.section].Items
        //  print(items)

        let item = items[indexPath.row]

        //  print(item)
        cell.textLabel?.text = (item.Name).trimmingCharacters(in: .whitespaces)
        cell.textLabel?.numberOfLines = 0
        let calories = String(getItemCalories(itemID: item.ID))

        //  print(calories)
        if (calories != "-1" && calories != "0") {
            cell.detailTextLabel?.text = calories + " cal"
            cell.detailTextLabel?.textColor = UIColor.darkGray
        }
        else {
            cell.detailTextLabel?.text = nil
        }

        return cell
    }
    
    // Function to add the calories of the current item to the running total when a row is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // let cell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        
        // Finding the calories
        items = stations[indexPath.section].Items
        let item = items[indexPath.row]
        let item_name = item.Name
        print(item_name)
        var calories = String(getItemCalories(itemID: item.ID))
        if (calories == "-1") {
            calories = "0"
        }
        
        // Add item and calories to dictionary of items
        itemList[item_name] = Int(calories)
        
        // Add to the running total
        totalcalories += Int(calories) ?? 0
        
        // print("TotalCalories: %@", totalcalories)
        
        // Printing to the label
        let text = String(totalcalories);
        totalLabel.text = text + " cal"
        totalLabel.textColor = UIColor.darkGray
    }
    
    // Function to remove the calories of the current item from the running total when a row is deselected
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
        // Finding the calories
        items = stations[indexPath.section].Items
        let item = items[indexPath.row]
        let item_name = item.Name
        var calories = String(getItemCalories(itemID: item.ID))
        if (calories == "-1") {
            calories = "0"
        }
        
        // Add item and calories to dictionary of items
        itemList[item_name] = Int(calories)
        
        // Add to the running total
        totalcalories -= Int(calories) ?? 0
        
        // Printing to the label
        let text = String(totalcalories);
        totalLabel.text = text + " cal"
        totalLabel.textColor = UIColor.darkGray
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MealTimeViewController {
            let vc = segue.destination as? MealTimeViewController
            vc?.diningHall = diningHall
            vc?.mealTimes = getFirstDayMeals(hall: diningHall)
        }
    }
    

}
