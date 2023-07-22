//
//  TDetailsTVCell.swift
//  BestFares365App
//
//  Created by FCI on 09/11/22.
//

import UIKit

class TDetailsTVCell: UITableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var checkinTitlelbl: UILabel!
    @IBOutlet weak var checkInValuelbl: UILabel!
    @IBOutlet weak var nightsTitlelbl: UILabel!
    @IBOutlet weak var nightsValuelbl: UILabel!
    @IBOutlet weak var checkoutTitlelbl: UILabel!
    @IBOutlet weak var checkoutValuelbl: UILabel!
    
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
        checkinTitlelbl.isHidden = true
        checkoutTitlelbl.isHidden = true
        nightsTitlelbl.isHidden = true
        
        setuplabels(lbl: checkinTitlelbl, text: "Check - In", textcolor: .LabelSubTitleColor, font: .ProximaNovaRegular(size: 12), align: .center)
        setuplabels(lbl: checkoutTitlelbl, text: "Check -Out", textcolor: .LabelSubTitleColor, font: .ProximaNovaRegular(size: 12), align: .center)
        setuplabels(lbl: nightsTitlelbl, text: "Nights", textcolor: .LabelSubTitleColor, font: .ProximaNovaRegular(size: 12), align: .center)
        
        setuplabels(lbl: checkInValuelbl, text: "15 oct,222", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 20), align: .center)
        setuplabels(lbl: checkoutValuelbl, text: "15 oct,222", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 20), align: .center)
        setuplabels(lbl: nightsValuelbl, text: "1 Night", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 20), align: .center)
        
    }
    
    
    func show() {
        checkinTitlelbl.isHidden = false
        checkoutTitlelbl.isHidden = false
        nightsTitlelbl.isHidden = false
    }
    
    
}
