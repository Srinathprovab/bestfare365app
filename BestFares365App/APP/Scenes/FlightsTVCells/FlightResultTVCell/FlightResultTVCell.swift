//
//  FlightResultTVCell.swift
//  BestFares365App
//
//  Created by FCI on 28/10/22.
//

import UIKit
import SDWebImage

protocol FlightResultTVCellDelegate {
    func didTapOnShowFlightDetails(cell:FlightResultTVCell)
}

class FlightResultTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var airlinesLogoImg: UIImageView!
    @IBOutlet weak var airlinesNamelbl: UILabel!
    @IBOutlet weak var airlinesCodelbl: UILabel!
    @IBOutlet weak var seatsLeftlbl: UILabel!
    @IBOutlet weak var seatImg: UIImageView!
    @IBOutlet weak var fromTimelbl: UILabel!
    @IBOutlet weak var fromCodelbl: UILabel!
    @IBOutlet weak var toTimelbl: UILabel!
    @IBOutlet weak var toCodelbl: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var leftLineImg: UIImageView!
    @IBOutlet weak var rightLineImg: UIImageView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var pricelbl: UILabel!
    @IBOutlet weak var ul: UIView!
    @IBOutlet weak var economylbl: UILabel!
    @IBOutlet weak var showDetailslbl: UILabel!
    @IBOutlet weak var showDetailsBtn: UIButton!
    @IBOutlet weak var kglbl: UILabel!
    @IBOutlet weak var kgImg: UIImageView!
    @IBOutlet weak var travelTimelbl: UILabel!
    @IBOutlet weak var totalStopslbl: UILabel!
    
    
    var noofStops = String()
    var delegate:FlightResultTVCellDelegate?
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

        fromTimelbl.text = cellInfo?.fromTime
        toTimelbl.text = cellInfo?.toTime
        fromCodelbl.text = cellInfo?.fromCity
        toCodelbl.text = cellInfo?.toCity
        totalStopslbl.text = "\(cellInfo?.noosStops ?? "") Stops"
        //airlinesLogoImg.image = UIImage(named: "alogo")?.withRenderingMode(.alwaysOriginal)
        
        self.airlinesLogoImg.sd_setImage(with: URL(string: cellInfo?.airlineslogo ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        
        airlinesNamelbl.text = cellInfo?.airlinesname
        airlinesCodelbl.text = cellInfo?.airlinesCode
        seatsLeftlbl.text = "seat left:\(cellInfo?.seatsLeft ?? "0")"
        kglbl.text = cellInfo?.baggage
        pricelbl.text = cellInfo?.price
        travelTimelbl.text = cellInfo?.travelTime

        
        if cellInfo?.noosStops == "0" {
            img1.isHidden = true
            img2.isHidden = true
            img3.isHidden = true
        }else  if cellInfo?.noosStops == "1" {
            img1.isHidden = false
            img2.isHidden = true
            img3.isHidden = true
        }else {
            img1.isHidden = false
            img2.isHidden = false
            img3.isHidden = true
        }
    }
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        seatImg.image = UIImage(named: "seat")?.withRenderingMode(.alwaysOriginal)
        img1.image = UIImage(named: "round")?.withRenderingMode(.alwaysOriginal)
        img2.image = UIImage(named: "round")?.withRenderingMode(.alwaysOriginal)
        img3.image = UIImage(named: "round")?.withRenderingMode(.alwaysOriginal)
        kgImg.image = UIImage(named: "kg")?.withRenderingMode(.alwaysOriginal)
        img1.isHidden = true
        img2.isHidden = true
        img3.isHidden = true
        leftLineImg.image = UIImage(named: "dash")?.withRenderingMode(.alwaysOriginal)
        rightLineImg.image = UIImage(named: "dash")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: airlinesNamelbl, text: "indigo airlines", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 14))
        setupLabels(lbl: airlinesCodelbl, text: "(6E 189)", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 12))
        setupLabels(lbl: seatsLeftlbl, text: "seat left:6", textcolor: HexColor("#FF0000"), font: .ProximaNovaRegular(size: 14))
        setupLabels(lbl: fromTimelbl, text: "13:00", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 16))
        setupLabels(lbl: fromCodelbl, text: "DXB", textcolor: .LabelTitleColor, font: .SigvarRegular(size: 14))
        setupLabels(lbl: toTimelbl, text: "15:00", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 20))
        setupLabels(lbl: toCodelbl, text: "KWI", textcolor: .LabelTitleColor, font: .SigvarRegular(size: 14))
        setupLabels(lbl: pricelbl, text: "A$ 250", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 16))
        setupLabels(lbl: economylbl, text: "Economy", textcolor: HexColor("#003399"), font: .SigvarRegular(size: 16))
        setupLabels(lbl: showDetailslbl, text: "Show details", textcolor: HexColor("#009EE3"), font: .SigvarRegular(size: 16))
        setupLabels(lbl: kglbl, text: "1 x 0kg", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 12))
        setupLabels(lbl: travelTimelbl, text: "", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 14))
        setupLabels(lbl: totalStopslbl, text: "", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 14))

        priceView.backgroundColor = .ButtonColor
        ul.backgroundColor = HexColor("#DADADA")
        showDetailsBtn.setTitle("", for: .normal)
        showDetailsBtn.addTarget(self, action: #selector(didTapOnShowFlightDetails(_:)), for: .touchUpInside)
    
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    @objc func didTapOnShowFlightDetails(_ sender:UIButton) {
        delegate?.didTapOnShowFlightDetails(cell: self)
    }
    
}
