//
//  OTPViewController.swift
//  Yummy
//
//  Created by hamdi on 15/04/2023.
//

import UIKit
import MapKit

class OTPViewController: UIViewController {
    var area , streetName , mobile :String?
   
        // Array to hold the text fields
        var otpTextFields = [UITextField]()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            addResendUI()
            // Set up the OTP text fields
            setUpOTPTextFields()
            
            // Set up the submit button
            setUpSubmitButton()
        }
        
        // Function to set up the OTP text fields
        // Function to set up the OTP text fields
        func setUpOTPTextFields() {
            
            // Set the frame and size of each text field
            let textFieldWidth: CGFloat = 45
            let textFieldHeight: CGFloat = 60
            
            // Set the x and y coordinates of the first text field
            var x: CGFloat = (view.frame.size.width - (6 * textFieldWidth + 5 * 10)) / 2
            let y: CGFloat = 200
            
            // Create and add the label
            let label = UILabel(frame: CGRect(x: x, y: y - 50, width: 6 * textFieldWidth + 5 * 10, height: 40))
            label.text = "Please enter verification code"
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 20)
            view.addSubview(label)
            
            // Create and add the text fields
            for i in 1...6 {
                let textField = UITextField(frame: CGRect(x: x, y: y, width: textFieldWidth, height: textFieldHeight))
                textField.backgroundColor = UIColor(named: "collectionBackround")!
                textField.font = UIFont.systemFont(ofSize: 30, weight: .semibold)
                textField.textColor = UIColor(named: "Cart")
                textField.textAlignment = .center
                textField.keyboardType = .numberPad
                textField.layer.cornerRadius = 5
                textField.layer.borderWidth = 1
                textField.layer.borderColor = UIColor.gray.cgColor
                textField.tag = i
                textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
                
                otpTextFields.append(textField)
                view.addSubview(textField)
                
                // Increment the x coordinate for the next text field
                x += textFieldWidth + 10
            }
        }

        
        
        // Function to set up the submit button
        func setUpSubmitButton() {
            
            // Set the frame and size of the submit button
            let buttonWidth: CGFloat = 200
            let buttonHeight: CGFloat = 50
            let x: CGFloat = (view.frame.size.width - buttonWidth) / 2
            let y = otpTextFields.last!.frame.origin.y + otpTextFields.last!.frame.size.height + 50
            
            // Create and add the submit button
            let submitButton = UIButton(frame: CGRect(x: x, y: y, width: buttonWidth, height: buttonHeight))
            submitButton.setTitle("Submit", for: .normal)
            submitButton.setTitleColor(UIColor.white, for: .normal)
            submitButton.backgroundColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
            submitButton.layer.cornerRadius = 5
            submitButton.addTarget(self, action: #selector(submitButtonTapped(_:)), for: .touchUpInside)
            
            view.addSubview(submitButton)
        }
        
        // Function to move focus to the next text field after a digit is entered
        @objc func textFieldDidChange(_ textField: UITextField) {
            guard let text = textField.text else { return }
            
            if text.count == 1 {
                if let nextTextField = otpTextFields.first(where: { $0.tag == textField.tag + 1 }) {
                    nextTextField.becomeFirstResponder()
                } else {
                    textField.resignFirstResponder()
                }
            }
        }
        // Function to add the "Didn't receive code" label and resend button
        func addResendUI() {
            // Set up the "Didn't receive code" label
            let resendLabel = UILabel()
            resendLabel.text = "Didn't receive code?"
            resendLabel.font = UIFont.systemFont(ofSize: 17)
            resendLabel.textAlignment = .center
            resendLabel.translatesAutoresizingMaskIntoConstraints = false
            
            view.addSubview(resendLabel)
            
            // Set up the resend button
            let resendButton = UIButton(type: .system)
            resendButton.setTitle("Resend", for: .normal)
            resendButton.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            resendButton.translatesAutoresizingMaskIntoConstraints = false
            resendButton.addTarget(self, action: #selector(resendButtonTapped(_:)), for: .touchUpInside)
            
            view.addSubview(resendButton)
            
            // Set up the resend button counter label
            let resendCounterLabel = UILabel()
            resendCounterLabel.font = UIFont.systemFont(ofSize: 14)
            resendCounterLabel.textAlignment = .center
            resendCounterLabel.translatesAutoresizingMaskIntoConstraints = false
            
            resendButton.addSubview(resendCounterLabel)
            
            // Set up constraints
            resendLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            resendLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -400).isActive = true
            
            resendButton.leadingAnchor.constraint(equalTo: resendLabel.trailingAnchor, constant: 5).isActive = true
            resendButton.centerYAnchor.constraint(equalTo: resendLabel.centerYAnchor).isActive = true
            
            resendCounterLabel.centerXAnchor.constraint(equalTo: resendButton.centerXAnchor).isActive = true
            resendCounterLabel.centerYAnchor.constraint(equalTo: resendButton.centerYAnchor).isActive = true
        }

        // Function to handle resend button tap
        @objc func resendButtonTapped(_ sender: UIButton) {
            // Disable the resend button for 60 seconds
            sender.isEnabled = false
            
            // Set up the countdown timer
            var secondsLeft = 60
            let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
                if secondsLeft == 0 {
                    sender.isEnabled = true
                    timer.invalidate()
                } else {
                    secondsLeft -= 1
                    sender.setTitle("Resend \(secondsLeft)", for: .disabled)
                }
            }
            timer.fire()
        }

        // Function to handle submit button tap
        @objc func submitButtonTapped(_ sender: UIButton) {
            
            // Get the OTP code entered by the user
            let otpCode = otpTextFields.compactMap { $0.text }.joined()
            
            // Validate the OTP code
            if otpCode.count == 6 {
                // Submit the OTP code to the server
                print("Submitting OTP code: \(otpCode)")
                let controller = CheckOutViewController.instantiate(storyBord: "HomeUI")
                controller.region =  MapViewController.region!
                controller.area = area
                controller.streetName = streetName
                controller.mobile = mobile
                navigationController?.pushViewController(controller, animated: true)
            
            } else {
                
            }
            
        }
    }

      
    
    

   


