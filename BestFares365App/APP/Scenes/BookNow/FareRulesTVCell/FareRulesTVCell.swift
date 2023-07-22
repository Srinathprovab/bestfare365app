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
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    var delegate:FareRulesTVCellDelegate?
    var subtitle = String()

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
        viewHeight.constant = 200
        subtitlelbl.attributedText = cellInfo?.title?.htmlToAttributedString

    }
    
    func setupUI() {
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        holderView.backgroundColor = .WhiteColor
        ul.backgroundColor = .BorderColor
        setupLabels(lbl: titlelbl, text: "Fare Rules", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 20))
        setupLabels(lbl: subtitlelbl, text: "", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14))
        moreBtn.addTarget(self, action: #selector(didTapOnMoreButton(_:)), for: .touchUpInside)
        self.moreBtn.setTitle("+ More", for: .normal)
        
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
