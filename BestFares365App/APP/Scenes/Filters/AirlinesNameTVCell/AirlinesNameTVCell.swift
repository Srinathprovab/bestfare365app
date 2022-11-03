//
//  AirlinesNameTVCell.swift
//  BestFares365App
//
//  Created by FCI on 30/10/22.
//

import UIKit

class AirlinesNameTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var chechBoxImg: UIImageView!
    @IBOutlet weak var airlinesLogo: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var logoImgWidth: NSLayoutConstraint!
    
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
        holderView.backgroundColor = .WhiteColor
        chechBoxImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
        airlinesLogo.image = UIImage(named: "alogo")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: titlelbl, text: "", textcolor: HexColor("#27272A"), font: .ProximaNovaRegular(size: 16))
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    func selected() {
        chechBoxImg.image = UIImage(named: "check")?.withRenderingMode(.alwaysOriginal)
    }
    
    func unselected() {
        chechBoxImg.image = UIImage(named: "uncheck")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    func hideLogoImage() {
        logoImgWidth.constant = 0
    }
    
}
