//
//  SendFeedbackViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 4/14/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//

import UIKit

class SendFeedbackViewController: UIViewController {
    
    // Text field for Send Feedback
    @IBOutlet weak var feedbackText: UITextField!
    
    // Function for when the "Send" button is pressed
    @IBAction func sendTapped(_ sender: UIButton) {
        var feedback: String = feedbackText.text ?? ""
        send_feedback(feedback: feedback)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func send_feedback(feedback: String) {
        let semaphore = DispatchSemaphore (value: 0)

        //let username: String = usernameField.text ?? ""
        //let password: String = passwordField.text ?? ""
        
        // user changed to username
        //let username = "sssssss"
        //print("calories: " ,calories)
        //print("username: " ,username)
        
        //let userr:String = String(global_username ?? "0") ?? "ss"
        //let calories: Int = Int(caloriesField.text ?? "0") ?? 0
        
        let originalString = String(format: "http://boilerbite.000webhostapp.com/php/mail.php?feedback=%@", feedback)
        let urlString = originalString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//        let urlString = String(format: "http://boilerbite.000webhostapp.com/php/mail.php?feedback=%@", feedback)
        /*
         var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
         */
         
        let r = URL(string: urlString)!
        print(r)
         var request = URLRequest(url: URL(string: urlString)!,timeoutInterval:       Double.infinity)
        
        request.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
          print(String(data: data, encoding: .utf8)!)
          semaphore.signal()
        }

        task.resume()
        semaphore.wait()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
