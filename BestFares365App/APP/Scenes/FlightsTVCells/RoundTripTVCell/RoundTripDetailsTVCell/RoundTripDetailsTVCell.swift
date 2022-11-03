//
//  RoundTripDetailsTVCell.swift
//  BestFares365App
//
//  Created by FCI on 02/11/22.
//

import UIKit

class RoundTripDetailsTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fromTimelbl: UILabel!
    @IBOutlet weak var fromCodelbl: UILabel!
    @IBOutlet weak var toTimelbl: UILabel!
    @IBOutlet weak var toCodelbl: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!
    @IBOutlet weak var leftLineImg: UIImageView!
    @IBOutlet weak var rightLineImg: UIImageView!
    @IBOutlet weak var travelTimelbl: UILabel!
    @IBOutlet weak var totalStopslbl: UILabel!
    @IBOutlet weak var kglbl: UILabel!
    @IBOutlet weak var kgImg: UIImageView!




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
        img1.image = UIImage(named: "round")?.withRenderingMode(.alwaysOriginal)
        img2.image = UIImage(named: "round")?.withRenderingMode(.alwaysOriginal)
        img3.image = UIImage(named: "round")?.withRenderingMode(.alwaysOriginal)
        img1.isHidden = false
        img2.isHidden = true
        img3.isHidden = true
        leftLineImg.image = UIImage(named: "dash")?.withRenderingMode(.alwaysOriginal)
        rightLineImg.image = UIImage(named: "dash")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: fromTimelbl, text: "13:00", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 16))
        setupLabels(lbl: fromCodelbl, text: "DXB", textcolor: .LabelTitleColor, font: .SigvarRegular(size: 14))
        setupLabels(lbl: toTimelbl, text: "15:00", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 20))
        setupLabels(lbl: toCodelbl, text: "KWI", textcolor: .LabelTitleColor, font: .SigvarRegular(size: 14))
        setupLabels(lbl: travelTimelbl, text: "", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 14))
        setupLabels(lbl: totalStopslbl, text: "", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 14))
        kgImg.image = UIImage(named: "kg")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: kglbl, text: "1 x 0kg", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 12))
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
}
