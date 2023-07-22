//
//  AboutUsLabelTVCell.swift
//  BestFares365App
//
//  Created by FCI on 10/03/23.
//

import UIKit

class AboutUsLabelTVCell: TableViewCell {

    
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
        titlelbl.attributedText = cellInfo?.title?.htmlToAttributedString
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
     //   holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 5)
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16), align: .left)
    }
    
}
