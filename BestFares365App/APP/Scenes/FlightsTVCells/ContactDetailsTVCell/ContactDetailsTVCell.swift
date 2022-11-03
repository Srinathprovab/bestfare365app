//
//  ContactDetailsTVCell.swift
//  BestFares365App
//
//  Created by FCI on 31/10/22.
//

import UIKit

protocol ContactDetailsTVCellDelegate {
    func editingChanged(tf:UITextField)
    func didTapoNCountryCodeBtn(cell:ContactDetailsTVCell)
}

class ContactDetailsTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var logoImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var gmailAddresslbl: UILabel!
    @IBOutlet weak var gmailAddressView: UIView!
    @IBOutlet weak var gmailAddressTF: UITextField!
    @IBOutlet weak var mobileNumberlbl: UILabel!
    @IBOutlet weak var mobileNumberView: UIView!
    @IBOutlet weak var mobileNumberTF: UITextField!
    @IBOutlet weak var countryCodelbl: UILabel!
    @IBOutlet weak var countryCodeBtn: UIButton!
    @IBOutlet weak var subtitlelbl: UILabel!
    @IBOutlet weak var countryCodeView: UIView!
    
    
    var delegate:ContactDetailsTVCellDelegate?
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
        gmailAddressTF.tag = cellInfo?.characterLimit ?? 0
        mobileNumberTF.tag = cellInfo?.characterLimit2 ?? 0
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        holderView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        gmailAddressView.backgroundColor = .WhiteColor
        gmailAddressView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        mobileNumberView.backgroundColor = .WhiteColor
        mobileNumberView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 6)
        logoImg.image = UIImage(named: "contacts")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: titlelbl, text: "Contact Details", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 16), align: .left)
        setuplabels(lbl: subtitlelbl, text: "your moblie number will be uded only for sending flight relates communication", textcolor: .LabelSubTitleColor, font: .ProximaNovaRegular(size: 12), align: .left)
        setuplabels(lbl: gmailAddresslbl, text: "Gmail Address", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 14), align: .left)
        setuplabels(lbl: mobileNumberlbl, text: "Mobile number", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 14), align: .left)
        
        setuplabels(lbl: countryCodelbl, text: "+91", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 14), align: .center)
        
        setupTextFiels(txtField: gmailAddressTF)
        setupTextFiels(txtField: mobileNumberTF)
        countryCodeBtn.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        countryCodeView.backgroundColor = HexColor("#E0DDDD")
        
        
    }
    
    
    func setupTextFiels(txtField :UITextField) {
        txtField.delegate = self
        txtField.setLeftPaddingPoints(10)
        txtField.placeholder = ""
        txtField.font = .poppinsMedium(size: 15)
        txtField.isSecureTextEntry = false
        txtField.backgroundColor = .WhiteColor
        txtField.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        
    }
    
    
    @objc func editingChanged(_ sender:UITextField) {
        delegate?.editingChanged(tf: sender)
    }
    
    
    func didTapoNCountryCodeBtn(_ sender:UIButton) {
        delegate?.didTapoNCountryCodeBtn(cell: self)
    }
    
}



extension ContactDetailsTVCell {
    
    
    
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        switch textField {
        case gmailAddressTF://email
            let maxLength = 30
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
            
            
        case mobileNumberTF://mobile
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && newString.length <= maxLength
            
            
        default:
            return true
            break
        }
        
        
        
    }
    
    
    
    
}
