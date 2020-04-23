//
//  UpdatePasswordViewController.swift
//  BoilerBite
//
//  Created by Isha Mahadalkar on 4/4/20.
//  Copyright © 2020 Isha Mahadalkar. All rights reserved.
//
/*
import UIKit

class UpdatePasswordViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var currentPasswordText: UITextField!
    @IBOutlet weak var newPasswordText: UITextField!
    
    // Action function when the update button is pressed
    @IBAction func updateTapped(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
 */

 //
 //  UpdatePasswordViewController.swift
 //  BoilerBite
 //
 //  Created by Isha Mahadalkar on 4/4/20.
 //  Copyright © 2020 Isha Mahadalkar. All rights reserved.
 //

 import UIKit

 class UpdatePasswordViewController: UIViewController {

     @IBOutlet weak var nameLabel: UILabel!
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
         
//        print(username)
//        print(global_username)
//        print(old_password)
//        print(global_password)
        if (username != global_username || old_password != global_password) {
            print("inside")
            flag = 1;
            let alert = UIAlertController(title: "Error" , message: "Enter all information correctly!", preferredStyle: .alert)
            
            let action = UIAlertAction(title: "OK" , style: .default) { (action) in
                print("wrong username or password")
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
             print("password: " ,password)
             if flag == 0 {
                update_pass(password: password)
                global_password = password
             }
             
            //global_password = password

             updateButton.addTarget(self, action: #selector(loadData), for: .touchUpInside)
            self.performSegue(withIdentifier: "successChange", sender: self)
             //reload();
     }
     
     override func viewDidLoad() {
         super.viewDidLoad()

         // Do any additional setup after loading the view.
     }
     
     func update_pass(password: String) {
         print("username: " ,password)
         let semaphore = DispatchSemaphore (value: 0)
         //var arg = 0
         //let username: String = usernameField.text ?? ""
         //let password: String = passwordField.text ?? ""
         
         // user changed to username
         
         //print("hashpass2 : ", password)
         
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
           //print(String(data: data, encoding: .utf8)!)
           //print("data is ovverated")
           //print(String(data:data))
            //let str = String(data: data, encoding: .utf8)
            //print("printing:" , str)
            //if(str == "\n\n1") {
              //print("llllloooolllll")
                //arg = 1
            //}
           //semaphore.signal()
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


