//
//  DepartureTimeCVCell.swift
//  BestFares365App
//
//  Created by FCI on 30/10/22.
//

import UIKit

class DepartureTimeCVCell: UICollectionViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 16)
        holderView.backgroundColor = .WhiteColor
        setupLabels(lbl: titlelbl, text: "", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 14))
        setupLabels(lbl: subtitlelbl, text: "", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 14))
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    func selected() {
        holderView.backgroundColor = .CalSelectedColor
        titlelbl.textColor = .WhiteColor
        subtitlelbl.textColor = .WhiteColor
        
    }
    
    
    func unselected() {
        holderView.backgroundColor = .WhiteColor
        titlelbl.textColor = .LabelTitleColor
        subtitlelbl.textColor = .LabelTitleColor
    }
    
    
    
}
