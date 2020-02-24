//
//  ApiRequest.swift
//  BoilerBite
//
//  Created by Ridwan Chowdhury on 2/22/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//
import UIKit
import Foundation

func getMeal(hall: String, date: String) -> Menu? {
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

// URL for example meal request
// https://api.hfs.purdue.edu/menus/v2/locations/ford/2019-02-04

// URL for example item api request
// https://api.hfs.purdue.edu/menus/v2/items/6c883ba0-e283-4086-ab01-e181a6615435

// itemID = menu.Meals[0].Stations[0].Items[0].ID
