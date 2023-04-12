//
//  CheckOutViewController.swift
//  Yummy
//
//  Created by hamdi on 16/03/2023.
//

import UIKit

class CheckOutViewController: UIViewController ,UITextFieldDelegate {
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var recietView: CardView!
    @IBOutlet weak var paymentTableView: UITableView!
    @IBOutlet weak var CouponView: CardView!
    @IBOutlet weak var paymentView: CardView!
    @IBOutlet weak var deliveryView: CardView!
    @IBOutlet weak var txfEnterCoupon: UITextField!
    @IBOutlet weak var btnSummitCoupon: UIButton!
    @IBOutlet weak var locationView: CardView!
    var cheakLocation :Bool =  false
    override func viewDidLoad() {
        super.viewDidLoad()
        registerpaymentCell()
        UIView.setBorder(view: locationView)
        UIView.setBorder(view: deliveryView)
        UIView.setBorder(view: CouponView)
        UIView.setBorder(view: paymentView)
        UIView.setBorder(view: recietView)
        paymentTableView.delegate = self
        paymentTableView.dataSource = self
        txfEnterCoupon.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        if cheakLocation {
            locationView.isHidden = false
            ContainerView.isHidden = true
        }else{
            locationView.isHidden = true
            ContainerView.isHidden = false
        }
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // Check if the new text will be empty
            let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
            if newString.isEmpty {
                // Set the button to be hidden
                btnSummitCoupon.isHidden = true
            } else {
                // Set the button to be unhidden
                btnSummitCoupon.isHidden = false
            }

            return true
        }
    
    func registerpaymentCell (){
        paymentTableView.register(UINib(nibName: "PaymentTableViewCell", bundle: nil), forCellReuseIdentifier: "PaymentTableViewCell")
    }

    

}
extension CheckOutViewController :UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"PaymentTableViewCell", for: indexPath)as!PaymentTableViewCell
   
        
        if indexPath.row == 0 {
            cell.setupCell(payimg: UIImage(named: "Visa")!, title: " Credit Card")
        }else{
            cell.setupCell(payimg: UIImage(named: "Cash")!, title: " Cash")
        }
        return cell
    }
    
    
}

