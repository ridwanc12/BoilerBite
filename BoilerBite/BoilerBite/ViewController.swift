//
//  ViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 2/15/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // added by UC
    //URL to our web service
    let URL_SAVE_TEAM = URL(string: "http://10.192.122.81/MyWebService/api/createteam.php")
       
       //TextFields declarations
       @IBOutlet weak var textFieldName: UITextField!
       @IBOutlet weak var textFieldMember: UITextField!
    
       // the content inside UC
       //Button action method
       @IBAction func buttonSave(sender: UIButton) {
        
        
        //created NSURL
        //let requestURL = NSURL(string: URL_SAVE_TEAM)
        
        //creating NSMutableURLRequest
        let request = NSMutableURLRequest()
        
        //setting the method to post
        request.httpMethod = "POST"
        
        //getting values from text fields
        let username=textFieldName.text
        let password = textFieldMember.text
        
        // name = username, memeberCount=password
        //creating the post parameter by concatenating the keys and values from text field
        let postParameters = "username="+username!+"&password="+password!;
        
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
    // added by UC
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // added by UC
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

