//
//  CheckinBaggageTVCell.swift
//  BestFares365App
//
//  Created by FCI on 31/10/22.
//

import UIKit

class CheckinBaggageTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var ul: UIView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var cityCodelbl: UILabel!
    @IBOutlet weak var baggageImg: UIImageView!
    @IBOutlet weak var baggagelbl: UILabel!
    @IBOutlet weak var checkinImg: UIImageView!
    
    
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
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        ul.backgroundColor = .BorderColor
        logoImg.image = UIImage(named: "alogo")?.withRenderingMode(.alwaysOriginal)
        baggageImg.image = UIImage(named: "baggage")?.withRenderingMode(.alwaysOriginal)
        checkinImg.image = UIImage(named: "checkin")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: titlelbl, text: "Checkin baggage included free", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 16), align: .left)
        setuplabels(lbl: cityCodelbl, text: "DXB - KWI", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 20), align: .left)
        setuplabels(lbl: baggagelbl, text: "includes 30 kg of checkin baggage free", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 12), align: .left)
        
        
        
        
    }
    
}
