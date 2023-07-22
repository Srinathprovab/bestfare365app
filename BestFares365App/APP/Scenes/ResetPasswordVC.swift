//
//  ResetPasswordVC.swift
//  BabSafar
//
//  Created by MA673 on 28/07/22.
//

import UIKit

class ResetPasswordVC: BaseTableVC, ChangePasswordViewModelDelegate {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    
    var payload = [String:Any]()
    var tablerow = [TableRow]()
    var email = String()
    var mobile = String()
    var showPwdBool = true
    var vm : ChangePasswordViewModel?
    static var newInstance: ResetPasswordVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ResetPasswordVC
        return vc
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = ChangePasswordViewModel(self)
    }
    
    
    func setupUI() {
        nav.titlelbl.text = "Reset Password"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["LabelTVCell","TextfieldTVCell","ButtonTVCell"])
        setuptv()
    }
    
    
    func setuptv() {
        tablerow.removeAll()
        tablerow.append(TableRow(title:"enter the email associated with your account and we’ll send an email with instructions to reset your password.",key: "cpwd",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Email Address",key: "email", text: "1", tempText: "email",cellType:.TextfieldTVCell))
        
        tablerow.append(TableRow(title:"Mobile No",key: "email", text: "44", tempText: "Mobile No",cellType:.TextfieldTVCell))
        
        
        tablerow.append(TableRow(title:"Send",bgColor: .ButtonColor,cellType:.ButtonTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    //MARK: - DID TAP ON SHOW PASSWORD BUTTON ACTION
    override func didTapOnShowPasswordBtn(cell:TextfieldTVCell){
        
//        if showPwdBool == true {
//            cell.showImage.image = UIImage(named: "showpass")
//            cell.txtField.isSecureTextEntry = false
//            showPwdBool = false
//        }else {
//            cell.txtField.isSecureTextEntry = true
//            cell.showImage.image = UIImage(named: "eyeslash")
//            showPwdBool = true
//        }
        
    }
    
    override func editingTextField(tf: UITextField) {
        switch tf.tag {
        case 1:
            email = tf.text ?? ""
            break
            
        case 44:
            mobile = tf.text ?? ""
            break
        
        default:
            break
        }
    }
    
    
    
    
    override func btnAction(cell: ButtonTVCell) {
        
        if self.email == "" {
            showToast(message: "Enter Email")
        }else if self.email.isValidEmail() == false {
            showToast(message: "Enter Valid Email ID")
        }else if self.mobile == "" {
            showToast(message: "Enter Mobile Number")
        }else if self.mobile.validateAsPhone() == false {
            showToast(message: "Enter Valid Mobile Number")
        }else {
            payload["email"] = email
            payload["phone"] = mobile
            vm?.CALL_FORGET_PASSWORD_API(dictParam: payload)
            
        }
    }
    
    
    func changePasswordsucess(response: RegisterModel) {
        if response.status == false {
            showToast(message: response.data ?? "")
        }else {
            showToast(message: response.data ?? "")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.gotoCreateNewPasswordVC()
            }
        }
    }
    
    
    func gotoCreateNewPasswordVC() {
        guard let vc = CreateNewPasswordVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}
