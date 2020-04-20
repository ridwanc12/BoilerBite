//
//  MenuViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 2/24/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var diningHallLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    var items: [Item] = []
    var meals: [Meal] = []
    var stations: [Station] = []
    var meal_num: Int = 1
    
    var diningHall: String = "earhart"
    var mealTime: String = "Lunch"
    
    let sectionHeight = 27
    
    // let items = ["One", "Two", "Three", "Four", "Five"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        //let testMenu = getCurrentMenu(hall: "windsor")

        //items = (testMenu?.Meals[0]?.Stations[0]!.Items)!
        
        diningHallLabel?.text = diningHall.capitalizingFirstLetter()
        diningHallLabel?.sizeToFit()
        diningHallLabel?.adjustsFontSizeToFitWidth = true
        diningHallLabel?.minimumScaleFactor = 0.5
        
        // Menu for current day Earhart for testing
        let testMenu = getFirstDayMenu(hall: diningHall)
        
        // All meals
        meals = testMenu!.Meals as! [Meal]
        
        // Stations for dining hall dinner
        
        // Earhart doesn't serve this Meal
//        stations = meals[3].Stations as! [Station]
//        print (mealTime)
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
//        print(meal_num)
        
        stations = meals[meal_num].Stations as! [Station]
        if (stations.isEmpty) {
            stations.append(Station(Name: "This dining court does not serve this meal", Items: []))
        }
        
        let temp1 = String(meals[meal_num].Hours?.StartTime ?? "")
        let opening = convertTime(time: temp1)
        
        let temp2 = String(describing: meals[meal_num].Hours?.EndTime ?? "")
        let closing = convertTime(time: temp2)
        
        let hoursText = opening + " - " + closing
        
        hoursLabel.text = hoursText
        
//        print(getItemCalories(itemID: "84835539-119a-4efd-b714-786015923e3c"))
//        items = (testMenu?.Meals[1]?.Stations[0]?.Items.map{$0.Name})!
        // Do any additional setup after loading the view.
    }
    
    func convertTime(time: String) -> String {
        let dateIn = DateFormatter()
        dateIn.dateFormat = "HH:mm:ss"
        dateIn.locale = Locale(identifier: "en_US_POSIX")
        let date = dateIn.date(from: time)
        let dateOut = DateFormatter()
        dateOut.dateFormat = "h:mm a"
        return dateOut.string(from: date!)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Menu Cell", for: indexPath)
//        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "Menu Cell")
        
        items = stations[indexPath.section].Items
        let item = items[indexPath.row]

        cell.textLabel?.text = (item.Name).trimmingCharacters(in: .whitespaces)
        cell.textLabel?.numberOfLines = 0
        let calories = String(getItemCalories(itemID: item.ID))
//        print(calories)
        
        if (calories != "-1" && calories != "0") {
            cell.detailTextLabel?.text = calories + " cal"
            cell.detailTextLabel?.textColor = UIColor.darkGray
        }
        else {
            cell.detailTextLabel?.text = nil
        }
    
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is NutritionViewController {
            let vc = segue.destination as? NutritionViewController
            let items = stations[tableView.indexPathForSelectedRow!.section].Items
            let item = items[tableView.indexPathForSelectedRow!.row]
//            print(item.Name)
            vc?.itemID = item.ID
            vc?.diningHall = diningHall
            vc?.mealTime = mealTime
        }
        else if segue.destination is MealTimeViewController {
            let vc = segue.destination as? MealTimeViewController
            vc?.diningHall = diningHall
            vc?.mealTimes = getFirstDayMeals(hall: diningHall)
        }
    }

}

extension String {
   func capitalizingFirstLetter() -> String {
       return prefix(1).capitalized + dropFirst()
   }

   mutating func capitalizeFirstLetter() {
       self = self.capitalizingFirstLetter()
   }
}
