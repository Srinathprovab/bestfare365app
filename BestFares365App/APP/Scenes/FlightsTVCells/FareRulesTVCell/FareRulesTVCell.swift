//
//  FareRulesTVCell.swift
//  BestFares365App
//
//  Created by FCI on 31/10/22.
//

import UIKit

protocol FareRulesTVCellDelegate {
    func didTapOnMoreButton(cell:FareRulesTVCell)
}

class FareRulesTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var ul: UIView!
    @IBOutlet weak var moreBtn: UIButton!
    
    
    var delegate:FareRulesTVCellDelegate?
    var subtitle = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Et at dolor quis ac auctor cursus et nulla semper. Molestie pharetra ut blandit posuere. Arcu praesent morbi vivamus vel. Blandit commodo bibendum lacus, elementum fringilla quis. Leo facilisis turpis adipiscing accumsan, nunc, aliquam quam at elit.\n"
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
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        holderView.backgroundColor = .WhiteColor
        ul.backgroundColor = .BorderColor
        setupLabels(lbl: titlelbl, text: "Fare Rules", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 20))
        setupLabels(lbl: subtitlelbl, text: subtitle, textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 14))
        moreBtn.addTarget(self, action: #selector(didTapOnMoreButton(_:)), for: .touchUpInside)
        moreBtn.setTitle("More", for: .normal)
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    @objc func didTapOnMoreButton(_ sender:UIButton) {
        delegate?.didTapOnMoreButton(cell: self)
    }
    
    
}
