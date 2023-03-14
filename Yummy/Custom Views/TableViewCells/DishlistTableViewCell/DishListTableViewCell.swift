//
//  TestTableViewCell.swift
//  Yummy
//
//  Created by hamdi on 25/02/2023.
//

import UIKit
import Kingfisher
class DishListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dishImageView: UIImageView!
    
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTittle: UILabel!
    func setup(dish :Dish){
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        lblTittle.text = dish.name
        lblDescription.text = dish.description
        
    }
    func setup(order:Order){
        dishImageView.kf.setImage(with: order.dish?.image?.asUrl)
        lblTittle.text = order.dish?.name
        lblDescription.text = order.name
    }
}
