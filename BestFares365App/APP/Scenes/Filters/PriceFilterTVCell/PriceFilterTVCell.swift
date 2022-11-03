//
//  PriceFilterTVCell.swift
//  BestFares365App
//
//  Created by FCI on 30/10/22.
//

import UIKit
import TTRangeSlider

class PriceFilterTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var rangeSlider: TTRangeSlider!
    @IBOutlet weak var dropdownImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        subtitlelbl.text = cellInfo?.subTitle
    }
    
    
    func setupUI() {
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        holderView.backgroundColor = .WhiteColor
        setupLabels(lbl: titlelbl, text: "Price", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 16))
        setupLabels(lbl: subtitlelbl, text: "A$473 - A$1588", textcolor: .LabelTitleColor, font: .SigvarRegular(size: 16))
        dropdownImg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.LabelTitleColor)
        setupRangeSlider()
    }
    
    func setupRangeSlider() {
      //  rangeSlider.delegate = self
        rangeSlider.backgroundColor = .WhiteColor
        rangeSlider.handleType = .rectangle
        rangeSlider.lineHeight = 5
        rangeSlider.tintColor = .BtnUnselectedColor
        rangeSlider.tintColorBetweenHandles = .CalSelectedColor
        rangeSlider.lineBorderColor = HexColor("#E7E7E7")
        rangeSlider.handleDiameter = 30.0
        rangeSlider.hideLabels = true
        rangeSlider.handleColor = HexColor("#009DEA")
        rangeSlider.handleImage = UIImage(named: "handel")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
}
