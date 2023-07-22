//
//  RoomTVCell.swift
//  BestFares365App
//
//  Created by FCI on 16/03/23.
//

import UIKit

protocol RoomTVCellDelegate {
    func didTapOnCancellationPolicyBtn(cell:RoomTVCell)
}

class RoomTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var radioImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var noofAdultslbl: UILabel!
    @IBOutlet weak var cancellationPolocyBtn: UIButton!
    @IBOutlet weak var roomsLeftlbl: UILabel!
    @IBOutlet weak var perNeightlbl: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var pricelbl: UILabel!
    
    var rateKey = String()
    var delegate:RoomTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        if selected {
            selected1()
        }else {
            unselected()
        }
    }
    
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
        noofAdultslbl.text = cellInfo?.subTitle
        roomsLeftlbl.text = cellInfo?.buttonTitle
        pricelbl.text = cellInfo?.text
        rateKey = cellInfo?.headerText ?? ""
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 6)
        radioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 18), align: .left)
        setuplabels(lbl: noofAdultslbl, text: "", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 12), align: .left)
        cancellationPolocyBtn.setTitle("Cancellation Policy", for: .normal)
        cancellationPolocyBtn.setTitleColor(.ButtonColor, for: .normal)
        setuplabels(lbl: roomsLeftlbl, text: "", textcolor: HexColor("#FF0000"), font: .ProximaNovaRegular(size: 14), align: .left)
        setuplabels(lbl: perNeightlbl, text: "Per Night", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 12), align: .center)
        priceView.backgroundColor = .ButtonColor
        priceView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 3)
        setuplabels(lbl: pricelbl, text: "", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 18), align: .center)
        cancellationPolocyBtn.titleLabel?.font = .ProximaNovaRegular(size: 14)
    }
    
    func selected1() {
        radioImg.image = UIImage(named: "radioSelected")?.withRenderingMode(.alwaysOriginal).withTintColor(.ButtonColor)
    }
    
    func unselected() {
        radioImg.image = UIImage(named: "radioUnselected")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    
    
    
    
    @IBAction func didTapOnCancellationPolicyBtn(_ sender: Any) {
        delegate?.didTapOnCancellationPolicyBtn(cell: self)
    }
    
    
    
}
