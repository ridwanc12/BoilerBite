//
//  BoilerBiteUITests.swift
//  BoilerBiteUITests
//
<<<<<<< HEAD
//  Created by Uday Chaudhary on 16/02/20.
//  Copyright © 2020 Uday Chaudhary. All rights reserved.
=======
//  Created by Isha Mahadalkar on 2/15/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
>>>>>>> 80c929a2808dbb95f8eb7ad1f9d39dc750b7ee6f
//

import XCTest

class BoilerBiteUITests: XCTestCase {

<<<<<<< HEAD
    override func setUpWithError() throws {
=======
    override func setUp() {
>>>>>>> 80c929a2808dbb95f8eb7ad1f9d39dc750b7ee6f
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

<<<<<<< HEAD
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
=======
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
>>>>>>> 80c929a2808dbb95f8eb7ad1f9d39dc750b7ee6f
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

<<<<<<< HEAD
    func testLaunchPerformance() throws {
=======
    func testLaunchPerformance() {
>>>>>>> 80c929a2808dbb95f8eb7ad1f9d39dc750b7ee6f
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
