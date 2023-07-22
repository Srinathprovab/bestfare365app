//
//  SelectLanguageTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class SelectLanguageTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var langLogoImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        unselected()
    }
    
    
    override func updateUI() {
        
        titlelbl.text = cellInfo?.title
        subTitlelbl.text = cellInfo?.subTitle
        langLogoImg.image = UIImage(named: cellInfo?.image ?? "")
        
        subTitlelbl.isHidden = true
        langLogoImg.isHidden = true
        
        if cellInfo?.key == "lang" {
            subTitlelbl.isHidden = true
            langLogoImg.isHidden = false
        }else {
            subTitlelbl.isHidden = false
            langLogoImg.isHidden = true
        }
    }
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 4)
        
        titlelbl.textColor = .LabelTitleColor
        titlelbl.font = UIFont.SigvarRegular(size: 16)
        
        subTitlelbl.textColor = .LabelTitleColor
        subTitlelbl.font = UIFont.SigvarRegular(size: 16)
        
    }
    
    
    
    func selected() {
        self.holderView.layer.borderColor = UIColor.ButtonColor.cgColor
    }
    
    
    func unselected() {
        self.holderView.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
}
