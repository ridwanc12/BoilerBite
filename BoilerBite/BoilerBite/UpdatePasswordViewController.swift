
 //
 //  UpdatePasswordViewController.swift
 //  BoilerBite
 //
 //  Created by Isha Mahadalkar on 4/4/20.
 //  Copyright © 2020 Isha Mahadalkar. All rights reserved.
 //

 import UIKit

 class UpdatePasswordViewController: UIViewController, UITextFieldDelegate {
    
    var user = global_username

    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
           nameLabel.text = "\(user)"
        }
    }
     @IBOutlet weak var usernameText: UITextField!
     @IBOutlet weak var currentPasswordText: UITextField!
     @IBOutlet weak var newPasswordText: UITextField!
     
     // Action function when the update button is pressed
     
     @objc func loadData () {
         //self.loadData();
     }
     
     @IBOutlet weak var updateButton: UIButton!
     
     
     @IBAction func buttonTapped(_ sender: UIButton) {
         
         let password: String = newPasswordText.text ?? ""
         let old_password: String = currentPasswordText.text ?? ""
         let username: String = usernameText.text ?? ""
         //global_username = username
         var flag = 0
         if password.count < 6 {
             flag = 1;
             let alert = UIAlertController(title: "Error" , message: "Enter all information correctly!", preferredStyle: .alert)
             
             let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                 print("password should have length greater than 6")
             }
             
             alert.addAction(action)
             present(alert, animated: true, completion: nil)
         }
         if password == "" {
             flag = 1;
             let alert = UIAlertController(title: "Error" , message: "Enter all information correctly!", preferredStyle: .alert)
             
             let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                 print("new password field empty")
             }
             
             alert.addAction(action)
             present(alert, animated: true, completion: nil)
         }
         
        if (username != global_username || old_password != global_password) {
            flag = 1;
            let alert = UIAlertController(title: "Error" , message: "Enter all information correctly!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("wrong username or password")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
        if flag == 0 {
            print("Correct username and password")
            update_pass(password: password)
            global_password = password
            print("username: " , global_username)
            print("password: " , global_password)
            
            self.performSegue(withIdentifier: "successChange", sender: self)
        }

        updateButton.addTarget(self, action: #selector(loadData), for: .touchUpInside)
        
     }
    
     
     override func viewDidLoad() {
         super.viewDidLoad()
        
        overrideUserInterfaceStyle = .light
        
        usernameText.delegate = self
        currentPasswordText.delegate = self
        newPasswordText.delegate = self
         // Do any additional setup after loading the view.
     }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        usernameText.resignFirstResponder()
        currentPasswordText.resignFirstResponder()
        newPasswordText.resignFirstResponder()
    }

     
     func update_pass(password: String) {
         // print("username: " ,password)
         let semaphore = DispatchSemaphore (value: 0)
         let urlString = String(format: "http://boilerbite.000webhostapp.com/php/change_pass.php?userName=%@&hashPass=%@", global_username, password)
         var request = URLRequest(url: URL(string: urlString)!,timeoutInterval: Double.infinity)
         request.httpMethod = "POST"

         //global_username = username
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
        
         //return arg
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



