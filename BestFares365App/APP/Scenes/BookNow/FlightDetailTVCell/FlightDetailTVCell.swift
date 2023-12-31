//
//  FlightDetailTVCell.swift
//  BestFares365App
//
//  Created by FCI on 31/10/22.
//

import UIKit

class FlightDetailTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var airlinesLogoImg1: UIImageView!
    @IBOutlet weak var airlinesNamelbl1: UILabel!
    @IBOutlet weak var fromTimelbl1: UILabel!
    @IBOutlet weak var fromCitylbl1: UILabel!
    @IBOutlet weak var fromDatelbl1: UILabel!
    @IBOutlet weak var fromAirportNamelbl1: UILabel!
    @IBOutlet weak var fromTerminallbl1: UILabel!
    @IBOutlet weak var toTimelbl1: UILabel!
    @IBOutlet weak var toCitylbl1: UILabel!
    @IBOutlet weak var toDatelbl1: UILabel!
    @IBOutlet weak var toAirportNamelbl1: UILabel!
    @IBOutlet weak var toTerminallbl1: UILabel!
    @IBOutlet weak var hourslbl1: UILabel!
    @IBOutlet weak var hourimg1: UIImageView!
    @IBOutlet weak var stopoverView: UIView!
    @IBOutlet weak var stopoverTimelbl: UILabel!
    @IBOutlet weak var stopoverCitylbl: UILabel!
    
    
    
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
        stopoverView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 15)
        stopoverView.backgroundColor = HexColor("#FFD751")
        
        airlinesLogoImg1.image = UIImage(named: "alogo")?.withRenderingMode(.alwaysOriginal)
        hourimg1.image = UIImage(named: "clk")?.withRenderingMode(.alwaysOriginal)
        
        setuplabels(lbl: airlinesNamelbl1, text: "indigo airlines (6E 189)", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14), align: .left)
        setuplabels(lbl: fromTimelbl1, text: "13:00", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 20), align: .left)
        setuplabels(lbl: fromCitylbl1, text: "DXB", textcolor: .AppLabelColor, font: .SigvarRegular(size: 14), align: .left)
        setuplabels(lbl: fromDatelbl1, text: "web 9 Dec", textcolor: .LabelSubTitleColor, font: .ProximaNovaRegular(size: 12), align: .left)
        setuplabels(lbl: fromAirportNamelbl1, text: "dubai internations airport", textcolor: .LabelSubTitleColor, font: .ProximaNovaRegular(size: 12), align: .left)
        setuplabels(lbl: fromTerminallbl1, text: "Terminal:2", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 12), align: .left)
        setuplabels(lbl: toTimelbl1, text: "13:00", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 20), align: .right)
        setuplabels(lbl: toCitylbl1, text: "DXB", textcolor: .AppLabelColor, font: .SigvarRegular(size: 14), align: .right)
        setuplabels(lbl: toDatelbl1, text: "web 9 Dec", textcolor: .LabelSubTitleColor, font: .ProximaNovaRegular(size: 12), align: .right)
        setuplabels(lbl: toAirportNamelbl1, text: "dubai internations airport", textcolor: .LabelSubTitleColor, font: .ProximaNovaRegular(size: 12), align: .right)
        setuplabels(lbl: toTerminallbl1, text: "Terminal:2", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 12), align: .right)
        setuplabels(lbl: hourslbl1, text: "01h 20min", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16), align: .left)
        
        setuplabels(lbl: stopoverCitylbl, text: "(BAH) Bahrain", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 12), align: .left)
        setuplabels(lbl: stopoverTimelbl, text: "Stopover; 02h10min", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 12), align: .left)
        
        
    }
    
    
    
    
}
