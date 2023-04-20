//
//  CheckOutViewController.swift
//  Yummy
//
//  Created by hamdi on 16/03/2023.
//

import UIKit
import MapKit
import ProgressHUD
class CheckOutViewController: UIViewController ,UITextFieldDelegate {
    @IBOutlet weak var enterCoupnTXF: UITextField!
    var discountPars = -0.0
    var discountvalue  = ["":0]
    var arrCopuns = ["Yummy50"]
    var cash = false , visa = false
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblServiceFee: UILabel!
    @IBOutlet weak var lblDeliveryFee: UILabel!
    @IBOutlet weak var lblDiscount: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblAdress: UILabel!
    @IBOutlet weak var lblArea: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var recietView: CardView!
    @IBOutlet weak var paymentTableView: UITableView!
    @IBOutlet weak var btnSummitCoupon: UIButton!
    @IBOutlet weak var CouponView: CardView!
    @IBOutlet weak var paymentView: CardView!
    @IBOutlet weak var deliveryView: CardView!
    @IBOutlet weak var btnVisa: UIButton!
    @IBOutlet weak var txfEnterCoupon: UITextField!
    
    @IBOutlet weak var btnCash: UIButton!
    @IBOutlet weak var locationView: CardView!
    var region :MKCoordinateRegion?
    var area , streetName , mobile :String?
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.setRegion(region!, animated: true)
        mapView.isScrollEnabled = false
        mapView.isZoomEnabled = false
        mapView.isUserInteractionEnabled = false
        navigationController?.navigationBar.tintColor =   #colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1)
        let backButton = UIBarButtonItem(title: "Orders", style: .plain, target: self, action: #selector(backButtonPressed))
            navigationItem.leftBarButtonItem = backButton
        UIView.setBorder(view: locationView)
        UIView.setBorder(view: deliveryView)
        UIView.setBorder(view: CouponView)
        UIView.setBorder(view: paymentView)
        UIView.setBorder(view: recietView)
        
        txfEnterCoupon.delegate = self
        lblMobile.text = ("+20\(mobile!)")
        lblArea.text = area
        lblAdress.text = streetName
        BuiltResite()
        discountvalue[ arrCopuns[0]] = 50
    }
    @IBAction func btnSummitCopunPrsset(_ sender: Any) {
        let currentTitle = btnSummitCoupon.title(for: .normal)
        if currentTitle == "Cancel" {
            discountPars = 0.0
            BuiltResite()
            enterCoupnTXF.isUserInteractionEnabled = true
            enterCoupnTXF.text = ""
            btnSummitCoupon.setTitle("Submit", for: .normal)
        }else{
            let coupon = enterCoupnTXF.text!
            if arrCopuns.contains(coupon){
                discountPars = (Double((discountvalue[coupon])!) * 10).rounded() / -10
                ProgressHUD.showSuccess("you get \(discountPars)% discount now")
                BuiltResite()
                enterCoupnTXF.isUserInteractionEnabled = false
                btnSummitCoupon.setTitle("Cancel", for: .normal)
            }else{
                ProgressHUD.showError("Enter Valid Coupon")
            }
        }
        
    }
    @objc func backButtonPressed() {
        if let navigationController = self.navigationController {
            let viewControllers = navigationController.viewControllers
            if viewControllers.count >= 5 {
                let destinationVC = viewControllers[viewControllers.count - 5]
                navigationController.popToViewController(destinationVC, animated: true)
            }
        }

    }
    @IBAction func btnVIsaPressed(_ sender: Any) {
        cash = false
        visa = true
        let myImage = UIImage(systemName: "circle.fill")
        let myTintedSystemImage = myImage?.withTintColor(#colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1), renderingMode: .alwaysOriginal)
       btnVisa.setImage(myTintedSystemImage, for: .normal)
        let Image2 = UIImage(systemName: "circle")
        
        btnCash.setImage(Image2, for: .normal)
        createAlert()
        
    }
    @IBAction func btnCashTapped(_ sender: Any) {
        cash = true
        visa = false
        let myImage = UIImage(systemName: "circle.fill")
        let myTintedSystemImage = myImage?.withTintColor(#colorLiteral(red: 0.5803921569, green: 0.09019607843, blue: 0.1843137255, alpha: 1), renderingMode: .alwaysOriginal)
        btnCash.setImage(myTintedSystemImage, for: .normal)
        let Image2 = UIImage(systemName: "circle")
        btnVisa.setImage(Image2, for: .normal)
    }
    func BuiltResite(){
        let price = (Double(ListOrderViewController.price) * 10).rounded() / 10
        lblSubTotal.text = "EGP \(price)"
        lblDiscount.text = "EGP \(calculateDiscount())"
        lblDeliveryFee.text = "EGP 20.0"
        lblServiceFee.text = "EGP \(calculateSreviceFee())"
        lblTotalAmount.text = "EGP \(calculateTotalAmount())"
    }
    func calculateDiscount()->Double{
        let price = (Double(ListOrderViewController.price) * 10).rounded() / 10
        let pars = 100 / discountPars
        return price / pars
    }
    
    
    func calculateSreviceFee()->Double{
        let price = ListOrderViewController.price
        let result = Double(5) / 100.0 * Double(price)
        return (result * 10).rounded() / 10
        
    }
    func calculateTotalAmount()->Double{
        let price = Double(ListOrderViewController.price)
        let deliveryFee = 20.0
        let seviceFee = calculateSreviceFee()
        let discount = calculateDiscount()
        let total = price + deliveryFee + seviceFee + discount
        return  (total * 10).rounded() / 10
    }
    override func viewWillAppear(_ animated: Bool) {
        
        
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
   func createAlert(){
       let alertController = UIAlertController(title: "unavailable", message: "Pay using credit card will be available soon", preferredStyle: .alert)
       let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
       alertController.addAction(okAction)
       present(alertController, animated: true, completion: nil)

    }
    
    @IBAction func btnChangeTapped(_ sender: Any) {
        if let navigationController = self.navigationController {
            let viewControllers = navigationController.viewControllers
            if viewControllers.count >= 3 {
                let destinationVC = viewControllers[viewControllers.count - 3]
                navigationController.popToViewController(destinationVC, animated: true)
            }
        }
    }
    @IBAction func btnPlaceOrderTapped(_ sender: Any) {
        ProgressHUD.show("Placing order ......")
        if visa || cash {
            if cash {
                ProgressHUD.showSucceed("Your order has been recived")
                ProfileViewController.ordersCount += 1
                ListOrderViewController.ordersCount
                if let navController = self.navigationController {
                    navController.popToRootViewController(animated: true)
                }
            }else{
                ProgressHUD.dismiss()
                createAlert()
            }
        }else{
            ProgressHUD.showError("Plese select payment method")
        }
       
    }
}
