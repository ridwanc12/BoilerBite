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
    
    let itemID = "84835539-119a-4efd-b714-786015923e3c"
//    let items = ["One", "Two", "Three", "Four", "Five"]
    var nutrition:[NutritionFact] = []
    var items: [String] = []
    var values: [Float] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nutrition = getItemNutrition(itemID: itemID)
        
        for fact in nutrition {
            items.append(fact.Name)
            values.append(fact.Value ?? 0.0)
        }
        
//        print(items)
//        print(values)

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Nutrition Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        if (values[indexPath.row] != 0.0) {
            cell.detailTextLabel?.text = String(Int(values[indexPath.row]))
        }
        else {
            cell.detailTextLabel?.text = ""
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

