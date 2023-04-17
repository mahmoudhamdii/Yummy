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
        setupsSegmentControll()
        ordersLable.text = "\(ProfileViewController.ordersCount) Orders"
        addCouponSetup()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        if ProfileViewController.ordersCount == 1 {
            ordersLable.text = "\(ProfileViewController.ordersCount) Order"
        }else{
            ordersLable.text = "\(ProfileViewController.ordersCount) Orders"
        }
       
    }
    func addCouponSetup(){
        btnAddCoupon.layer.borderWidth = 1
        btnAddCoupon.layer.borderColor = #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1).cgColor
    }
    
    @IBAction func btnAddCouponTapped(_ sender: Any) {
    }
    @IBAction func btnLocationsTapped(_ sender: Any) {
    }
    
    @IBAction func btnLogoutTapped(_ sender: Any) {
    }
   func  setupsSegmentControll(){
       // Create a dictionary to hold the attributes for the segmented control title
       var titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
       languageControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
       languageControl.setTitleTextAttributes(titleTextAttributes, for: .selected)
       // Set the title text attributes for the normal state of the segmented control
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)]
       languageControl.setTitleTextAttributes(titleTextAttributes, for: .normal)
    }

}
