//
//  AddAdultsTVCell.swift
//  BestFares365App
//
//  Created by FCI on 28/10/22.
//

import UIKit

protocol AddAdultsTVCellDelegate {
    func didTapOnIncrementBtn(cell:AddAdultsTVCell)
    func didTapOnDecrementBtn(cell:AddAdultsTVCell)
}

class AddAdultsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subTitlelbl: UILabel!
    @IBOutlet weak var incrementView: UIView!
    @IBOutlet weak var plusImg: UIImageView!
    @IBOutlet weak var incrementBtn: UIButton!
    @IBOutlet weak var countView: UIView!
    @IBOutlet weak var countlbl: UILabel!
    @IBOutlet weak var decrementView: UIView!
    @IBOutlet weak var minusImg: UIImageView!
    @IBOutlet weak var decrementBtn: UIButton!
    @IBOutlet weak var ul: UIView!
    
    
    var delegate:AddAdultsTVCellDelegate?
    var count = 0
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
        subTitlelbl.text = cellInfo?.subTitle
        
        
        if titlelbl.text == "Adults" {
            countlbl.text = cellInfo?.text ?? "1"
        }else if titlelbl.text == "Children" {
            countlbl.text = cellInfo?.text ?? "0"
        }else if titlelbl.text == "Seat Infants" {
            countlbl.text = cellInfo?.text ?? "0"
        }else{
            countlbl.text = cellInfo?.text ?? "0"
        }
        
  
        
        
    }
    
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        setupLabels(lbl: titlelbl, text: "Adults", textcolor: .LabelTitleColor, font: .SigvarRegular(size: 18))
        setupLabels(lbl: subTitlelbl, text: "+12 yrs", textcolor: .LabelSubTitleColor, font: .SigvarRegular(size: 14))
        setupLabels(lbl: countlbl, text: "0", textcolor: .LabelTitleColor, font: .InterRegular(size: 16))
        setupViews(v: incrementView, radius: 4, color: .WhiteColor)
        setupViews(v: decrementView, radius: 4, color: .WhiteColor)
        setupViews(v: countView, radius: 4, color: .WhiteColor)
        plusImg.image = UIImage(named: "plus")?.withRenderingMode(.alwaysOriginal)
        minusImg.image = UIImage(named: "minus")?.withRenderingMode(.alwaysOriginal)
        incrementBtn.setTitle("", for: .normal)
        incrementBtn.addTarget(self, action: #selector(didTapOnIncrementBtn(_:)), for: .touchUpInside)
        decrementBtn.setTitle("", for: .normal)
        decrementBtn.addTarget(self, action: #selector(didTapOnDecrementBtn(_:)), for: .touchUpInside)
        ul.backgroundColor = HexColor("#E0DDDD")
    }
    
    
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    
    
    @objc func didTapOnIncrementBtn(_ sender:UIButton) {
        delegate?.didTapOnIncrementBtn(cell: self)
    }
    
    
    @objc func didTapOnDecrementBtn(_ sender:UIButton) {
        delegate?.didTapOnDecrementBtn(cell: self)
    }
    
    
    
}
