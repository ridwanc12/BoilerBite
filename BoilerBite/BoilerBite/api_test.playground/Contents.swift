import UIKit
import Foundation

// Structs needed for meal plan api request

struct Menu:Decodable {
    var Location:String
    var Date:String
    var Meals:[Meal]
}

struct Meal:Decodable {
    var ID:String
    var Name:String
    var Status:String
    var Hours:Hour
    var Stations:[Station]
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
    var NutritionFacts: [String]?
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

// URL for example meal request
// https://api.hfs.purdue.edu/menus/v2/locations/ford/2019-02-04

var address = "https://api.hfs.purdue.edu/menus/v2/locations/ford/2019-02-04"
var requestLocation = URL(string: address)

URLSession.shared.dataTask(with: requestLocation!) { (data, response, error) in
    do {
        let json = try JSONSerialization.jsonObject(with: data!, options:[])
        print(json)
    } catch {
        print("There was an error in the api request")
        print(error)
    }
}.resume()

// URL for example item api request
// https://api.hfs.purdue.edu/menus/v2/items/6c883ba0-e283-4086-ab01-e181a6615435

var address2 = "https://api.hfs.purdue.edu/menus/v2/items/6c883ba0-e283-4086-ab01-e181a6615435"
var requestLocation2 = URL(string: address2)

URLSession.shared.dataTask(with: requestLocation2!) { (data, response, error) in
    do {
        let json = try JSONSerialization.jsonObject(with: data!, options:[])
        print(json)
    } catch {
        print("There was an error in the api request")
        print(error)
    }
    }.resume()
