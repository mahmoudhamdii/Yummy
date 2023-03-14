//
//  DishPortraitCollectionViewCell.swift
//  Yummy
//
//  Created by hamdi on 24/02/2023.
//

import UIKit
import Kingfisher
class DishPortraitCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lblTittle: UILabel!
    
    @IBOutlet weak var dishImageView: UIImageView!
    
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblCalories: UILabel!
    func setUp(dish : Dish){
        lblTittle.text = dish.name
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        lblCalories.text = dish.formatedCaleorie
        lblDescription.text = dish.description
        
    }
}
