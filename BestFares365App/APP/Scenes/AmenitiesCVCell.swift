//
//  AmenitiesCVCell.swift
//  BabSafar
//
//  Created by MA673 on 02/08/22.
//

import UIKit

class AmenitiesCVCell: UICollectionViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var radioImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        holderView.backgroundColor = .WhiteColor
        radioImg.image = UIImage(named: "round")
        titlelbl.textColor = HexColor("#5B5B5B")
        titlelbl.font = UIFont.ProximaNovaRegular(size: 14)
    }
    
}
