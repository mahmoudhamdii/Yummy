//
//  LoginViewController.swift
//  Yummy
//
//  Created by hamdi on 28/02/2023.
//

import UIKit
import AVFoundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
import ProgressHUD
class LoginViewController: UIViewController {
    
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var btnGoSignUp: UIButton!
    var player = AVPlayer()
  
    @IBOutlet weak var videoLayar: UIView!
    @IBOutlet weak var lblNoAccount: UILabel!
    @IBOutlet weak var btnSignin: UIButton!
    @IBOutlet weak var btnForgetPassword: UIButton!
    @IBOutlet weak var passwordTXF: UITextField!
    @IBOutlet weak var userNameTXF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTXF.delegate = self
        userNameTXF.delegate = self
        let views : [UIView] = [imgLogo,passwordTXF,userNameTXF,btnSignin,lblNoAccount,btnGoSignUp,btnForgetPassword]
        UIView.fadeInViews(views: [imgLogo],duration: 5 ,delay: 1)
        UIView.fadeInViews(views:views ,duration: 2 ,delay: 2)
        playVideo()
        UITextField.addTXFImage(textField: userNameTXF, img: UIImage(systemName: "person")!)
        UITextField.addTXFImage(textField: passwordTXF, img: UIImage(systemName: "lock")!)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        player.pause()
    }
    override func viewWillAppear(_ animated: Bool) {
        player.play()
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
        self.videoLayar.layer.addSublayer(playerLayer)
        
        player.play()
        videoLayar.bringSubviewToFront(btnSignin)
        videoLayar.bringSubviewToFront(btnGoSignUp)
        videoLayar.bringSubviewToFront(lblNoAccount)
        videoLayar.bringSubviewToFront(btnForgetPassword)
        videoLayar.bringSubviewToFront(imgLogo)
        videoLayar.bringSubviewToFront(userNameTXF)
        videoLayar.bringSubviewToFront(passwordTXF)
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: nil) { [weak self] _ in
            self?.player.seek(to: CMTime.zero)
            self?.player.play()
        }
    }
  
    
    
    
    @IBAction func btnSigninPressed(_ sender: Any) {
        ProgressHUD.show()
        //validate text fields
        if userNameTXF.trimmedText == "" || passwordTXF.trimmedText == "" {
            let err = "Please fill all fields."
            ProgressHUD.showError(err)
        }else{
            //clear data
            let email  = userNameTXF.trimmedText
            let password = passwordTXF.trimmedText
            // singing  in user
            Auth.auth().signIn(withEmail: email!, password: password!) { (userdata, error ) in
                if error != nil {
                    ProgressHUD.showError(error?.localizedDescription)
                    //can't sign in
                }else{
                    UserDefaults.standard.hasAuthorization = true
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let controller = storyboard.instantiateViewController(withIdentifier: "MainSB")
                    
                    self.present(controller, animated: true)
                }
            }
            
        }
    }
    @IBAction func btnForgetpasswordPresst(_ sender: Any) {
    }
    
}

extension LoginViewController :UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTXF {
            passwordTXF.becomeFirstResponder()
        }else{
            btnSigninPressed(UIButton.self)
        }
        return true
    }
}

