//
//  SelectClassCVCell.swift
//  BestFares365App
//
//  Created by FCI on 28/10/22.
//

import UIKit

class SelectClassCVCell: UICollectionViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.layer.borderWidth = 1
        holderView.layer.borderColor = UIColor.BorderColor.cgColor
        holderView.layer.cornerRadius = 4
        holderView.clipsToBounds = true
        setupLabels(lbl: titlelbl, text: "", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 18))
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    
    func selected() {
        titlelbl.textColor = .WhiteColor
        holderView.backgroundColor = .CalSelectedColor
    }
    
    
    func unselected() {
        titlelbl.textColor = .LabelSubTitleColor
        holderView.backgroundColor = .WhiteColor
    }
    
    
    func setupSortByFilterView() {
        setupLabels(lbl: titlelbl, text: "", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 14))
        titlelbl.font = .ProximaNovaRegular(size: 14)
        holderView.layer.cornerRadius = 16
        holderView.clipsToBounds = true
    }
    
}
