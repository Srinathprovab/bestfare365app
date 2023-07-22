//
//  RoomsButtonsTVCell.swift
//  BestFares365App
//
//  Created by FCI on 08/11/22.
//

import UIKit

protocol RoomsButtonsTVCellDelegate {
    func didTapOnHotelDetailsBtn(cell:RoomsButtonsTVCell)
    func didTapOnRoomBtn(cell:RoomsButtonsTVCell)
    func didTapOnAminitiesBtn(cell:RoomsButtonsTVCell)
    
}

class RoomsButtonsTVCell: TableViewCell {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var hotelDetailsBtnView: UIView!
    @IBOutlet weak var hotelDetailsBtnlbl: UILabel!
    @IBOutlet weak var hotelDetailsBtn: UIButton!
    @IBOutlet weak var RoomsBtnView: UIView!
    @IBOutlet weak var RoomsBtnlbl: UILabel!
    @IBOutlet weak var RoomsBtn: UIButton!
    @IBOutlet weak var aminitiesBtnView: UIView!
    @IBOutlet weak var aminitiesBtnlbl: UILabel!
    @IBOutlet weak var aminitiesBtn: UIButton!
    
    
    var delegate: RoomsButtonsTVCellDelegate?
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
        switch cellInfo?.key {
        case "room":
            tapOnRooms()
            break
            
        case "details":
            tapOnhotealDetails()
            break
            
            
        case "ameni":
            tapOnAminates()
            break
            
            
        default:
            break
        }
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .lightGray, borderColor: .clear, cornerRadius: 8)
        hotelDetailsBtnView.backgroundColor = .WhiteColor
        hotelDetailsBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 4)
        RoomsBtnView.backgroundColor = .WhiteColor
        RoomsBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 4)
        aminitiesBtnView.backgroundColor = .WhiteColor
        aminitiesBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 4)
        setuplabels(lbl: hotelDetailsBtnlbl, text: "Hotel Details", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 14), align: .center)
        setuplabels(lbl: RoomsBtnlbl, text: "Rooms", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 14), align: .center)
        setuplabels(lbl: aminitiesBtnlbl, text: "Aminities", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 14), align: .center)
        hotelDetailsBtn.addTarget(self, action: #selector(didTapOnHotelDetailsBtn(_:)), for: .touchUpInside)
        RoomsBtn.addTarget(self, action: #selector(didTapOnRoomBtn(_:)), for: .touchUpInside)
        aminitiesBtn.addTarget(self, action: #selector(didTapOnAminitiesBtn(_:)), for: .touchUpInside)
    }
    
    
    @objc func didTapOnHotelDetailsBtn(_ sender:UIButton){
        tapOnhotealDetails()
        delegate?.didTapOnHotelDetailsBtn(cell: self)
    }
    
    @objc func didTapOnRoomBtn(_ sender:UIButton){
        tapOnRooms()
        delegate?.didTapOnRoomBtn(cell: self)
    }
    
    @objc func didTapOnAminitiesBtn(_ sender:UIButton){
        tapOnAminates()
        delegate?.didTapOnAminitiesBtn(cell: self)
    }
    
    func tapOnhotealDetails() {
        hotelDetailsBtnView.backgroundColor = .CalSelectedColor
        RoomsBtnView.backgroundColor = .WhiteColor
        aminitiesBtnView.backgroundColor = .WhiteColor
        
        hotelDetailsBtnlbl.textColor = .WhiteColor
        RoomsBtnlbl.textColor = .LabelSubTitleColor
        aminitiesBtnlbl.textColor = .LabelSubTitleColor
        
    }
    
    func tapOnRooms() {
        hotelDetailsBtnView.backgroundColor = .WhiteColor
        RoomsBtnView.backgroundColor = .CalSelectedColor
        aminitiesBtnView.backgroundColor = .WhiteColor
        
        hotelDetailsBtnlbl.textColor = .LabelSubTitleColor
        RoomsBtnlbl.textColor = .WhiteColor
        aminitiesBtnlbl.textColor = .LabelSubTitleColor
    }
    
    func tapOnAminates() {
        hotelDetailsBtnView.backgroundColor = .WhiteColor
        RoomsBtnView.backgroundColor = .WhiteColor
        aminitiesBtnView.backgroundColor = .CalSelectedColor
        
        hotelDetailsBtnlbl.textColor = .LabelSubTitleColor
        RoomsBtnlbl.textColor = .LabelSubTitleColor
        aminitiesBtnlbl.textColor = .WhiteColor
    }
    
    
}
