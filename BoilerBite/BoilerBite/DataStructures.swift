//
//  DataStructures.swift
//  BoilerBite
//
//  Created by Ridwan Chowdhury on 2/23/20.
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
    var Nutrition: [NutritionFact]?
    var Ingredients:String?
}

struct Allergen:Decodable {
    var Name:String
    var Value:Bool
}

struct NutritionFact:Decodable {
    var Name:String
    var Value:Float?
    var LabelValue:String?
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
        let returnValue = String(format: "Item(ID: %@, Name: %@, IsVegetarian: %@, Allergens: %@, NutritionFacts: %@, Ingredients: %@)", ID, Name, String(IsVegetarian), Allergens ?? "", Nutrition ?? "", Ingredients ?? "")
        return returnValue
    }
}

extension Allergen: CustomStringConvertible {
    var description: String {
        let returnValue = String(format: "Allergen(Name: %@, Value: %@)", Name, String(Value))
        return returnValue
    }
}

extension NutritionFact: CustomStringConvertible {
    var description: String {
        let returnValue = String(format: "NutritionFact(Name: %@, Value: %@, LabelValue: %@, DailyValue: %@, Ordinal: %@)", Name, String(Value ?? -1), LabelValue ?? "", DailyValue ?? "", String(Ordinal))
        return returnValue
    }
}

// Data structure for database

struct User: Decodable {
    var ID:Int
    var username:String
    var userEmail:String
    var password:String
}

struct UserInfo: Decodable {
    var ID:Int
    var height:Int
    var weight:Int
    var age:Int
}