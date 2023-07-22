//
//  TextfieldTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit
import DropDown

protocol TextfieldTVCellDelegate {
    func didTapOnForGetPassword(cell:TextfieldTVCell)
    func editingTextField(tf:UITextField)
    func didTapOnShowPasswordBtn(cell:TextfieldTVCell)
    
    func donedatePicker(cell:TextfieldTVCell)
    func doneDobdatePicker(cell:TextfieldTVCell)
    func cancelDatePicker(cell:TextfieldTVCell)
    func selectedTitle(cell:TextfieldTVCell)
    
    
}


class TextfieldTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var textHolderView: UIView!
    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var showImage: UIImageView!
    @IBOutlet weak var forgetPwdBtn: UIButton!
    @IBOutlet weak var btnHeight: NSLayoutConstraint!
    @IBOutlet weak var showPassBtn: UIButton!
    @IBOutlet weak var viewheight: NSLayoutConstraint!
    @IBOutlet weak var showPassView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var fnameTitlelbl: UILabel!
    @IBOutlet weak var titleBtn: UIButton!
    @IBOutlet weak var textFieldLeftConstraint: NSLayoutConstraint!
    
    
    
    
    var mrArray = ["Mr","Mrs","Miss","M"]
    let selectTitleDropDown = DropDown()
    let dobDatePicker = UIDatePicker()
    let datePicker = UIDatePicker()
    var delegate:TextfieldTVCellDelegate?
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
        txtField.text = cellInfo?.buttonTitle
    }
    
    override func updateUI() {
        btnHeight.constant = 0
        titlelbl.text = cellInfo?.title
        txtField.placeholder = cellInfo?.tempText
        txtField.tag = Int(cellInfo?.text ?? "") ?? 0
        txtField.text = cellInfo?.subTitle
        
        switch cellInfo?.key {
        case "email":
            self.txtField.isSecureTextEntry = false
            
        case "mob":
            txtField.keyboardType = .numberPad
            break
            
            
        case "editprofile":
            txtField.isUserInteractionEnabled = true
            break
            
        case "profile":
            txtField.isUserInteractionEnabled = false
            break
            
        case "pwd":
            showPassView.isHidden = false
            self.txtField.isSecureTextEntry = true
            btnHeight.constant = 30
            forgetPwdBtn.isHidden = false
            
        case "signuppwd":
            showPassView.isHidden = false
            self.txtField.isSecureTextEntry = true
            btnHeight.constant = 0
            forgetPwdBtn.isHidden = true
            
        case "signup":
            showPassView.isHidden = true
            self.txtField.isSecureTextEntry = false
            forgetPwdBtn.isHidden = true
            
        case "cpwd":
            showPassView.isHidden = false
            self.txtField.isSecureTextEntry = true
            forgetPwdBtn.isHidden = true
            textHolderView.layer.borderColor = UIColor.lightGray.cgColor
            
        case "myacc":
            self.txtField.isSecureTextEntry = true
            btnHeight.constant = 30
            forgetPwdBtn.isHidden = false
            forgetPwdBtn.setTitle("Change  password", for: .normal)
            
        case "visa":
            self.viewheight.constant = 120
            
        case "dob":
            dobDatePicker.maximumDate = Date()
            showDOBDatePicker()
            showImage.image = UIImage(named: "down")
            break
            
        case "cal":
            datePicker.minimumDate = Date()
            showDatePicker()
            showPassView.isHidden = false
            forgetPwdBtn.isUserInteractionEnabled = false
            showImage.image = UIImage(named: "cal")
            break
            
            
        default:
            break
        }
        
        
        if cellInfo?.key1 == "fname" {
            titleView.isHidden = false
            textFieldLeftConstraint.constant = 70
            selectTitleDropDown.dataSource = mrArray
            setupselectTitleDropDown()
            
            switch cellInfo?.buttonTitle {
            case "1":
                fnameTitlelbl.text = "Mr"
                fnameTitlelbl.textColor = .AppLabelColor
                break
                
            case "2":
                fnameTitlelbl.text = "Mrs"
                fnameTitlelbl.textColor = .AppLabelColor
                break
                
            case "3":
                fnameTitlelbl.text = "Miss"
                fnameTitlelbl.textColor = .AppLabelColor
                break
                
            case "4":
                fnameTitlelbl.text = "M"
                fnameTitlelbl.textColor = .AppLabelColor
                break
                
                
                
            default:
                break
            }
        }
        
        if cellInfo?.isOptional == true {
            txtField.text = cellInfo?.subTitle
        }
        
    }
    
    
    
    func showDOBDatePicker(){
        //Formate Date
        dobDatePicker.datePickerMode = .date
        dobDatePicker.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDobDatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtField.inputAccessoryView = toolbar
        txtField.inputView = dobDatePicker
        
    }
    
    
    @objc func doneDobDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        txtField.text = formatter.string(from: datePicker.date)
        delegate?.doneDobdatePicker(cell: self)
    }
    
    
    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtField.inputAccessoryView = toolbar
        txtField.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        txtField.text = formatter.string(from: datePicker.date)
        delegate?.donedatePicker(cell: self)
    }
    
    @objc func cancelDatePicker(){
        delegate?.cancelDatePicker(cell: self)
    }
    
    func setupUI() {
        showPassView.isHidden = true
        showPassBtn.setTitle("", for: .normal)
        holderView.backgroundColor = .WhiteColor
        textHolderView.backgroundColor = .WhiteColor
        textHolderView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        textHolderView.layer.borderWidth = 1
        textHolderView.layer.cornerRadius = 4
        textHolderView.clipsToBounds = true
        showImage.image = UIImage(named: "eyeslash")
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.SigvarRegular(size: 14)
        txtField.delegate = self
        txtField.backgroundColor = .clear
        txtField.setLeftPaddingPoints(20)
        txtField.font = UIFont.SigvarRegular(size: 18)
        txtField.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        
        forgetPwdBtn.setTitle("Forgot Password?", for: .normal)
        forgetPwdBtn.setTitleColor(.ButtonColor, for: .normal)
        forgetPwdBtn.titleLabel?.font = UIFont.ProximaNovaBold(size: 16)
        forgetPwdBtn.isHidden = true
        
        titleView.backgroundColor = .WhiteColor
        setuplabels(lbl: fnameTitlelbl, text: "Mr", textcolor: .lightGray, font: .SigvarRegular(size: 18), align: .center)
        titleBtn.setTitle("", for: .normal)
        titleView.isHidden = true
        titleView.addCornerRadiusWithShadow(color: .clear, borderColor: .AppBorderColor, cornerRadius: 0)
        textFieldLeftConstraint.constant = 0
    }
    
    
    @objc func editingText(textField:UITextField) {
        delegate?.editingTextField(tf: textField)
    }
    
    func setupselectTitleDropDown() {
        selectTitleDropDown.direction = .bottom
        selectTitleDropDown.backgroundColor = .WhiteColor
        selectTitleDropDown.anchorView = self.titleView
        selectTitleDropDown.bottomOffset = CGPoint(x: 0, y: titleView.frame.size.height + 10)
        selectTitleDropDown.selectionAction = { [weak self] (index: Int, item: String) in
            self?.fnameTitlelbl.text = item
            self?.fnameTitlelbl.textColor = .AppLabelColor
            self?.delegate?.selectedTitle(cell: self!)
        }
    }
    
    
    
    @IBAction func didTapOnForGetPassword(_ sender: Any) {
        delegate?.didTapOnForGetPassword(cell: self)
    }
    
    
    
    @IBAction func didTapOnShowPasswordBtn(_ sender: Any) {
        delegate?.didTapOnShowPasswordBtn(cell: self)
    }
    
    
    @IBAction func didTapOnTitleBtn(_ sender: Any) {
        selectTitleDropDown.show()
    }
    
    
    
}


extension TextfieldTVCell {
    override func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if textField.tag == 44 {
            
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet) && newString.length <= maxLength
            
        }else {
            let maxLength = 50
            let currentString: NSString = (textField.text ?? "") as NSString
            let newString: NSString =  currentString.replacingCharacters(in: range, with: string) as NSString
            
            return newString.length <= maxLength
        }
    }
}
