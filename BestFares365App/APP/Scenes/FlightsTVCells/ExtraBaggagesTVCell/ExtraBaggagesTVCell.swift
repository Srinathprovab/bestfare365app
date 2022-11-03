//
//  ExtraBaggagesTVCell.swift
//  BestFares365App
//
//  Created by FCI on 31/10/22.
//

import UIKit

protocol ExtraBaggagesTVCellDelegate {
    func didTapOnSelectPassengerBtn(cell:ExtraBaggagesTVCell)
}

class ExtraBaggagesTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var selectPassengerView: UIView!
    @IBOutlet weak var selectPassengerlbl: UILabel!
    @IBOutlet weak var dropdownImg: UIImageView!
    @IBOutlet weak var selectPassengerBtn: UIButton!
    
    
    var delegate:ExtraBaggagesTVCellDelegate?
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
        selectPassengerView.backgroundColor = .WhiteColor
        selectPassengerView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        logoImg.image = UIImage(named: "checkin")?.withRenderingMode(.alwaysOriginal)
        dropdownImg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.LabelTitleColor)
        setuplabels(lbl: titlelbl, text: "Purchase your Extra Baggages", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 16), align: .left)
        setuplabels(lbl: selectPassengerlbl, text: "Select the Passenger", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 14), align: .left)
        
        selectPassengerBtn.addTarget(self, action: #selector(didTapOnSelectPassengerBtn(_:)), for: .touchUpInside)
    }
    
    
    @objc func didTapOnSelectPassengerBtn(_ sender:UIButton) {
        delegate?.didTapOnSelectPassengerBtn(cell: self)
    }
    
}
