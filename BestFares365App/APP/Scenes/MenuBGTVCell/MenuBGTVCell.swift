//
//  MenuBGTVCell.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit
import SDWebImage


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
    
    
    
    override func updateUI() {
        
        if defaults.bool(forKey: sessionMgrDefaults.loggedInStatus) == true {
            editProfileView.isHidden = false
            loginBtn.isHidden = true
            editProfilelbl.text = "\(profileDetailsArray?.first_name ?? "") \(profileDetailsArray?.last_name ?? "")"
            profileImage.sd_setImage(with: URL(string: img1 ), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        }else {
            editProfileView.isHidden = true
            loginBtn.isHidden = false
            profileImage.image = UIImage(named: "profile1")?.withRenderingMode(.alwaysOriginal)
    
        }
        
    }
    
    
    func setupUI() {
        profileImage.layer.cornerRadius = 50
        profileImage.clipsToBounds = true
        profileImage.contentMode = .scaleToFill
        profileImage.layer.borderWidth = 3
        profileImage.layer.borderColor = UIColor.WhiteColor.cgColor
        
        editProfileBtn.setTitle("", for: .normal)
        
        loginBtn.setTitleColor(.WhiteColor, for: .normal)
        loginBtn.titleLabel?.font = UIFont.sigvarbold(size: 25)
        loginBtn.addTarget(self, action: #selector(didTapOnLoginBtn(_:)), for: .touchUpInside)
        
        editProfileView.backgroundColor = .clear
//        editProfileView.addCornerRadiusWithShadow(color: .clear, borderColor: .BorderColor, cornerRadius: 15)
        setuplabels(lbl: editProfilelbl, text: "Edit Profile", textcolor: .WhiteColor, font: .SigvarRegular(size: 20), align: .left)
        loginBtn.isHidden = true
        loginBtn.setTitle("Login/Signup", for: .normal)
    }
    
    
    @objc func didTapOnLoginBtn(_ sender:UIButton){
        delegate?.didTapOnLoginBtn(cell: self)
    }
    
    @IBAction func didTapOnEditProfileBtn(_ sender: Any) {
        delegate?.didTapOnEditProfileBtn(cell: self)
    }
    
    
    
}
