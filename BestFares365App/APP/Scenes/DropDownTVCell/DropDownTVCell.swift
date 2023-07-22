//
//  DropDownTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
import DropDown


protocol DropDownTVCellDelegate {
    func didTapOnDropDownBtn(cell:DropDownTVCell)
    func didTapOnIssuingCountryDropDownBtn(cell:DropDownTVCell)
    
}

class DropDownTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var dropdownlbl: UILabel!
    @IBOutlet weak var dropdownImg: UIImageView!
    @IBOutlet weak var dropdownBtn: UIButton!
    
    
    let datePicker = UIDatePicker()
    var delegate:DropDownTVCellDelegate?
    var optionArray = [String]()
    let dropDown = DropDown()
    var countryNameArray = [String]()
    var pass_isssung_country_code = String()
    var pass_nationality = String()
    
    
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
        countryNameArray.removeAll()
        titlelbl.text = cellInfo?.title
        dropdownlbl.text = cellInfo?.subTitle
        dropdownImg.image = UIImage(named: cellInfo?.image ?? "")
       
        if cellInfo?.key == "cal" {
            dropDown.dataSource = cellInfo?.moreData as? [String] ?? []
            setupDropDown()
        }else {
            phoneCodeArray.forEach { i in
                countryNameArray.append(i.name ?? "")
            }
            
            dropDown.dataSource = countryNameArray
            setupDropDown()
        }
        
        
        
    }
    
    
    
  
    func setupDropDown() {
        
        dropDown.direction = .any
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.dropdownBtn
        dropDown.bottomOffset = CGPoint(x: 0, y: dropdownView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            
            
            if self?.cellInfo?.key == "cal" {
                self?.dropdownlbl.text = item
                self?.dropdownlbl.textColor = .AppLabelColor
                self?.delegate?.didTapOnDropDownBtn(cell: self!)
            }else {
                self?.dropdownlbl.text = phoneCodeArray[index].name
                self?.dropdownlbl.textColor = .AppLabelColor
                self?.pass_isssung_country_code = phoneCodeArray[index].iso_country_code ?? ""
                self?.pass_nationality = phoneCodeArray[index].origin ?? ""
                self?.delegate?.didTapOnIssuingCountryDropDownBtn(cell: self!)
            }
        }
    }
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        dropdownView.backgroundColor = .WhiteColor
        dropdownView.layer.cornerRadius = 4
        dropdownView.clipsToBounds = true
        dropdownView.layer.borderColor = UIColor.BorderColor.cgColor
        dropdownView.layer.borderWidth = 1
        
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.SigvarRegular(size: 14)
        
        dropdownlbl.text = cellInfo?.subTitle
        dropdownlbl.textColor = HexColor("#CECECE")
        dropdownlbl.font = UIFont.SigvarRegular(size: 18)
        dropdownBtn.setTitle("", for: .normal)
        
    }
    
    @IBAction func didTapOnDropDownBtn(_ sender: Any) {
        if self.titlelbl.text == "Date Of Travel" {
            dropDown.hide()
        }else {
            dropDown.show()
        }
        
        //  delegate?.didTapOnDropDownBtn(cell: self)
    }
}
