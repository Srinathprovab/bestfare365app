//
//  PriceFilterTVCell.swift
//  BestFares365App
//
//  Created by FCI on 30/10/22.
//

import UIKit
import TTRangeSlider

protocol PriceFilterTVCellDelegate {
    func didTapOnShowSliderBtn(cell:PriceFilterTVCell)
}
class PriceFilterTVCell: TableViewCell, TTRangeSliderDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var minPricelbl: UILabel!
    @IBOutlet weak var rangeSlider: TTRangeSlider!
    @IBOutlet weak var dropdownImg: UIImageView!
    @IBOutlet weak var maxPricelbl: UILabel!
    
    
    var key = String()
    var minValue1 = Double()
    var maxValue1 = Double()
    var showbool = true
    var delegate:PriceFilterTVCellDelegate?
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
        titlelbl.text = cellInfo?.title
        //minPricelbl.text = cellInfo?.subTitle
    }
    
    
    func setupUI() {
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#DADADA"), cornerRadius: 6)
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: titlelbl, text: "Price", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 16), align: .left)
        setuplabels(lbl: minPricelbl, text: "", textcolor: .AppLabelColor, font: .SigvarRegular(size: 16), align: .right)
        setuplabels(lbl: minPricelbl, text: "", textcolor: .AppLabelColor, font: .SigvarRegular(size: 16), align: .left)
        dropdownImg.image = UIImage(named: "downarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        setupRangeSlider()
    }
    
    func setupRangeSlider() {
        
        
        let pricesFloat = prices.compactMap { Float($0) }
        let minValue = pricesFloat.min() ?? 0.0
        let maxValue = pricesFloat.max() ?? 0.0
        rangeSlider.minValue = minValue
        rangeSlider.maxValue = maxValue
        minValue1 = Double(minValue)
        maxValue1 = Double(maxValue)
        minPricelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")\(minValue)"
        maxPricelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")\(maxValue)"
        
        // Set the thumbs to the minimum and maximum values
        rangeSlider.selectedMinimum = minValue
        rangeSlider.selectedMaximum = maxValue
        
        rangeSlider.delegate = self
        rangeSlider.backgroundColor = .WhiteColor
        rangeSlider.handleType = .rectangle
        rangeSlider.lineHeight = 5
        rangeSlider.tintColor = .BtnUnselectedColor
        rangeSlider.tintColorBetweenHandles = .CalSelectedColor
        rangeSlider.lineBorderColor = HexColor("#E7E7E7")
        rangeSlider.handleDiameter = 30.0
        rangeSlider.hideLabels = true
        rangeSlider.handleColor = HexColor("#009DEA")
        rangeSlider.handleImage = UIImage(named: "handel")?.withRenderingMode(.alwaysOriginal)
    }
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    func rangeSlider(_ sender: TTRangeSlider!, didChangeSelectedMinimumValue selectedMinimum: Float, andMaximumValue selectedMaximum: Float) {
        let minLabelText = String(format: "%.1f", selectedMinimum)
        let maxLabelText = String(format: "%.1f", selectedMaximum)
        
        minValue1 = Double(minLabelText) ?? 0.0
        maxValue1 = Double(maxLabelText) ?? 0.0
        
        minPricelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")\(minLabelText)"
        maxPricelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")\(maxLabelText)"
        
        delegate?.didTapOnShowSliderBtn(cell: self)
    }
    
}
