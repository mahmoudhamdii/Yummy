//
//  DishLandscapeCollectionViewCell.swift
//  Yummy
//
//  Created by hamdi on 24/02/2023.
//

import UIKit
import Kingfisher
class DishLandscapeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblCalories: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var lblTittle: UILabel!
    @IBOutlet weak var dishImageView: UIImageView!
    func setup(dish :Dish){
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        lblTittle.text = dish.name
        lblDescription.text = dish.description
        lblCalories.text = dish.formatedCaleorie
    }
}
