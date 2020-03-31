//
//  MainViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 2/22/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        insertUser(name: "Ian", mail: "Ian", pass: "ian")
//        insertFood(name: "Ian", food: "Protein", cal_total: 1324)
        
        // Getting the username and password entered
        usernameField.delegate = self
        passwordField.delegate = self
        
        // Testing dining hours functions in main
//        diningHoursExample()
        
        // Testing meal and item requests functions in main
//        mealRequest()
        
//        databaseRequest()
//        databaseRequest2()
        //let username: String = usernameField.text ?? ""
        //let password: String = passwordField.text ?? ""
        
        //print(username)
        //print(password)
        
        //databaseRequest4(user: username, password: password) // prev was "" ""
    }
    
    func diningHoursExample() {
        // Menu for Windsor 01-13-2020
        let testMenu = getMenu(hall: "windsor", date: "2020-01-13")

        print("All Hours")
        let diningHours = getDiningHours(menu: testMenu)
        print(diningHours)
        
        print("BLD Hours")
        let BLDHours = getBLDHours(menu: testMenu)
        print(BLDHours)
        
        print("Late Lunch Hours")
        let LLHours = getLLHours(menu: testMenu)
        print(LLHours)
        
        let testMenu2 = getMenu(hall: "windsor", date: "2020-01-18")
        
        print("Weekend Meal Hours")
        let weekendHours = getDiningHours(menu: testMenu2)
        print(weekendHours)
    }
    
    func mealRequest() {
        let testMenu = getMenu(hall: "windsor", date: "2020-01-13")
        let hall = testMenu?.Location
        let date = testMenu?.Date
        print(hall ?? "No hall")
        print(date ?? "No date")
        
        let dinner = getDinner(menu: testMenu)
        print(dinner ?? "No dinner")
        
        let lunch = getLunch(menu: testMenu)
        print(lunch ?? "No lunch")
        
        // NOTE: Windsor doesn't have breakfast
        let itemID = testMenu?.Meals[1]?.Stations[0]?.Items[0].ID
        let stringID = String(itemID ?? "No item ID")
        print(stringID)
        
        let firstItem = getItem(itemID: stringID)
        print(firstItem)
    }
    
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        // Validating the Inputs from the User
        let username: String = usernameField.text ?? ""
        let password: String = passwordField.text ?? ""
        
        var flag = 0
        
        if username.count < 6 || username.count > 12 {
            flag = 1;
            let alert = UIAlertController(title: "Error" , message: "Length should be between 6 and 12", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Username or Password Empty")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        if username == "" || password == "" {
            flag = 1;
            let alert = UIAlertController(title: "Error" , message: "Enter Username and Password", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Username or Password Empty")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        var arg = 0;
        if flag == 0 {
            arg = databaseRequest4(user: username, password: password) // added by uc
            global_username = username
            global_password = password
        }
        
        if arg == 0 {
            flag = 1;
            let alert = UIAlertController(title: "Error" , message: "Wrong password or username", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Wrong password or username")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        
        /*
        if username.count < 6 || password.count < 6 {
            let alert = UIAlertController(title: "Username or Password Incorrect" , message: "Username/Password too short!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Username or Password too Short")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        if username.count > 12 || password.count > 12{
            let alert = UIAlertController(title: "Username or Password Incorrect" , message: "Username/Password too long!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("Username or Password too Long")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
 
        */
        
        
        
    }
    
    
    
    @IBAction func unwindToMainViewController(unwindSegue: UIStoryboardSegue) {
        // Do not need to do anything
    }
    
    let URL_SAVE_TEAM = URL(string: "http://10.192.122.81/MyWebService/api/createteam.php")
       
       //TextFields declarations
       @IBOutlet weak var textFieldName: UITextField!
       @IBOutlet weak var textFieldMember: UITextField!
    
       // the content inside UC
       //Button action method
       @IBAction func buttonSave(sender: UIButton) {
        
        
        
       }
    // added by UC
    
    // added by UC
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func databaseRequest4(user: String, password: String) -> Int {
        let semaphore = DispatchSemaphore (value: 0)
        
        var arg = 0;
        //let username: String = usernameField.text ?? ""
        //let password: String = passwordField.text ?? ""
        
        // user changed to username
        
        //let urlString = String(format: "http://10.192.122.81/MyWebService/api/createteam.php?name=%@&member=%@", user, password)  // might have to change the use
        
        let urlString = String(format: "https://boilerbite.000webhostapp.com/php/createteam.php?userName=%@&hashPass=%@", user, password);
        var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          /*do {
              if let json = try JSONSerialization.jsonObject(with: data) as? [String: String], let name = json["name"] {
                  //print("name = \(name)")   // if everything is good, you'll see "William"
              }
          } catch let parseError {
              print("parsing error: \(parseError)")
              //let responseString = String(data: data, encoding: .utf8)
              //print("raw response: \(responseString)")
          }*/
            
            /*do{
                if let jsonData=try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                    print(jsonData)
                    let success=jsonData.value(forKey: "success") as! Bool
                    if success{
                        print("login succeded")
                        //request_completed(true)
                        return
                     }else{
                        print("login failed")
                        //request_completed(false)
                        return
                    }
                }else{
                    print("could not parse json")
                    //request_completed(false)
                }
            }catch{
                print("request failed")
                //request_completed(false)
            }
 */
         
           print(String(data: data, encoding: .utf8)!)
           print("data is ovverated")
           //print(String(data:data))
            let str = String(data: data, encoding: .utf8)
            print("printing:" , str)
            if(str == "\n\n1") {
              print("llllloooolllll")
                arg = 1
            }
          semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        return arg;
    }
    
    /*
    func databaseRequest3() {
        let url = URL(string: "http://10.192.122.81/MyWebService/api/createteam.php")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!

        components.queryItems = [
            URLQueryItem(name: "name", value: "uday"),
            URLQueryItem(name: "member", value: "L")
        ]

        let query = components.url!.query
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = Data(query!.utf8)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func databaseRequest2() {
            //declare parameter as a dictionary which contains string as key and value combination. considering inputs are valid

        let parameters = ["name": "uday", "member": 69] as [String : Any]

        //create the url with URL
        let url = URL(string: "http://10.192.122.81/MyWebService/api/createteam.php")! //change the url

        //create the session object
        let session = URLSession.shared

        //now create the URLRequest object using the url object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" //set http method as POST

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }

        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

            guard error == nil else {
                return
            }

            guard let data = data else {
                return
            }

            do {
                //create json object from data
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(json)
                    // handle json...
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        task.resume()
    }
    
    func databaseRequest() {
        //created NSURL
                //let requestURL = NSURL(string: URL_SAVE_TEAM)
                
                //creating NSMutableURLRequest
                let request = NSMutableURLRequest()
                
                //setting the method to post
                request.httpMethod = "POST"
                
                //getting values from text fields
        //        let username = textFieldName.text
        //        let password = textFieldMember.text
                let username = "uday"
                let password = "password"
                
                // name = username, memeberCount=password
                //creating the post parameter by concatenating the keys and values from text field
                let postParameters = "username="+username+"&password="+password;
                
                //adding the parameters to request body
                request.httpBody = postParameters.data(using: String.Encoding.utf8)
                
                
                //creating a task to send the post request
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    
                    if error != nil{
                        print("error is \(String(describing: error))")
                        return;
                    }
                
                    //parsing the response
                    do {
                        //converting resonse to NSDictionary
                        let myJSON =  try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        //parsing the json
                        if let parseJSON = myJSON {
                            
                            //creating a string
                            var msg : String!
                            
                            //getting the json response
                            msg = parseJSON["message"] as! String?
                            
                            //printing the response
                            print(msg!)
                            
                        }
                    } catch {
                        print(error)
                    }
                    
                }
                //executing the task
                task.resume()
    }
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension MainViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
