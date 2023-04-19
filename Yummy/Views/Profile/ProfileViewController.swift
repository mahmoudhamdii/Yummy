//
//  ProfileViewController.swift
//  Yummy
//
//  Created by hamdi on 17/04/2023.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var displayModeController: UISwitch!
    @IBOutlet weak var ordersLable: UILabel!
    static var ordersCount  = 0
    @IBOutlet weak var btnAddCoupon: UIButton!
    @IBOutlet weak var languageControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languageControl.setup()
        languageControl.selectedSegmentTitle
        btnAddCoupon.addBorder
        ordersLable.text = "\(ProfileViewController.ordersCount) Orders"
       
            }
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.hasEnableDarkMode == true {
            displayModeController.isOn = true 
        }
        if ProfileViewController.ordersCount == 1 {
            ordersLable.text = "\(ProfileViewController.ordersCount) Order"
        }else{
            ordersLable.text = "\(ProfileViewController.ordersCount) Orders"
        }
       
    }
    
    @IBAction func displayModeChanged(_ sender: UISwitch) {
        if sender.isOn {
                // Set the app-wide appearance to dark mode
            UserDefaults.standard.hasEnableDarkMode = true
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
            } else {
                UserDefaults.standard.hasEnableDarkMode = false
                // Set the app-wide appearance to light mode
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
            }
    }
 
    
    @IBAction func btnAddCouponTapped(_ sender: Any) {
    }
    @IBAction func btnLocationsTapped(_ sender: Any) {
    }
    
    @IBAction func btnLogoutTapped(_ sender: Any) {
    }


}
