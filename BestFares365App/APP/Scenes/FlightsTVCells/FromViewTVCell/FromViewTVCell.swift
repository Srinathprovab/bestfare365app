//
//  FromViewTVCell.swift
//  BestFares365App
//
//  Created by FCI on 27/10/22.
//

import UIKit
protocol FromViewTVCellDelegate {
    func selectFromCityBtnAction(cell:FromViewTVCell)
    func selectToCityBtnAction(cell:FromViewTVCell)
}

class FromViewTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fromlbl: UILabel!
    @IBOutlet weak var fromCityView: UIView!
    @IBOutlet weak var fromimg: UIImageView!
    @IBOutlet weak var fromCityNamelbl: UILabel!
    @IBOutlet weak var fromAirportNamelbl: UILabel!
    @IBOutlet weak var tolbl: UILabel!
    @IBOutlet weak var toCityView: UIView!
    @IBOutlet weak var toimg: UIImageView!
    @IBOutlet weak var toCityNamelbl: UILabel!
    @IBOutlet weak var toAirportNamelbl: UILabel!
    @IBOutlet weak var swapimg: UIImageView!
    @IBOutlet weak var swapCityBtn: UIButton!
    @IBOutlet weak var fromBtn: UIButton!
    @IBOutlet weak var toBtn: UIButton!
    
    var delegate:FromViewTVCellDelegate?
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
        
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            switch journyType {
            case "oneway":
                fromCityNamelbl.text = defaults.string(forKey: UserDefaultsKeys.fromCity) ?? "Select"
                fromAirportNamelbl.text = defaults.string(forKey: UserDefaultsKeys.fromairportCode) ?? "City"
                toCityNamelbl.text = defaults.string(forKey: UserDefaultsKeys.toCity) ?? "Select"
                toAirportNamelbl.text = defaults.string(forKey: UserDefaultsKeys.toairportCode) ?? "City"
                break
            case "circle":
                fromCityNamelbl.text = defaults.string(forKey: UserDefaultsKeys.rfromCity) ?? "Select"
                fromAirportNamelbl.text = defaults.string(forKey: UserDefaultsKeys.rfromairportCode) ?? "City"
                toCityNamelbl.text = defaults.string(forKey: UserDefaultsKeys.rtoCity) ?? "Select"
                toAirportNamelbl.text = defaults.string(forKey: UserDefaultsKeys.rtoairportCode) ?? "City"
                break
            case "multicity":
                fromCityNamelbl.text = defaults.string(forKey: UserDefaultsKeys.mfromCity) ?? "Select"
                fromAirportNamelbl.text = defaults.string(forKey: UserDefaultsKeys.mfromairportCode) ?? "City"
                toCityNamelbl.text = defaults.string(forKey: UserDefaultsKeys.mtoCity) ?? "Select"
                toAirportNamelbl.text = defaults.string(forKey: UserDefaultsKeys.mtoairportCode) ?? "City"
                break
            default:
                break
            }
        }
    }
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        setupLabels(lbl: fromlbl, text: "From", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16))
        fromCityView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        fromCityView.backgroundColor = .WhiteColor
        fromimg.image = UIImage(named: "from")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: fromCityNamelbl, text: "Dubai", textcolor: .AppLabelColor, font: .SigvarRegular(size: 18))
        setupLabels(lbl: fromAirportNamelbl, text: "Airports Dubai International (DXB)", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 14))
        
        setupLabels(lbl: tolbl, text: "To", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16))
        toCityView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        toCityView.backgroundColor = .WhiteColor
        toimg.image = UIImage(named: "to")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: toCityNamelbl, text: "Kuwait", textcolor: .AppLabelColor, font: .SigvarRegular(size: 18))
        setupLabels(lbl: toAirportNamelbl, text: "Kuwait International Airport (KWI)", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 14))
        
        swapimg.image = UIImage(named: "swap")?.withRenderingMode(.alwaysOriginal)
        swapCityBtn.setTitle("", for: .normal)
        fromBtn.setTitle("", for: .normal)
        toBtn.setTitle("", for: .normal)
        swapCityBtn.addTarget(self, action: #selector(didTapOnSwapCityBtn(_:)), for: .touchUpInside)
        fromBtn.addTarget(self, action: #selector(selectFromCityBtnAction(_:)), for: .touchUpInside)
        toBtn.addTarget(self, action: #selector(selectToCityBtnAction(_:)), for: .touchUpInside)
        
    }
    
    //MARK: - SETUP UI LABELS
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    //MARK: - SWAP CITY FROM TO TOCITY FUNCTION
    @objc func didTapOnSwapCityBtn(_ sender:UIButton) {
        let a = fromCityNamelbl.text
        let b = fromAirportNamelbl.text
        let x = toCityNamelbl.text
        let y = toAirportNamelbl.text
        
        fromCityNamelbl.text = x
        fromAirportNamelbl.text = y
        toCityNamelbl.text = a
        toAirportNamelbl.text = b
        
       
        
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            switch journyType {
            case "oneway":
                defaults.set(self.fromCityNamelbl.text ?? "", forKey: UserDefaultsKeys.fromCity)
                defaults.set(self.fromAirportNamelbl.text , forKey: UserDefaultsKeys.fromairportCode)
                defaults.set(toCityNamelbl.text ?? "", forKey: UserDefaultsKeys.toCity)
                defaults.set(toAirportNamelbl.text , forKey: UserDefaultsKeys.toairportCode)

                let i = defaults.string(forKey: UserDefaultsKeys.fromairport_city)
                let j = defaults.string(forKey: UserDefaultsKeys.toairport_city)
                defaults.set(i, forKey: UserDefaultsKeys.toairport_city)
                defaults.set(j, forKey: UserDefaultsKeys.fromairport_city)
                
                break
            case "circle":
                defaults.set(self.fromCityNamelbl.text ?? "", forKey: UserDefaultsKeys.rfromCity)
                defaults.set(self.fromAirportNamelbl.text , forKey: UserDefaultsKeys.rfromairportCode)
                defaults.set(toCityNamelbl.text ?? "", forKey: UserDefaultsKeys.rtoCity)
                defaults.set(toAirportNamelbl.text , forKey: UserDefaultsKeys.rtoairportCode)
                break
            case "multicity":
                defaults.set(self.fromCityNamelbl.text ?? "", forKey: UserDefaultsKeys.mfromCity)
                defaults.set(self.fromAirportNamelbl.text , forKey: UserDefaultsKeys.mfromairportCode)
                defaults.set(toCityNamelbl.text ?? "", forKey: UserDefaultsKeys.mtoCity)
                defaults.set(toAirportNamelbl.text , forKey: UserDefaultsKeys.mtoairportCode)
                break
            default:
                break
            }
        }
    }
    
    
    @objc func selectFromCityBtnAction(_ sender:UIButton){
        delegate?.selectFromCityBtnAction(cell: self)
    }
    
    @objc func selectToCityBtnAction(_ sender:UIButton){
        delegate?.selectToCityBtnAction(cell: self)
    }
    
}
