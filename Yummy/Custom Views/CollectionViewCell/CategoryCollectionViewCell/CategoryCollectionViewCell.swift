//
//  CategoryCollectionViewCell.swift
//  Yummy
//
//  Created by hamdi on 24/02/2023.
//

import UIKit
import Kingfisher
class CategoryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var lblCategoryTittle: UILabel!
    @IBOutlet weak var iamgeView: UIImageView!
    func setUp (category : DishCategory){
        lblCategoryTittle.text = category.title
        iamgeView.kf.setImage(with: category.image?.asUrl)
    }

}
