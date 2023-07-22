//
//  HotelResultTVCell.swift
//  BestFares365App
//
//  Created by FCI on 07/11/22.
//

import UIKit
import SDWebImage

class HotelResultTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var hImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var loclbl: UILabel!
    @IBOutlet weak var locImg: UIImageView!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var ratinglbl: UILabel!
    @IBOutlet weak var ratingTitlelbl: UILabel!
    @IBOutlet weak var ratingNoOfReviewlbl: UILabel!
    @IBOutlet weak var roomsLeftlbl: UILabel!
    @IBOutlet weak var perNightlbl: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var refundlbl: UILabel!
    @IBOutlet weak var locImgWidth: NSLayoutConstraint!
    @IBOutlet weak var freeWifilbl: UILabel!
    @IBOutlet weak var hImgWidth: NSLayoutConstraint!
    
    
    
    var hoteladdress = String()
    var hotelPrice = String()
    var selectedHotelImg = String()
    var hotelCode = String()
    var rateclass = String()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func updateUI() {
        
       
        
        setupUI()
        hImg.sd_setImage(with: URL(string: cellInfo?.hotelImg ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        hotelCode = cellInfo?.hotelCode ?? ""
        selectedHotelImg = cellInfo?.hotelImg ?? ""
        
        rateclass = cellInfo?.title ?? ""
        if cellInfo?.title == "NRF" {
            setuplabels(lbl: freeWifilbl, text: "Non-Refundable", textcolor: .red, font: .ProximaNovaRegular(size: 14), align: .center)

        }else {
            setuplabels(lbl: freeWifilbl, text: "Refundable", textcolor: HexColor("#2FA804"), font: .ProximaNovaRegular(size: 14), align: .center)

        }
        
        
        hoteladdress = cellInfo?.hotelAddress ?? ""
        hotelPrice = cellInfo?.hotelPrice ?? ""
        
        
        
        if cellInfo?.key == "details" {
            hImg.sd_setImage(with: URL(string: hoteldetails?.imagePath ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            titlelbl.text = hotel_details?.hotel_name ?? ""
            loclbl.text = hotel_details?.address ?? ""
            ratingView.isHidden = true
            roomsLeftlbl.isHidden = true
        }
        
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        
        setuplabels(lbl: titlelbl, text: cellInfo?.hotelName ?? "", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 18), align: .left)
        setuplabels(lbl: loclbl, text: cellInfo?.hotelAddress ?? "", textcolor: HexColor("#009EE3"), font: .SigvarRegular(size: 12), align: .left)
        setuplabels(lbl: ratinglbl, text: cellInfo?.hotelratings ?? "", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 12), align: .center)
        setuplabels(lbl: ratingTitlelbl, text: "Excellent", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 12), align: .left)
        setuplabels(lbl: ratingNoOfReviewlbl, text: "(1 review)", textcolor: .LabelSubTitleColor, font: .ProximaNovaRegular(size: 12), align: .left)
        setuplabels(lbl: roomsLeftlbl, text: "Only \(cellInfo?.roomsLeft ?? "") rooms", textcolor: HexColor("#FF0000"), font: .ProximaNovaRegular(size: 14), align: .left)
        setuplabels(lbl: perNightlbl, text: "Per Night", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 12), align: .left)
        setuplabels(lbl: pricelbl, text: cellInfo?.hotelPrice ?? "", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 16), align: .center)
        
        setuplabels(lbl: freeWifilbl, text: "Free wifi", textcolor: .LabelSubTitleColor, font: .ProximaNovaBold(size: 12), align: .left)

        setuplabels(lbl: freeWifilbl, text: "Refundable", textcolor: HexColor("#2FA804"), font: .ProximaNovaRegular(size: 14), align: .center)


        locImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal)
        ratingView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 15)
        ratingView.backgroundColor = HexColor("#FFD751")
        priceView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 4)
        priceView.backgroundColor = .ButtonColor
        refundlbl.isHidden = true
        
        locImg.isHidden = false
        locImgWidth.constant = 14
        
        
    }
    
}
