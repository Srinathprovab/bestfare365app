//
//  MulticityFromTVCell.swift
//  BestFares365App
//
//  Created by FCI on 02/11/22.
//

import UIKit

protocol MulticityFromTVCellDelegate {
    func didTapOnFromCityBtn(cell: MulticityFromTVCell)
    func didTapOnToCityBtn(cell: MulticityFromTVCell)
    func didTapOnDateBtn(cell: MulticityFromTVCell)
    func didTapOnDeleteCityBtn(cell: MulticityFromTVCell)
    
}

class MulticityFromTVCell: UITableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var fromlbl: UILabel!
    @IBOutlet weak var tolbl: UILabel!
    @IBOutlet weak var datelbl: UILabel!
    @IBOutlet weak var fromView: UIView!
    @IBOutlet weak var fromCityCodelbl: UILabel!
    @IBOutlet weak var fromCityNamelbl: UILabel!
    @IBOutlet weak var selectFromCityBtn: UIButton!
    @IBOutlet weak var planeImg: UIImageView!
    @IBOutlet weak var toView: UIView!
    @IBOutlet weak var toCityCodelbl: UILabel!
    @IBOutlet weak var toCityNamelbl: UILabel!
    @IBOutlet weak var selectToCityBtn: UIButton!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var dateValuelbl: UILabel!
    @IBOutlet weak var selectDateBtn: UIButton!
    @IBOutlet weak var deleteView: UIView!
    @IBOutlet weak var deleteImg: UIImageView!
    @IBOutlet weak var deleteBtn: UIButton!
    @IBOutlet weak var fromCityBtn: UIButton!
    @IBOutlet weak var toCityBtn: UIButton!
    
    
    var delegate:MulticityFromTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    override func prepareForReuse() {
        deleteView.isHidden = true
        fromlbl.isHidden = false
        tolbl.isHidden = false
        datelbl.isHidden = false
        
    }
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        setuplabels(lbl: fromlbl, text: "From", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16), align: .left)
        setuplabels(lbl: tolbl, text: "To", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16), align: .left)
        setuplabels(lbl: datelbl, text: "Date", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16), align: .left)
        setuplabels(lbl: fromCityCodelbl, text: "DXB", textcolor: .AppLabelColor, font: .SigvarRegular(size: 18), align: .left)
        setuplabels(lbl: toCityCodelbl, text: "KWI", textcolor: .AppLabelColor, font: .SigvarRegular(size: 18), align: .left)
        setuplabels(lbl: dateValuelbl, text: "23-11-2022", textcolor: .AppLabelColor, font: .SigvarRegular(size: 18), align: .left)
        setuplabels(lbl: fromCityNamelbl, text: "Dubhi", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 14), align: .left)
        setuplabels(lbl: toCityNamelbl, text: "kuwait ", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 14), align: .left)
        
        fromView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        fromView.backgroundColor = .WhiteColor
        toView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        toView.backgroundColor = .WhiteColor
        dateView.backgroundColor = .WhiteColor
        deleteView.backgroundColor = .WhiteColor
        deleteImg.image = UIImage(named:"delete")?.withRenderingMode(.alwaysOriginal)
        planeImg.image = UIImage(named:"plane")?.withRenderingMode(.alwaysOriginal)
        deleteView.isHidden = true
        
        
        fromCityBtn.addTarget(self, action: #selector(didTapOnFromCityBtn(_:)), for: .touchUpInside)
        toCityBtn.addTarget(self, action: #selector(didTapOnToCityBtn(_:)), for: .touchUpInside)
        selectDateBtn.addTarget(self, action: #selector(didTapOnDateBtn(_:)), for: .touchUpInside)
        deleteBtn.addTarget(self, action: #selector(didTapOnDeleteCityBtn(_:)), for: .touchUpInside)
        
    }
    
    
    
    @objc func didTapOnFromCityBtn(_ sender:UIButton) {
        delegate?.didTapOnFromCityBtn(cell: self)
    }
    
    
    @objc func didTapOnToCityBtn(_ sender:UIButton){
        delegate?.didTapOnToCityBtn(cell: self)
    }
    
    @objc func didTapOnDateBtn(_ sender:UIButton){
        delegate?.didTapOnDateBtn(cell: self)
    }
    
    @objc func didTapOnDeleteCityBtn(_ sender:UIButton) {
        delegate?.didTapOnDeleteCityBtn(cell: self)
    }
    
}
