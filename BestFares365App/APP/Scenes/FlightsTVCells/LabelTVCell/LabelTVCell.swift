//
//  LabelTVCell.swift
//  BestFares365App
//
//  Created by FCI on 28/10/22.
//

import UIKit

class LabelTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    
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
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        setupLabels(lbl: titlelbl, text: "", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 16))
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
}
