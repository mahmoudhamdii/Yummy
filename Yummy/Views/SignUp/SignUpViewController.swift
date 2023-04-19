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
import AVFoundation
class SignUpViewController: UIViewController{
    @IBOutlet weak var lblHaveAcc: UILabel!
    @IBOutlet weak var btnSignin: UIButton!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var imgLogo: UIImageView!
    static var userAuth = ""
    var player = AVPlayer()
    static  var newAcount = false
    @IBOutlet weak var ConfirmPasswordTXF: UITextField!
    @IBOutlet weak var paswordTXF: UITextField!
    @IBOutlet weak var videoLayer: UIView!
    @IBOutlet weak var userNameTXF: UITextField!
    @IBOutlet weak var emailTXF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let fields :[UITextField] = [emailTXF,userNameTXF,paswordTXF,ConfirmPasswordTXF]
        setDelgates(fields: fields)
        let views :[UIView] = [imgLogo,emailTXF,userNameTXF,paswordTXF,ConfirmPasswordTXF,btnSignUp,btnSignin,lblHaveAcc]
        UIView.fadeInViews(views: [imgLogo],duration: 5 ,delay: 1)
        UIView.fadeInViews(views: views,duration: 2 ,delay: 2)
       playVideo()
        navigationItem.hidesBackButton = true
        UITextField.addTXFImage(textField: userNameTXF, img: UIImage(systemName: "person")!)
        UITextField.addTXFImage(textField: paswordTXF, img: UIImage(systemName: "lock")!)
        UITextField.addTXFImage(textField: ConfirmPasswordTXF, img: UIImage(systemName: "lock")!)
        UITextField.addTXFImage(textField: emailTXF , img: UIImage(systemName: "envelope")!)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        player.pause()
    }
    override func viewWillAppear(_ animated: Bool) {
        player.play()
    }
    func setDelgates (fields :[UITextField]){
        for textField in fields {
            textField.delegate = self
        }
    }
    func playVideo(){
       
        guard let path = Bundle.main.path(forResource: "app-intro", ofType: "mp4") else{
            return
        }
         player = AVPlayer(url:URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        playerLayer.opacity = 0.5
        player.volume = 0.0
        self.videoLayer.layer.addSublayer(playerLayer)
        
        player.play()
   videoLayer.bringSubviewToFront(btnSignin)
  videoLayer.bringSubviewToFront(btnSignUp)
   videoLayer.bringSubviewToFront(lblHaveAcc)
    videoLayer.bringSubviewToFront(imgLogo)
  videoLayer.bringSubviewToFront(paswordTXF)
   videoLayer.bringSubviewToFront(emailTXF)
   videoLayer.bringSubviewToFront(userNameTXF)
   videoLayer.bringSubviewToFront(ConfirmPasswordTXF)
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { [weak self] _ in
            self?.player.seek(to: CMTime.zero)
            self?.player.play()
        }
    }
  
 
    @IBAction func btnSigninTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    // Check the fields and validate that the data is correct. If everything is correct, this method returns nil. Otherwise, it returns the error message
    func validateFields() ->String? {
        
        //Check fields are filled in .
        if userNameTXF.trimmedText == "" || paswordTXF.trimmedText == "" ||
            ConfirmPasswordTXF.trimmedText == "" ||
            emailTXF.trimmedText == ""
            
            
        { return "* Please fill all fields." }
        
        // Check password secure.
        let pass = paswordTXF.trimmedText
        if  Utalities.isPasswordValid(pass!) == false {
            // not secure password .
            return "* at least 8 characters, contains a special character and a number."
        }
        if paswordTXF.trimmedText != ConfirmPasswordTXF!.trimmedText {
            return"*passwords you entered do not match. Please try again."
        }
        return nil
    }
    
    
    @IBAction func btnSignupPressed(_ sender: Any) {
        
        // validate fields ///////////////////
         ProgressHUD.show()
        let error = validateFields()
        if error != nil {
            //ProgressHUD.showError(error)
            emailTXF.delegate = self
            ProgressHUD.showError(error)
        }
        else
        {
            ProgressHUD.dismiss()
            //data clean vesion
            let userName = userNameTXF.trimmedText
            let email = emailTXF.trimmedText
            let password = paswordTXF.trimmedText
            
            //  create  user
            Auth.auth().createUser(withEmail: email!, password:password!) { result , error in
                //check error
                if let error = error {
                    
                    ProgressHUD.showError(error.localizedDescription)
                }else{
                    //user created succesfully , store
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["user_name":userName,"uid":result!.user.uid]) {(error) in
                        if  error != nil
                        {
                            
                            //ProgressHUD.showError(error?.localizedDescription)
                        }
                        
                    }
                    // Transition to the home screen
                    SignUpViewController.newAcount = true
                    SignUpViewController.userAuth = self.userNameTXF.text!
                    UserDefaults.standard.hasAuthorization = true
                    UserDefaults.standard.hasAuthorization = true
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "MainSB")
                    
                    self.present(controller, animated: true)
                }
                
                
                
            }
            
            
        }
    }
}
extension SignUpViewController :UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTXF {
            userNameTXF.becomeFirstResponder()
        }else if textField == userNameTXF{
            paswordTXF.becomeFirstResponder()
        }
        else if textField == paswordTXF{
            ConfirmPasswordTXF.becomeFirstResponder()
        }else if  textField == ConfirmPasswordTXF {
            btnSignupPressed(UIButton.self)
        }
        return true
    }
}
