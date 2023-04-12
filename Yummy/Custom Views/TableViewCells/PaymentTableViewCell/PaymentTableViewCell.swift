//
//  PaymentTableViewCell.swift
//  Yummy
//
//  Created by hamdi on 17/03/2023.
//

import UIKit

class PaymentTableViewCell: UITableViewCell {

    @IBOutlet weak var cellView: CardView!
    
    @IBOutlet weak var selectedCircle: UIImageView!
    
    @IBOutlet weak var lbltittle: UILabel!
    @IBOutlet weak var paymentIconImg: UIImageView!
   
    func setupCell (payimg:UIImage ,title:String){
        lbltittle.text = title
        paymentIconImg.image = payimg
        
    }
}
