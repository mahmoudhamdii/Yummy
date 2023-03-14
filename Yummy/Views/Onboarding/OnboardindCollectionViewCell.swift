//
//  OnboardindCollectionViewCell.swift
//  Yummy
//
//  Created by hamdi on 23/02/2023.
//

import UIKit

class OnboardindCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblSlideDescrption: UILabel!
    @IBOutlet weak var lblSlideTittle: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    func setUp(_slide :OnboardingSlide) {
        imageView.image = _slide.photo
        lblSlideTittle.text = _slide.tittle
        lblSlideDescrption.text = _slide.description
    }
}
