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
    
    var airportcity = String()
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
        setuplabels(lbl: titlelbl, text: "", textcolor: .AppLabelColor, font: .SigvarRegular(size: 16), align: .left)
        setuplabels(lbl: subTitlelbl, text: "", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 14), align: .left)
        logoimg.image = UIImage(named: "from")?.withRenderingMode(.alwaysOriginal)
        closeimg.image = UIImage(named: "close")?.withRenderingMode(.alwaysOriginal)
        closeView.isHidden = true
    }
    
}
