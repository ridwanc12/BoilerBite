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
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testDiningHours() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMeal(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        
        let diningHours = getDiningHours(menu: testMenu)
        let stringHours = String(describing: diningHours)
        
        XCTAssertEqual(stringHours, "[nil, Optional(Hour(StartTime: 10:00:00, EndTime: 14:00:00)), Optional(Hour(StartTime: 14:00:00, EndTime: 17:00:00)), Optional(Hour(StartTime: 17:00:00, EndTime: 21:00:00))]")
        
    }
    
    func testBLDHours() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMeal(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        
        let BLDHours = getBLDHours(menu: testMenu)
        let stringHours = String(describing: BLDHours)
        
        XCTAssertEqual(stringHours, "[nil, Optional(Hour(StartTime: 10:00:00, EndTime: 14:00:00)), Optional(Hour(StartTime: 17:00:00, EndTime: 21:00:00))]")
    }
    
    func testLLHours() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMeal(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        
        let LLHours = getLLHours(menu: testMenu)
        let stringHours = String(describing: LLHours)
        
        XCTAssertEqual(stringHours, "[Optional(Hour(StartTime: 14:00:00, EndTime: 17:00:00))]")
    }
    
    func testMenuWindsorDay1() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMeal(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        
        let stringHall = String(describing: testMenu!.Location!)
        let stringCompareHall = "Windsor"
        XCTAssertEqual(stringHall, stringCompareHall)
        
        let stringDate = String(describing: testMenu!.Date!)
        let stringCompareDate = "1/13/2020"
        XCTAssertEqual(stringDate, stringCompareDate)
    }
    
    func testMenuWindsorDinnerDay1() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMeal(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        
        let dinner = getDinner(menu: testMenu)
        
        let stringDinner = String(describing: dinner!.Name)
        let stringCompareDinner = "Dinner"
        
        XCTAssertEqual(stringDinner, stringCompareDinner)
    }
    
    func testMenuWindsorLunchDay1() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMeal(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        
        let dinner = getLunch(menu: testMenu)
        
        let stringDinner = String(describing: dinner!.Name)
        let stringCompareDinner = "Lunch"
        
        XCTAssertEqual(stringDinner, stringCompareDinner)
    }

    func testWindsorMenuFirstItem() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMeal(hall: "windsor", date: "2020-01-13")
        
        XCTAssertNotNil(testMenu)
        
        // NOTE: Windsor doesn't have breakfast
        let itemID = testMenu?.Meals[1]?.Stations[0]?.Items[0].ID
        let stringID = String(itemID ?? "No item ID")
        let firstItemID = "84835539-119a-4efd-b714-786015923e3c"
        
        XCTAssertEqual(stringID, firstItemID)
        
        
    }
}
