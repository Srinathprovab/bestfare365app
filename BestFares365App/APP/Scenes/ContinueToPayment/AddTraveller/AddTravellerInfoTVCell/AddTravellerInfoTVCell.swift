//
//  AddTravellerInfoTVCell.swift
//  BestFares365App
//
//  Created by FCI on 14/03/23.
//

import UIKit

class AddTravellerInfoTVCell: TableViewCell {

    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var radioMaleImg: UIImageView!
    @IBOutlet weak var maleTitlelbl: UILabel!
    @IBOutlet weak var maleTapBtn: UIButton!
    @IBOutlet weak var radioFemaleImg: UIImageView!
    @IBOutlet weak var femaleTitlelbl: UILabel!
    @IBOutlet weak var femaleTapBtn: UIButton!
    @IBOutlet weak var radioOthersImg: UIImageView!
    @IBOutlet weak var othersTitlelbl: UILabel!
    @IBOutlet weak var othersTapBtn: UIButton!
    @IBOutlet weak var fnameTF: UITextField!
    @IBOutlet weak var fnameTitlelbl: UILabel!
    @IBOutlet weak var lnameTitlelbl: UILabel!
    @IBOutlet weak var lnameTF: UITextField!
    @IBOutlet weak var dobTF: UITextField!
    @IBOutlet weak var dobTitlelbl: UILabel!
    @IBOutlet weak var calImg: UIImageView!
    @IBOutlet weak var travelDocumentTitlelbl: UILabel!
    @IBOutlet weak var passportNumberTitlelbl: UILabel!
    @IBOutlet weak var passportNumberTF: UITextField!
    @IBOutlet weak var issuingCountryTitlelbl: UILabel!
    @IBOutlet weak var issuingCountryTF: UITextField!
    @IBOutlet weak var dateofExpiryTitlelbl: UILabel!
    @IBOutlet weak var dateofExpiryTF: UITextField!
    @IBOutlet weak var frequentFlyerTitlelbl: UILabel!
    @IBOutlet weak var optionslbl: UILabel!
    @IBOutlet weak var frequentflyerprogramTitlelbl: UILabel!
    @IBOutlet weak var frequentFlyerProgramTF: UITextField!
    @IBOutlet weak var frequentFlyerNumberTitlelbl: UILabel!
    @IBOutlet weak var frequentFlyerNumberTF: UITextField!
    @IBOutlet weak var saveBtnView: UIView!
    @IBOutlet weak var savelbl: UILabel!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var fnameView: UIView!
    @IBOutlet weak var lnameView: UIView!
    @IBOutlet weak var dobView: UIView!
    @IBOutlet weak var passportNoView: UIView!
    @IBOutlet weak var issueingCountryView: UIView!
    @IBOutlet weak var expireDateView: UIView!
    @IBOutlet weak var frequentlyView: UIView!
    @IBOutlet weak var frequentlyNoView: UIView!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
 
    
    @IBAction func didTapOnMaleBtn(_ sender: Any) {
        
    }
    
    
    @IBAction func didTapOnFemaleBtn(_ sender: Any) {
    }
    
    
    @IBAction func didTapOnOtherseBtn(_ sender: Any) {
    }
    
    @IBAction func didTapOnSaveBtn(_ sender: Any) {
        
    }
    
}
