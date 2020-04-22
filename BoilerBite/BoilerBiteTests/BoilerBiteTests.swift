//
//  BoilerBiteTests.swift
//  BoilerBiteTests
//
//  Created by Isha Mahadalkar on 2/15/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import XCTest
@testable import BoilerBite

class BoilerBiteTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let meals = getFirstDayMeals(hall: "earhart")
        print(meals)
        let hours = getFirstDayHours(hall: "earhart")
        print(hours)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
    }
    
    func testBLDHours() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        
        let BLDHours = getBLDHours(menu: testMenu)
        let stringHours = String(describing: BLDHours)
        
        print(BLDHours)
        
        XCTAssertEqual(stringHours, "[nil, Optional(Hour(StartTime: 10:00:00, EndTime: 14:00:00)), Optional(Hour(StartTime: 17:00:00, EndTime: 21:00:00))]")
    }
    
    func testLLHours() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        
        let LLHours = getLLHours(menu: testMenu)
        let stringHours = String(describing: LLHours)
        
        print(LLHours)
        
        XCTAssertEqual(stringHours, "[Optional(Hour(StartTime: 14:00:00, EndTime: 17:00:00))]")
    }
    
    func testMenuWindsorDay1() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        
        print(testMenu ?? "No menu")
        
        let stringHall = String(describing: testMenu!.Location!)
        let stringCompareHall = "Windsor"
        XCTAssertEqual(stringHall, stringCompareHall)
        
        let stringDate = String(describing: testMenu!.Date!)
        let stringCompareDate = "1/13/2020"
        XCTAssertEqual(stringDate, stringCompareDate)
    }
    
    func testMenuWindsorDinnerDay1() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        
        let dinner = getDinner(menu: testMenu)
        
        print(dinner ?? "No dinner")
        
        let stringHall = String(describing: testMenu!.Location!)
        let stringCompareHall = "Windsor"
        XCTAssertEqual(stringHall, stringCompareHall)
        
        let stringDinner = String(describing: dinner!.Name)
        let stringCompareDinner = "Dinner"
        
        XCTAssertEqual(stringDinner, stringCompareDinner)
    }
    
    func testMenuWindsorLunchDay1() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        
        let lunch = getLunch(menu: testMenu)
        
        print(lunch ?? "No lunch")
        
        let stringHall = String(describing: testMenu!.Location!)
        let stringCompareHall = "Windsor"
        XCTAssertEqual(stringHall, stringCompareHall)
        
        let stringDinner = String(describing: lunch!.Name)
        let stringCompareDinner = "Lunch"
        
        XCTAssertEqual(stringDinner, stringCompareDinner)
    }

    func testWindsorMenuFirstItem() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        
        print(testMenu ?? "No menu")
        
        // NOTE: Windsor doesn't have breakfast on weekdays
        let itemID = testMenu?.Meals[1]?.Stations[0]?.Items[0].ID
        let stringID = String(itemID ?? "No item ID")
        let firstItemID = "84835539-119a-4efd-b714-786015923e3c"
        
        XCTAssertEqual(stringID, firstItemID)
        
        let itemName = testMenu?.Meals[1]?.Stations[0]?.Items[0].Name
        let stringName = String(describing: itemName)
        let knownName = "Optional(\"Greek Saganaki Gluten Free\")"
        XCTAssertEqual(stringName, knownName)
        
        let firstItem = getItem(itemID: stringID)
        let firstItemContents = String(describing: firstItem)
        print(firstItem)
        let firstItemCompare = """
Item(ID: 84835539-119a-4efd-b714-786015923e3c, Name: Greek Saganaki Gluten Free, IsVegetarian: true, Allergens: (
    "Allergen(Name: Eggs, Value: true)",
    "Allergen(Name: Fish, Value: false)",
    "Allergen(Name: Gluten, Value: false)",
    "Allergen(Name: Milk, Value: true)",
    "Allergen(Name: Peanuts, Value: false)",
    "Allergen(Name: Shellfish, Value: false)",
    "Allergen(Name: Soy, Value: false)",
    "Allergen(Name: Tree Nuts, Value: false)",
    "Allergen(Name: Vegetarian, Value: true)",
    "Allergen(Name: Vegan, Value: false)",
    "Allergen(Name: Wheat, Value: false)"
), NutritionFacts: (
    "NutritionFact(Name: Serving Size, Value: -1.0, LabelValue: Serving, DailyValue: , Ordinal: 0)",
    "NutritionFact(Name: Calories, Value: 350.689, LabelValue: 351, DailyValue: , Ordinal: 1)",
    "NutritionFact(Name: Calories from fat, Value: -1.0, LabelValue: 216, DailyValue: , Ordinal: 2)",
    "NutritionFact(Name: Total fat, Value: 23.8546, LabelValue: 24g, DailyValue: 37%, Ordinal: 3)",
    "NutritionFact(Name: Saturated fat, Value: 12.7221, LabelValue: 13g, DailyValue: 64%, Ordinal: 4)",
    "NutritionFact(Name: Cholesterol, Value: 131.9648, LabelValue: 130mg, DailyValue: 44%, Ordinal: 5)",
    "NutritionFact(Name: Sodium, Value: 717.7431, LabelValue: 720mg, DailyValue: 30%, Ordinal: 6)",
    "NutritionFact(Name: Total Carbohydrate, Value: 22.1732, LabelValue: 22g, DailyValue: 7%, Ordinal: 7)",
    "NutritionFact(Name: Sugar, Value: 4.387, LabelValue: 4g, DailyValue: , Ordinal: 8)",
    "NutritionFact(Name: Dietary Fiber, Value: 0.7912, LabelValue: less than 1 g, DailyValue: , Ordinal: 9)",
    "NutritionFact(Name: Protein, Value: 13.347, LabelValue: 13g, DailyValue: 13%, Ordinal: 10)",
    "NutritionFact(Name: Vitamin A, Value: 736.9079, LabelValue: , DailyValue: 25%, Ordinal: 11)",
    "NutritionFact(Name: Vitamin C, Value: 10.564, LabelValue: , DailyValue: 20%, Ordinal: 12)",
    "NutritionFact(Name: Calcium, Value: 391.4596, LabelValue: , DailyValue: 40%, Ordinal: 13)",
    "NutritionFact(Name: Iron, Value: 1.251, LabelValue: , DailyValue: 6%, Ordinal: 14)"
), Ingredients: Cheese Feta Domestic(Feta Cheese (Pastruized Milk, Cheese Cultures, Salt, Enzymes), Powdered Cellulose To Prevent Caking, Natamycin To Protect Flavor), Tomato 5 x 5 Loose Bulk 25#(Tomato), Lemon 165 Ct.(Lemons Fresh), Flour Tapioca 25#(Tapioca), Egg Whole Frozen, Oil Olive Extra Virgin (4 x 3 Lt )(Canola Oil, Extra Virgin Olive Oil), Spice Pepper Black Ground 18 oz(Black Pepper), Spice Oregano Leaf 5 oz(Oregano))
"""
        
        XCTAssertEqual(firstItemContents, firstItemCompare)
    }
    
    func testWindsorMenuWeekendFirstItem() {
        // Menu for Windsor 01-18-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-18")
        
        XCTAssertNotNil(testMenu)
        print(testMenu ?? "No menu")
        
        // NOTE: Windsor doesn't have breakfast, lunch, or late lunch on weekends
        let itemID = testMenu?.Meals[3]?.Stations[0]?.Items[0].ID
        print(itemID!)
        
        let stringID = String(itemID ?? "No item ID")
        let compareID = "da968774-9381-4a03-ae26-87b765fb80f6"
        
        let firstItem = getItem(itemID: stringID)
        print(firstItem)
        
        XCTAssertEqual(stringID, compareID)
    }
    
    func testCalorieParser() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        print(testMenu ?? "No menu")
        
        // NOTE: Windsor doesn't have breakfast on weekdays
        let itemID = testMenu?.Meals[1]?.Stations[0]?.Items[0].ID
        
        let stringID = String(itemID ?? "No item ID")
        
        let firstItem = getItem(itemID: stringID)
        
        let itemCal = firstItem.Nutrition![1].Value
        print(itemCal!)
        
        XCTAssertEqual(itemCal, 350.689)
        
    }
    
    func testWindsorMenuFirstItemIngredients() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        print(testMenu ?? "No menu")
        
        // NOTE: Windsor doesn't have breakfast on weekdays
        let itemID = testMenu?.Meals[1]?.Stations[0]?.Items[0].ID
        print(itemID!)
        
        let stringID = String(itemID ?? "No item ID")
        let compareID = "84835539-119a-4efd-b714-786015923e3c"
        let firstItem = getItem(itemID: stringID)
        print(firstItem)
        
        XCTAssertEqual(stringID, compareID)
        
        let itemName = testMenu?.Meals[1]?.Stations[0]?.Items[0].Name
        let stringName = String(itemName ?? "No item name")
        let compareName = "Greek Saganaki Gluten Free"
        print(itemName ?? "No item")
        
        XCTAssertEqual(stringName, compareName)
        
        let ingredients = firstItem.Ingredients!
        print(ingredients)
        
        XCTAssertEqual(String(describing: type(of: ingredients)), "String")
    }
    
    func testWindsorMenuWeekendFirstItemIngredients() {
        // Menu for Windsor 01-18-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-18")
        
        XCTAssertNotNil(testMenu)
        print(testMenu ?? "No menu")
        
        // NOTE: Windsor doesn't have breakfast, lunch, or late lunch on weekends
        let itemID = testMenu?.Meals[3]?.Stations[0]?.Items[0].ID
        print(itemID!)
        
        let stringID = String(itemID ?? "No item ID")
        let compareID = "da968774-9381-4a03-ae26-87b765fb80f6"
        let firstItem = getItem(itemID: stringID)
        print(firstItem)
        
        XCTAssertEqual(stringID, compareID)
        
        let itemName = testMenu?.Meals[3]?.Stations[0]?.Items[0].Name
        let stringName = String(itemName ?? "No item name")
        let compareName = "Jumbo Cheese Ravioli"
        print(itemName ?? "No item")
        
        XCTAssertEqual(stringName, compareName)
        
        let ingredients = firstItem.Ingredients!
        print(ingredients)
        
        XCTAssertEqual(String(describing: type(of: ingredients)), "String")
    }
    
    func testWindsorMenuFirstItemAllergens() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        print(testMenu ?? "No menu")
        
        // NOTE: Windsor doesn't have breakfast on weekdays
        let itemID = testMenu?.Meals[1]?.Stations[0]?.Items[0].ID
        print(itemID!)
        
        let stringID = String(itemID ?? "No item ID")
        let compareID = "84835539-119a-4efd-b714-786015923e3c"
        let firstItem = getItem(itemID: stringID)
        print(firstItem)
        
        XCTAssertEqual(stringID, compareID)
        
        let itemName = testMenu?.Meals[1]?.Stations[0]?.Items[0].Name
        let stringName = String(itemName ?? "No item name")
        let compareName = "Greek Saganaki Gluten Free"
        print(itemName ?? "No item")
        
        XCTAssertEqual(stringName, compareName)
        
        let allergens = firstItem.Allergens!
        print(allergens)
        
        XCTAssertEqual(String(describing: type(of: allergens)), "Array<Allergen>")
    }
    
    func testWindsorMenuWeekendFirstItemAllergens() {
        // Menu for Windsor 01-18-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-18")
        
        XCTAssertNotNil(testMenu)
        print(testMenu ?? "No menu")
        
        // NOTE: Windsor doesn't have breakfast, lunch, or late lunch on weekends
        let itemID = testMenu?.Meals[3]?.Stations[0]?.Items[0].ID
        print(itemID!)
        
        let stringID = String(itemID ?? "No item ID")
        let compareID = "da968774-9381-4a03-ae26-87b765fb80f6"
        let firstItem = getItem(itemID: stringID)
        print(firstItem)
        
        XCTAssertEqual(stringID, compareID)
        
        let itemName = testMenu?.Meals[3]?.Stations[0]?.Items[0].Name
        let stringName = String(itemName ?? "No item name")
        let compareName = "Jumbo Cheese Ravioli"
        print(itemName ?? "No item")
        
        XCTAssertEqual(stringName, compareName)
        
        let allergens = firstItem.Allergens!
        print(allergens)
        
        XCTAssertEqual(String(describing: type(of: allergens)), "Array<Allergen>")
    }
    
    func testWindsorMenuFirstItemNutrition() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        print(testMenu ?? "No menu")
        
        // NOTE: Windsor doesn't have breakfast on weekdays
        let itemID = testMenu?.Meals[1]?.Stations[0]?.Items[0].ID
        print(itemID!)
        
        let stringID = String(itemID ?? "No item ID")
        let compareID = "84835539-119a-4efd-b714-786015923e3c"
        let firstItem = getItem(itemID: stringID)
        print(firstItem)
        
        XCTAssertEqual(stringID, compareID)
        
        let itemName = testMenu?.Meals[1]?.Stations[0]?.Items[0].Name
        let stringName = String(itemName ?? "No item name")
        let compareName = "Greek Saganaki Gluten Free"
        print(itemName ?? "No item")
        
        XCTAssertEqual(stringName, compareName)
        
        let nutrition = getItemNutrition(itemID: stringID)
        print(nutrition)
        let nutritionString = "[NutritionFact(Name: Serving Size, Value: -1.0, LabelValue: Serving, DailyValue: , Ordinal: 0), NutritionFact(Name: Calories, Value: 350.689, LabelValue: 351, DailyValue: , Ordinal: 1), NutritionFact(Name: Calories from fat, Value: -1.0, LabelValue: 216, DailyValue: , Ordinal: 2), NutritionFact(Name: Total fat, Value: 23.8546, LabelValue: 24g, DailyValue: 37%, Ordinal: 3), NutritionFact(Name: Saturated fat, Value: 12.7221, LabelValue: 13g, DailyValue: 64%, Ordinal: 4), NutritionFact(Name: Cholesterol, Value: 131.9648, LabelValue: 130mg, DailyValue: 44%, Ordinal: 5), NutritionFact(Name: Sodium, Value: 717.7431, LabelValue: 720mg, DailyValue: 30%, Ordinal: 6), NutritionFact(Name: Total Carbohydrate, Value: 22.1732, LabelValue: 22g, DailyValue: 7%, Ordinal: 7), NutritionFact(Name: Sugar, Value: 4.387, LabelValue: 4g, DailyValue: , Ordinal: 8), NutritionFact(Name: Dietary Fiber, Value: 0.7912, LabelValue: less than 1 g, DailyValue: , Ordinal: 9), NutritionFact(Name: Protein, Value: 13.347, LabelValue: 13g, DailyValue: 13%, Ordinal: 10), NutritionFact(Name: Vitamin A, Value: 736.9079, LabelValue: , DailyValue: 25%, Ordinal: 11), NutritionFact(Name: Vitamin C, Value: 10.564, LabelValue: , DailyValue: 20%, Ordinal: 12), NutritionFact(Name: Calcium, Value: 391.4596, LabelValue: , DailyValue: 40%, Ordinal: 13), NutritionFact(Name: Iron, Value: 1.251, LabelValue: , DailyValue: 6%, Ordinal: 14)]"
        
        XCTAssertEqual(String(describing: nutrition), nutritionString)
        
        XCTAssertEqual(String(describing: type(of: nutrition)), "Array<NutritionFact>")
    }
    
    func testWindsorMenuWeekendFirstItemNutrition() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-18")
        
        XCTAssertNotNil(testMenu)
        print(testMenu ?? "No menu")
        
        // NOTE: Windsor doesn't have breakfast on weekdays
        let itemID = testMenu?.Meals[3]?.Stations[0]?.Items[0].ID
        print(itemID!)
        
        let stringID = String(itemID ?? "No item ID")
        let compareID = "da968774-9381-4a03-ae26-87b765fb80f6"
        let firstItem = getItem(itemID: stringID)
        print(firstItem)
        
        XCTAssertEqual(stringID, compareID)
        
        let itemName = testMenu?.Meals[3]?.Stations[0]?.Items[0].Name
        let stringName = String(itemName ?? "No item name")
        let compareName = "Jumbo Cheese Ravioli"
        print(itemName ?? "No item")
        
        XCTAssertEqual(stringName, compareName)
        
        let nutrition = getItemNutrition(itemID: stringID)
        print(nutrition)
        let nutritionString = "[NutritionFact(Name: Serving Size, Value: -1.0, LabelValue: 5 per Serving, DailyValue: , Ordinal: 0), NutritionFact(Name: Calories, Value: 270.5204, LabelValue: 271, DailyValue: , Ordinal: 1), NutritionFact(Name: Calories from fat, Value: -1.0, LabelValue: 153, DailyValue: , Ordinal: 2), NutritionFact(Name: Total fat, Value: 16.9868, LabelValue: 17g, DailyValue: 26%, Ordinal: 3), NutritionFact(Name: Saturated fat, Value: 2.3163, LabelValue: 2.5g, DailyValue: 12%, Ordinal: 4), NutritionFact(Name: Cholesterol, Value: 24.9915, LabelValue: 25mg, DailyValue: 8%, Ordinal: 5), NutritionFact(Name: Sodium, Value: 99.964, LabelValue: 100mg, DailyValue: 4%, Ordinal: 6), NutritionFact(Name: Total Carbohydrate, Value: 22.4924, LabelValue: 22g, DailyValue: 7%, Ordinal: 7), NutritionFact(Name: Sugar, Value: 0.0, LabelValue: 0g, DailyValue: , Ordinal: 8), NutritionFact(Name: Dietary Fiber, Value: 0.8327, LabelValue: less than 1 g, DailyValue: , Ordinal: 9), NutritionFact(Name: Protein, Value: 7.4975, LabelValue: 7g, DailyValue: 7%, Ordinal: 10), NutritionFact(Name: Vitamin A, Value: 166.6074, LabelValue: , DailyValue: 6%, Ordinal: 11), NutritionFact(Name: Vitamin C, Value: 0.0, LabelValue: , DailyValue: 0%, Ordinal: 12), NutritionFact(Name: Calcium, Value: 58.3122, LabelValue: , DailyValue: 6%, Ordinal: 13), NutritionFact(Name: Iron, Value: 1.0493, LabelValue: , DailyValue: 6%, Ordinal: 14)]"
        
        XCTAssertEqual(String(describing: nutrition), nutritionString)
        
        XCTAssertEqual(String(describing: type(of: nutrition)), "Array<NutritionFact>")
    }
    
    func testDiningHoursWeekday() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        
        let diningHours = getDiningHours(menu: testMenu)
        let stringHours = String(describing: diningHours)
        
        print(diningHours)
        
        XCTAssertEqual(stringHours, "[nil, Optional(Hour(StartTime: 10:00:00, EndTime: 14:00:00)), Optional(Hour(StartTime: 14:00:00, EndTime: 17:00:00)), Optional(Hour(StartTime: 17:00:00, EndTime: 21:00:00))]")
    }
    
    func testDiningHoursWeekend() {
        // Menu for Windsor 01-18-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-18")
        
        XCTAssertNotNil(testMenu)
        
        let diningHours = getDiningHours(menu: testMenu)
        let stringHours = String(describing: diningHours)
        
        print(diningHours)
        
        XCTAssertEqual(stringHours, "[nil, nil, nil, Optional(Hour(StartTime: 16:00:00, EndTime: 20:00:00))]")
        
    }
    
    func testMealsWeekday() {
        // Meals for Windsor 01-13-2020
        let meals = getMeals(hall: "windsor", date: "2020-01-13")
        print(meals)
        let expected = """
["Lunch", "Late Lunch", "Dinner"]
"""
        XCTAssertEqual(String(describing: meals), expected)
    }
    
    func testMealsWeekend() {
        // Meals for Windsor 01-18-2020
        let meals = getMeals(hall: "windsor", date: "2020-01-18")
        print(meals)
        let expected = """
["Dinner"]
"""
        
        XCTAssertEqual(String(describing: meals), expected)
    }
}
