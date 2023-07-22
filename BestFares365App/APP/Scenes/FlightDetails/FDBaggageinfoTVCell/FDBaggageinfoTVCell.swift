//
//  FDBaggageinfoTVCell.swift
//  BestFares365App
//
//  Created by FCI on 14/03/23.
//

import UIKit

class FDBaggageinfoTVCell: UITableViewCell {

    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    
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
        setuplabels(lbl: titlelbl, text: "Cabin bag", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14), align: .left)
        setuplabels(lbl: subtitlelbl, text: "7 kg", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14), align: .right)
    }
    
}
