//
//  LoignOrSignupBtnsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

protocol LoignOrSignupBtnsTVCellDelegate {
    func didTapOnLoginBtn(cell:LoignOrSignupBtnsTVCell)
    func didTapOnSignUpBtn(cell:LoignOrSignupBtnsTVCell)
}

class LoignOrSignupBtnsTVCell: TableViewCell {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var loginlbl: UILabel!
    @IBOutlet weak var signUpView: UIView!
    @IBOutlet weak var signuplbl: UILabel!
    
    
    var delegate:LoignOrSignupBtnsTVCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        loginView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 4)
        loginView.backgroundColor = .ButtonColor
        signUpView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 4)
        signUpView.backgroundColor = .WhiteColor
        setuplabels(lbl: loginlbl, text: "Login", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 18), align: .left)
        setuplabels(lbl: signuplbl, text: "Sign Up", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 18), align: .left)
    }
    
    
    @IBAction func didTapOnLoginBtn(_ sender: Any) {
        delegate?.didTapOnLoginBtn(cell: self)
    }
    
    @IBAction func didTapOnSignUpBtn(_ sender: Any) {
        delegate?.didTapOnSignUpBtn(cell: self)
    }
    
}
