//
//  SignUpViewController.swift
//  Yummy
//
//  Created by hamdi on 28/02/2023.
//

import UIKit
import FirebaseAuth
import ProgressHUD
import Firebase
class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var ConfirmPasswordTXF: UITextField!
    @IBOutlet weak var paswordTXF: UITextField!
    @IBOutlet weak var userNameTXF: UITextField!
    @IBOutlet weak var emailTXF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Utalities.addTXFImage(textField: userNameTXF, img: UIImage(systemName: "person")!)
        Utalities.addTXFImage(textField: paswordTXF, img: UIImage(systemName: "lock")!)
        Utalities.addTXFImage(textField: ConfirmPasswordTXF, img: UIImage(systemName: "lock")!)
        Utalities.addTXFImage(textField: emailTXF , img: UIImage(systemName: "envelope")!)
        
        
    }
    
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() ->String? {
        
        //Check fields are filled in .
        if userNameTXF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || paswordTXF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            ConfirmPasswordTXF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTXF.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            
            
        { return "* Please fill all fields." }
        
        // Check password secure.
        let pass = paswordTXF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if  Utalities.isPasswordValid(pass) == false {
            // not secure password .
            return "* at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    
    @IBAction func btnSignupPressed(_ sender: Any) {
        
        // validate fields ///////////////////
        // ProgressHUD.show()
        let error = validateFields()
        if error != nil {
            //ProgressHUD.showError(error)
            emailTXF.delegate = self
            emailTXF.setError(error)
        }
        else
        {
            //ProgressHUD.dismiss()
            //data clean vesion
            let userName = userNameTXF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTXF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = paswordTXF.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            //  create  user
            Auth.auth().createUser(withEmail: email, password:password) { result , error in
                //check error
                if let error = error {
                    
                    self.emailTXF.setError(error.localizedDescription)
                }else{
                    //user created succesfully , store
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["user_name":userName,"uid":result!.user.uid]) {(error) in
                        if  error != nil
                        {
                            
                            self.emailTXF.setError(error?.localizedDescription)
                        }
                        
                    }
                    // Transition to the home screen
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "MainSB")
                    
                    self.present(controller, animated: true)
                }
                
                
                
            }
            
            
        }
    }
}
