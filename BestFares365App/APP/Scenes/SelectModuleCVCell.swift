//
//  SelectModuleCVCell.swift
//  BestFares365App
//
//  Created by FCI on 27/10/22.
//

import UIKit

class SelectModuleCVCell: UICollectionViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupLabels(lbl: titlelbl, text: "", textcolor: .WhiteColor, font: .SigvarRegular(size: 16))
        holderView.backgroundColor = .clear
        img.layer.cornerRadius = img.frame.width / 2
        img.clipsToBounds = true
        img.layer.borderWidth = 5
        img.layer.borderColor = UIColor.WhiteColor.cgColor
    }
    
    //MARK:- SETUP UI LABELS
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func selected() {
        img.layer.borderColor = UIColor.TabSelectColor.cgColor
    }
    
    
    func unselected() {
        img.layer.borderColor = UIColor.WhiteColor.cgColor
    }
    
}
