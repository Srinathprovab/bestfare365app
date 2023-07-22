//
//  CharityTVCell.swift
//  BestFares365App
//
//  Created by FCI on 09/11/22.
//

import UIKit

protocol CharityTVCellDelegate {
    func addCharityBtnAction(cell:CharityTVCell)
    func didTapOnMoreInformationBtnAction(cell:CharityTVCell)
    
}

class CharityTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var totalperBookinglbl: UILabel!
    @IBOutlet weak var totalPerBookingValurlbl: UILabel!
    @IBOutlet weak var addView: UIView!
    @IBOutlet weak var addlbl: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var moreInfoBtn: UIButton!
    
    
    var delegate:CharityTVCellDelegate?
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
        img.image = UIImage(named: cellInfo?.image ?? "")?.withRenderingMode(.alwaysOriginal)
        titlelbl.text = cellInfo?.title
        subtitlelbl.text = cellInfo?.subTitle
        totalPerBookingValurlbl.text = "\(defaults.string(forKey: UserDefaultsKeys.APICurrencyType) ?? "") 50"
        
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        setuplabels(lbl: titlelbl, text: "Get Flight Details Through SMS", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 16), align: .left)
        setuplabels(lbl: subtitlelbl, text: "Get Flight Details Through SMS", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14), align: .left)
        setuplabels(lbl: totalperBookinglbl, text: "Total per booking", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14), align: .left)
        setuplabels(lbl: totalPerBookingValurlbl, text: "", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 14), align: .left)
        addView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 15)
        addView.backgroundColor = .ButtonColor
        setuplabels(lbl: addlbl, text: "+ Add", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 14), align: .left)
        moreInfoBtn.setTitle("More Information", for: .normal)
        addBtn.addTarget(self, action: #selector(addCharityBtnAction(_:)), for: .touchUpInside)
        moreInfoBtn.addTarget(self, action: #selector(didTapOnMoreInformationBtnAction(_:)), for: .touchUpInside)
        
    }
    
    @objc func addCharityBtnAction(_ sender:UIButton) {
        delegate?.addCharityBtnAction(cell: self)
    }
    
    
    @objc func didTapOnMoreInformationBtnAction(_ sender:UIButton) {
        delegate?.didTapOnMoreInformationBtnAction(cell: self)
    }
}
