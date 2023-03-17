//
//  CheckOutViewController.swift
//  Yummy
//
//  Created by hamdi on 16/03/2023.
//

import UIKit

class CheckOutViewController: UIViewController {
    @IBOutlet weak var CouponView: CardView!
    
    @IBOutlet weak var deliveryView: CardView!
    @IBOutlet weak var locationView: CardView!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.setBorder(view: locationView)
        UIView.setBorder(view: deliveryView)
        UIView.setBorder(view: CouponView)
       
    }
    

    

}
