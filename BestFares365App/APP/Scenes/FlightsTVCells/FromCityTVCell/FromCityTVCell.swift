//
//  FromCityTVCell.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit

class FromCityTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var logoimg: UIImageView!
    @IBOutlet weak var closeimg: UIImageView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var closeView: UIView!
    
    
    var airportCode = String()
    var cityName = String()
    var cityShortName = String()
    var id = String()
    var value = String()
    
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
        
    }
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        setupLabels(lbl: titlelbl, text: "", textcolor: .LabelTitleColor, font: .SigvarRegular(size: 16))
        setupLabels(lbl: subTitlelbl, text: "", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 14))
        logoimg.image = UIImage(named: "from")?.withRenderingMode(.alwaysOriginal)
        closeimg.image = UIImage(named: "close")?.withRenderingMode(.alwaysOriginal)
        closeView.isHidden = true
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    
    //    func setAttributedString(str1:String,str2:String) {
    //
    //
    //        let atter1 = [NSAttributedString.Key.foregroundColor:HexColor("#3E3E3E"),NSAttributedString.Key.font:UIFont.poppinsRegular(size: 15)] as [NSAttributedString.Key : Any]
    //        let atter2 = [NSAttributedString.Key.foregroundColor:UIColor.LabelTitleColor,NSAttributedString.Key.font:UIFont.poppinsMedium(size: 15)] as [NSAttributedString.Key : Any]
    //
    //        let atterStr1 = NSMutableAttributedString(string: str1, attributes: atter1)
    //        let atterStr2 = NSMutableAttributedString(string: str2, attributes: atter2)
    //
    //
    //        let combination = NSMutableAttributedString()
    //        combination.append(atterStr1)
    //        combination.append(atterStr2)
    //
    //        titlelbl.attributedText = combination
    //    }
}
