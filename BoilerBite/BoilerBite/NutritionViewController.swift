//
//  NutritionViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 4/10/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class NutritionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
//    let labelsDict:[String: String] = ["Serving Size":"Servings", "Calories":"", "Calories from fat":"", "Total fat":"g", "Saturated fat":"g", "Cholesterol":"mg", "Sodium":"mg", "Total Carbohydrate":"g", "Sugar":"g", "Dietary Fiber":"g", "Protein":"g", "Vitamin A":"% of DV", "Vitamin C":"% of DV", "Calcium":"% of DV", "Iron":"% of DV"]
    
    let itemID = "da968774-9381-4a03-ae26-87b765fb80f6"
//    let items = ["One", "Two", "Three", "Four", "Five"]
    var nutrition:[NutritionFact] = []
    var items: [String] = []
    var values: [String] = []
    
    // For Back Segue
    var diningHall: String = "earhart"
    var mealTime: String = "lunch"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nutrition = getItemNutrition(itemID: itemID)
        
        print(nutrition)
        
        for fact in nutrition {
            items.append(fact.Name)
            values.append(fact.LabelValue ?? fact.DailyValue ?? "")
        }
        
        print(items)
        print(values)

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 49 // height for every row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Nutrition Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.detailTextLabel?.text = values[indexPath.row]
        cell.detailTextLabel?.textColor = UIColor.darkGray
        return cell
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.destination is MenuViewController {
            let vc = segue.destination as? MenuViewController
            vc?.diningHall = diningHall
            vc?.mealTime = mealTime
        }
        
    }
    

}

//if (values[indexPath.row] != 0.0) {
//            var value = ""
//            // Special cases
//            if (items[indexPath.row] == "Vitamin A") {
//                value = nutrition[indexPath.row].DailyValue ?? ""
//            } else if (items[indexPath.row] == "Vitamin C") {
//                value = String(Int(values[indexPath.row] / 65.0 * 100))
//            } else if (items[indexPath.row] == "Calcium") {
//                value = String(Int(values[indexPath.row] / 900.0 * 100))
//            } else if (items[indexPath.row] == "Iron") {
//                value = String(Int(values[indexPath.row] / 17.0 * 100))
//            }
//            else {
//                value = String(Int(values[indexPath.row]))
//            }
//            // Value and label
//            cell.detailTextLabel?.text = value + (labelsDict[items[indexPath.row]] ?? "")
//        }
//        else {
//            cell.detailTextLabel?.text = ""
//        }
