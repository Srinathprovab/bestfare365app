//
//  BarefareTVCell.swift
//  BestFares365App
//
//  Created by FCI on 01/11/22.
//

import UIKit

class BarefareTVCell: UITableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var adtlbl: UILabel!
    @IBOutlet weak var ul: UIView!

    
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
        setuplabels(lbl: titlelbl, text: "Bare fare", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 16), align: .left)
        setuplabels(lbl: subtitlelbl, text: "A$250", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 16), align: .right)
        
        setuplabels(lbl: adtlbl, text: "1 adt(s) (1xA$50.00", textcolor: .LabelSubTitleColor, font: .ProximaNovaRegular(size: 16), align: .left)
        ul.backgroundColor = .BorderColor
    }
    
}
