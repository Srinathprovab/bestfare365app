//
//  CreateNewPasswordVC.swift
//  BabSafar
//
//  Created by MA673 on 27/07/22.
//

import UIKit

class CreateNewPasswordVC: BaseTableVC, ResetPasswordViewModelDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    static var newInstance: CreateNewPasswordVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CreateNewPasswordVC
        return vc
    }
    var oldpass = String()
    var newPass = String()
    var confPass = String()
    var vm : ResetPasswordViewModel?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        vm = ResetPasswordViewModel(self)
        
    }
    
    func setupUI() {
        nav.titlelbl.text = "Create New Password"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["LabelTVCell","TextfieldTVCell","ButtonTVCell"])
        setuptv()
    }
    
    func setuptv() {
        tablerow.removeAll()
        tablerow.append(TableRow(title:"enter the email associated with your account and we’ll send an email with instructions to reset your password.",key: "cpwd",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Old Password",key: "cpwd", text: "1", tempText: "Old Password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"New password",key: "cpwd", text: "2", tempText: "New password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Confirm password",key: "cpwd", text: "3", tempText: "Confirm password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Reset",bgColor: .ButtonColor,cellType:.ButtonTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    override func editingTextField(tf: UITextField) {
        switch tf.tag {
        case 1:
            oldpass = tf.text ?? ""
            break
        case 2:
            newPass = tf.text ?? ""
            break
        case 3:
            confPass = tf.text ?? ""
            break
        default:
            break
        }
    }
    
    override func btnAction(cell: ButtonTVCell) {
        if oldpass == "" {
            showToast(message: "Enter Old Password")
        }else if newPass == "" {
            showToast(message: "Enter New Password")
        }else if confPass == "" {
            showToast(message: "Enter Conform Password")
        }else if newPass != confPass {
            showToast(message: "Password Did Not Match")
        }else {
            
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
            payload["current_password"] = oldpass
            payload["new_password"] = newPass
            payload["confirm_password"] = confPass
            vm?.CALL_RESET_PASSWORD_API(dictParam: payload)
        }
    }
    
    
    
    func resetpasswordSucessdetails(response: ResetPasswordModel) {
        
        if response.status == false {
            showToast(message: response.msg ?? "")
        }else {
            showToast(message: response.msg ?? "")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                self.gotoHomeVC()
            }
        }
        
        
        
    }
    
    
    
    func gotoHomeVC() {
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.keyStr = "CreateNewPasswordVC"
        present(vc, animated: true)
    }
    
    
}
