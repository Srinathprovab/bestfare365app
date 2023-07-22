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
}

class DropDownTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dropdownView: UIView!
    @IBOutlet weak var dropdownlbl: UILabel!
    @IBOutlet weak var dropdownImg: UIImageView!
    @IBOutlet weak var dropdownBtn: UIButton!
    
    var delegate:DropDownTVCellDelegate?
    var optionArray = [String]()
    let dropDown = DropDown()
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
        dropdownlbl.text = cellInfo?.subTitle
        dropdownImg.image = UIImage(named: cellInfo?.image ?? "")
        dropDown.dataSource = cellInfo?.moreData as? [String] ?? []
        
        setupDropDown()
    }
    
    
    func setupDropDown() {
        
        dropDown.direction = .any
        dropDown.backgroundColor = .WhiteColor
        dropDown.anchorView = self.dropdownBtn
        dropDown.bottomOffset = CGPoint(x: 0, y: dropdownView.frame.size.height + 10)
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.dropdownlbl.text = item
            self?.dropdownlbl.textColor = .LabelTitleColor
            self?.delegate?.didTapOnDropDownBtn(cell: self!)
        }
    }
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        dropdownView.backgroundColor = .WhiteColor
        dropdownView.layer.cornerRadius = 4
        dropdownView.clipsToBounds = true
        dropdownView.layer.borderColor = UIColor.BorderColor.cgColor
        dropdownView.layer.borderWidth = 1
        
        titlelbl.textColor = .LabelTitleColor
        titlelbl.font = UIFont.SigvarRegular(size: 14)
        
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
