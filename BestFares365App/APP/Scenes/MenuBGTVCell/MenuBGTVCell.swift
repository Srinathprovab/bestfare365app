//
//  MenuBGTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
protocol MenuBGTVCellDelegate {
    func didTapOnLoginBtn(cell:MenuBGTVCell)
    func didTapOnEditProfileBtn(cell:MenuBGTVCell)
}

class MenuBGTVCell: TableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var editProfileView: UIView!
    @IBOutlet weak var editProfilelbl: UILabel!
    @IBOutlet weak var editProfileBtn: UIButton!
    @IBOutlet weak var editProfileViewHeight: NSLayoutConstraint!
    
    var delegate:MenuBGTVCellDelegate?
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
        profileImage.image = UIImage(named: "profile1")?.withRenderingMode(.alwaysOriginal)
        profileImage.layer.cornerRadius = 50
        profileImage.clipsToBounds = true
        
        editProfileBtn.setTitle("", for: .normal)
        loginBtn.setTitle("Login/Signup", for: .normal)
        loginBtn.setTitleColor(.WhiteColor, for: .normal)
        loginBtn.titleLabel?.font = UIFont.sigvarbold(size: 25)
        loginBtn.addTarget(self, action: #selector(didTapOnLoginBtn(_:)), for: .touchUpInside)
        
        editProfileView.backgroundColor = .ButtonColor
        editProfileView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 15)
        setuplabels(lbl: editProfilelbl, text: "Edit Profile", textcolor: .WhiteColor, font: .SigvarRegular(size: 20), align: .left)
        
        editProfileViewHeight.constant = 0
        editProfileView.isHidden = true
    }
    
    
    @objc func didTapOnLoginBtn(_ sender:UIButton){
        delegate?.didTapOnLoginBtn(cell: self)
    }
    
    @IBAction func didTapOnEditProfileBtn(_ sender: Any) {
        delegate?.didTapOnEditProfileBtn(cell: self)
        
    }
}
