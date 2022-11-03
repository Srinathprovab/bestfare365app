//
//  BottomBookNowTVCell.swift
//  BestFares365App
//
//  Created by FCI on 31/10/22.
//

import UIKit

class BottomBookNowTVCell: UITableViewCell {
    
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var bookNowView: UIView!
    @IBOutlet weak var bookNowlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        holderView.addCornerRadiusWithShadow(color: .LabelTitleColor.withAlphaComponent(0.16), borderColor: .BorderColor, cornerRadius: 8)
        holderView.backgroundColor = .WhiteColor
        setupLabels(lbl: titlelbl, text: "A$250", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 20))
        setupLabels(lbl: bookNowlbl, text: "Book Now", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 18))
        bookNowView.backgroundColor = .ButtonColor
        bookNowView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 4)
        
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    
}
