//
//  BaggageInfoTVCell.swift
//  BestFares365App
//
//  Created by FCI on 31/10/22.
//

import UIKit

class BaggageInfoTVCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var ul: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var baggageImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func setupUI(){
        holderView.backgroundColor = .WhiteColor
        ul.backgroundColor = .BorderColor
        setupLabels(lbl: titlelbl, text: "Cabin bag", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14))
        setupLabels(lbl: subtitlelbl, text: "7 kg", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14))
        baggageImg.image = UIImage(named: "baggage")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    
    
    
}
