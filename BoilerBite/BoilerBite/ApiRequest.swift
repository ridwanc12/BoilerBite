//
//  ApiRequest.swift
//  BoilerBite
//
//  Created by Ridwan Chowdhury on 2/22/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//


import UIKit
import Foundation

// Structs needed for meal plan api request

struct Menu:Decodable {
    var Location:String?
    var Date:String?
    var Meals:[Meal?]
}

struct Meal:Decodable {
    var ID:String
    var Name:String
    var Status:String
    var Hours:Hour?
    var Stations:[Station?]
}

struct Hour:Decodable {
    var StartTime:String
    var EndTime:String
}

struct Station:Decodable {
    var Name:String
    var Items:[Item]
}

// Item has optionals for when more variables are needed in a later api request

struct Item:Decodable {
    var ID:String
    var Name:String
    var IsVegetarian:Bool
    var Allergens:[Allergen]?
    var NutritionFacts: [NutritionFact]?
    var Ingredients:String?
}

struct Allergen:Decodable {
    var Name:String
    var Value:Bool
}

// Additional structs needed for item api request

struct NutritionFact:Decodable {
    var Name:String
    var Value:Int
    var LabelValue:String
    var DailyValue:String?
    var Ordinal:Int
}

// Some extension code to make the data print nicer

extension Meal: CustomStringConvertible {
    var description: String {
        let returnValue = String(format: "Meal(ID: %@, Name: %@, Status: %@, Hours: %@, Stations: %@)", ID, Name, Status, [Hours], Stations)
        return returnValue
    }
}

extension Hour: CustomStringConvertible {
    var description: String {
        let returnValue = String(format: "Hour(StartTime: %@, EndTime: %@)", StartTime, EndTime)
        return returnValue
    }
}

extension Station: CustomStringConvertible {
    var description: String {
        let returnValue = String(format: "Station(Name: %@, Items: %@)", Name, Items)
        return returnValue
    }
}

extension Item: CustomStringConvertible {
    var description: String {
        let returnValue = String(format: "Item(ID: %@, Name: %@, IsVegetarian: %@, Allergens: %@, NutritionFacts: %@, Ingredients: %@)", ID, Name, String(IsVegetarian), Allergens ?? "", NutritionFacts ?? "", Ingredients ?? "")
        return returnValue
    }
}

extension Allergen: CustomStringConvertible {
    var description: String {
        let returnValue = String(format: "Allergen(Name: %@, Value: %@)", Name, String(Value))
        return returnValue
    }
}


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

func getItem(itemID: String) -> Item {
    let address = "https://api.hfs.purdue.edu/menus/v2/items/" + itemID
    let requestLocation = URL(string: address)
    
    var itemDetails: Item?
    URLSession.shared.dataTask(with: requestLocation!) { (data, response, error) in
    do {
        itemDetails = try JSONDecoder().decode(Item.self,from: data!)
    } catch {
        print("There was an error in the item api request")
        print(error)
    }
    }.resume()
    
    return(itemDetails!)
}

// URL for example meal request
// https://api.hfs.purdue.edu/menus/v2/locations/ford/2019-02-04

// URL for example item api request
// https://api.hfs.purdue.edu/menus/v2/items/6c883ba0-e283-4086-ab01-e181a6615435

// itemID = menu.Meals[0].Stations[0].Items[0].ID
