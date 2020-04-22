//
//  ApiRequest.swift
//  BoilerBite
//
//  Created by Ridwan Chowdhury on 2/22/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//
import UIKit
import Foundation

func getMenu(hall: String, date: String) -> Menu? {
    let address = String(format: "https://api.hfs.purdue.edu/menus/v2/locations/%@/%@", hall, date)
    let requestLocation = URL(string: address)
    
    var menu: Menu?
    
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: requestLocation!) { (data, response, error) in
        do {
            menu = try JSONDecoder().decode(Menu.self, from: data!)
            semaphore.signal()
            //print(menu!)
        } catch {
            print("There was an error in the menu api request")
            print(error)
        }
    }
    
    task.resume()
    semaphore.wait()
    
    return(menu)
}

func getFirstDayMenu(hall: String) -> Menu? {
    let address = String(format: "https://api.hfs.purdue.edu/menus/v2/locations/%@/%@", hall, "2020-01-13")
    let requestLocation = URL(string: address)
    
    var menu: Menu?
    
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: requestLocation!) { (data, response, error) in
        do {
            menu = try JSONDecoder().decode(Menu.self, from: data!)
            semaphore.signal()
            //print(menu!)
        } catch {
            print("There was an error in the menu api request")
            print(error)
        }
    }
    
    task.resume()
    semaphore.wait()
    
    return(menu)
}

// Note: This function is currently not useful due to quarantine
// Thanks COVID
func getCurrentMenu(hall: String) -> Menu? {
    let date = String(describing: Date())
    let first = date.components(separatedBy: " ").first
    
    let address = String(format: "https://api.hfs.purdue.edu/menus/v2/locations/%@/%@", hall, first!)
    let requestLocation = URL(string: address)
    
    var menu: Menu?
    
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: requestLocation!) { (data, response, error) in
        do {
            menu = try JSONDecoder().decode(Menu.self, from: data!)
            semaphore.signal()
            //print(menu!)
        } catch {
            print("There was an error in the menu api request")
            print(error)
        }
    }
    
    task.resume()
    semaphore.wait()
    
    return(menu)
}

func getMeals(hall: String, date: String) -> [String] {
    let menu = getMenu(hall: hall, date: date)
    let meals = menu!.Meals
    var meal_names:[String] = []
    for item in meals {
        if (item?.Status != "Closed") {
            meal_names.append(item!.Name)
        }
    }
    
    return meal_names
}

func getFirstDayMeals(hall: String) -> [String] {
    let menu = getFirstDayMenu(hall: hall)
    let meals = menu!.Meals
    var meal_names:[String] = []
    for item in meals {
        if (item?.Status != "Closed") {
            meal_names.append(item!.Name)
        }
    }
    
    return meal_names
}

func getOpenHours(hall: String) -> [String] {
    return []
}

func getFirstDayHours(hall: String) -> [Hour] {
    let menu = getFirstDayMenu(hall: hall)
    let meals = menu!.Meals
    var meal_hours:[Hour] = []
    for item in meals {
        if (item?.Status != "Closed") {
            meal_hours.append(item!.Hours!)
        }
    }
    
    return meal_hours
}

func getDinner(menu: Menu?) -> Meal? {
    for meal in menu!.Meals {
        if (meal?.Name != nil) {
            if(meal!.Name == "Dinner") {
                return meal!
            }
        }
    }
    
    return nil
}

func getLunch(menu: Menu?) -> Meal? {
    for meal in menu!.Meals {
        if (meal?.Name != nil) {
            if(meal!.Name == "Lunch") {
                return meal!
            }
        }
    }
    
    return nil
}

func getDiningHours(menu: Menu?) -> [Hour?] {
    var hours: [Hour?] = []
    if menu != nil {
        for meal in menu!.Meals {
            hours.append(meal?.Hours)
        }
    }
    
    return(hours)
}

func getBLDHours(menu: Menu?) -> [Hour?] {
    var hours: [Hour?] = []
    if menu != nil {
        for meal in menu!.Meals {
            if (meal?.Name != nil) {
                if(!(meal!.Name == "Late Lunch")) {
                    hours.append(meal?.Hours)
                }
            }
        }
    }
    
    return(hours)
}

func getLLHours(menu: Menu?) -> [Hour?] {
    var hours: [Hour?] = []
    if menu != nil {
        for meal in menu!.Meals {
            if (meal?.Name != nil) {
                if(meal!.Name == "Late Lunch") {
                    hours.append(meal?.Hours)
                }
            }
        }
    }
    
    return(hours)
}

func getItem(itemID: String) -> Item {
    let address = "https://api.hfs.purdue.edu/menus/v2/items/" + itemID
    let requestLocation = URL(string: address)
    
    var itemDetails: Item?
    
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: requestLocation!) { (data, response, error) in
    do {
        itemDetails = try JSONDecoder().decode(Item.self,from: data!)
//        let prettyPrintedString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//        print(prettyPrintedString)
        semaphore.signal()
    } catch {
        print("There was an error in the item api request")
        print(error)
    }
    }
    
    task.resume()
    semaphore.wait()
    
    return(itemDetails!)
}

func getItemCalories(itemID: String) -> Int {
    let address = "https://api.hfs.purdue.edu/menus/v2/items/" + itemID
    let requestLocation = URL(string: address)
    
    var itemDetails: Item?
    var calories: Float = 0
    
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: requestLocation!) { (data, response, error) in
    do {
        itemDetails = try JSONDecoder().decode(Item.self,from: data!)
        let nutrition = itemDetails?.Nutrition
        if (nutrition != nil) {
            calories = Float(((itemDetails?.Nutrition![1].LabelValue)!))!
        }
        else {
            calories = -1
        }
        semaphore.signal()
    } catch {
        print("There was an error in the item api request")
        print(error)
    }
    }
    
    task.resume()
    semaphore.wait()
    
    return(Int(calories))
}

func getItemNutrition(itemID: String) -> [NutritionFact] {
    let address = "https://api.hfs.purdue.edu/menus/v2/items/" + itemID
    let requestLocation = URL(string: address)
    
    var itemDetails: Item?
    var nutritionFinal: [NutritionFact] = []
    
    let semaphore = DispatchSemaphore(value: 0)
    
    let task = URLSession.shared.dataTask(with: requestLocation!) { (data, response, error) in
    do {
        itemDetails = try JSONDecoder().decode(Item.self,from: data!)
        let nutrition = itemDetails?.Nutrition
        if (nutrition != nil) {
            nutritionFinal = itemDetails!.Nutrition!
        }
        else {
//            nutritionFinal = []
        }
        semaphore.signal()
    } catch {
        print("There was an error in the item api request")
        print(error)
    }
    }
    
    task.resume()
    semaphore.wait()
    
    return(nutritionFinal)
}

// URL for example meal request
// https://api.hfs.purdue.edu/menus/v2/locations/ford/2019-02-04

// URL for example item api request
// https://api.hfs.purdue.edu/menus/v2/items/6c883ba0-e283-4086-ab01-e181a6615435

// itemID = menu.Meals[0].Stations[0].Items[0].ID
