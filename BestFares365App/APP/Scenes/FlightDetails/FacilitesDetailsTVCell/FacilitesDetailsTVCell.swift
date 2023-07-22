//
//  FacilitesDetailsTVCell.swift
//  BestFares365App
//
//  Created by FCI on 14/03/23.
//

import UIKit

class FacilitesDetailsTVCell: UITableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var f1lbl: UILabel!
    @IBOutlet weak var f2lbl: UILabel!
    @IBOutlet weak var f3lbl: UILabel!
    @IBOutlet weak var f4lbl: UILabel!
    
    
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
        setuplabels(lbl: titlelbl, text: "DXB - KWI", textcolor: HexColor("#003399"), font: .ProximaNovaBold(size: 16), align: .left)
        setuplabels(lbl: f1lbl, text: "Meal Provided", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14), align: .left)
        setuplabels(lbl: f2lbl, text: "Boeing 737 MAX 8", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14), align: .left)
        setuplabels(lbl: f3lbl, text: "79 cm Seat Pitch", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14), align: .left)
        setuplabels(lbl: f4lbl, text: "Power and usd outlet", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14), align: .left)

    }
    
    
    
}
