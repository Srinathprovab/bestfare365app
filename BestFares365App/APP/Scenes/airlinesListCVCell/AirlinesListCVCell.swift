//
//  AirlinesListCVCell.swift
//  BestFares365App
//
//  Created by FCI on 29/10/22.
//

import UIKit

class AirlinesListCVCell: UICollectionViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var logoImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        lineView.backgroundColor = .BorderColor
        setupLabels(lbl: titlelbl, text: "Emirates ", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 12))
        setupLabels(lbl: subtitlelbl, text: "A$ 150 ", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 14))
        logoImg.image = UIImage(named: "alogo")?.withRenderingMode(.alwaysOriginal)
        logoImg.layer.cornerRadius = 15
        logoImg.clipsToBounds = true
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
}
