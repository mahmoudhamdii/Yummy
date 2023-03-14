//
//  LoginViewController.swift
//  Yummy
//
//  Created by hamdi on 28/02/2023.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import ProgressHUD
      class LoginViewController: UIViewController {
    
    @IBOutlet weak var passwordTXF: UITextField!
    @IBOutlet weak var userNameTXF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        Utalities.addTXFImage(textField: userNameTXF, img: UIImage(systemName: "person")!)
        Utalities.addTXFImage(textField: passwordTXF, img: UIImage(systemName: "envelope")!)
    }
    
   
    
    @IBAction func btnSigninPressed(_ sender: Any) {
        //validate text fields
        if userNameTXF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTXF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            let err = "Please fill all fields."
            ProgressHUD.showError(err)
        }else{
            //clear data
            let email  = userNameTXF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTXF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            // singing  in user
            Auth.auth().signIn(withEmail: email, password: password) { (userdata, error ) in
                if error != nil {
                    ProgressHUD.showError(error?.localizedDescription)
                    //can't sign in
                }else{
                    let controller = self.storyboard?.instantiateViewController(withIdentifier: "HomeNC")
                    self.present(controller!, animated: true)
                }
        }
       
        }
    }
    @IBAction func btnForgetpasswordPresst(_ sender: Any) {
    }
    
}

    
    
