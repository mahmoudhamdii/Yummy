//
//  DishDetailViewController.swift
//  Yummy
//
//  Created by hamdi on 25/02/2023.
//

import UIKit
import ProgressHUD
class DishDetailViewController: UIViewController {

    @IBOutlet weak var btnPlaceOrder: UIButton!
    @IBOutlet weak var nameTXF: UITextField!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblCalories: UILabel!
    @IBOutlet weak var lblTittle: UILabel!
    var dish :Dish!
    @IBOutlet weak var dishImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

      populateView()
    }
    private func populateView (){
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        lblTittle.text =  dish.name
        lblDescription.text = dish.description
        lblCalories.text = dish.formatedCaleorie
    }
    
    @IBAction func btnPlaceOrderPressed(_ sender: Any) {
        guard let name = nameTXF.text?.trimmingCharacters(in: .whitespaces),!name.isEmpty else{
            ProgressHUD.showError("Plase enter your special request")
            return
        }
        ProgressHUD.show("adding to cart ......")
        NetworkService.shared.placeOrder(dishId: dish.id ?? "", name: name) { (result) in
            switch result {
                
            case .success( _):
                ListOrderViewController.ordersCount += 1 
                ProgressHUD.showSucceed("Your order has been added to the cart")
                self.nameTXF.text = ""
            case .failure(let error ):
                ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    
    
}
