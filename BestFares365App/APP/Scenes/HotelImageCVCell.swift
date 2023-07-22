//
//  HotelImageCVCell.swift
//  BestFares365App
//
//  Created by FCI on 08/11/22.
//

import UIKit

class HotelImageCVCell: UICollectionViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var img: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 6)
    }

}
