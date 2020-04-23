//
//  ServerTests.swift
//  ServerTests
//
//  Created by csuser on 4/22/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import XCTest

class ServerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let name = "jeremy"
        let pass = "jeremy"
        let link = "https://boilerbite.000webhostapp.com/php/deleteUser.php"
        let request = NSMutableURLRequest(url: NSURL(string: link)! as URL)
        request.httpMethod = "POST"
        // Send values to php script
        let postString = "userName=\(name)&pass=\(pass)"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        var s = "ERROR"
        let semaphore = DispatchSemaphore(value: 0)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in

            if error != nil {
                //print(error)
                return
            }

            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as String?
            let response = String(describing: responseString!)
            print(response)
            if (response.contains("User not in database.")) {
                s = "No such user"
            } else if (response.contains("password")){
                s = "Incorrect password"
            } else {
                s = "User deleted"
            }
            semaphore.signal()
            //print("responseString = ")
        }
        task.resume()
        semaphore.wait()

        print(s)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
