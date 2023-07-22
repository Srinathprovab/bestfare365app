//
//  LoginVC.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit
import Alamofire

class LoginVC: BaseTableVC, LoginViewModelDelegate {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var closeImg: UIImageView!
    
    static var newInstance: LoginVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoginVC
        return vc
    }
    
    var tablerow = [TableRow]()
    var loginKey = "login"
    var fname = String()
    var lname = String()
    var email = String()
    var mobile = String()
    var pass = String()
    var cpass = String()
    var showPwdBool = true
    var payload = [String:Any]()
    var uname = String()
    var password = String()
    var viewmodel:LoginViewModel?
    var isVcFrom = String()
    
    
    //MARK: - LOADING FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        setupTV()
        viewmodel = LoginViewModel(self)
    }
    
    
    
    //MARK: - SETUP INITIAL UI
    func setupTV() {
        
        //   regViewModel = RegisterViewModel(self)
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        closeImg.image = UIImage(named: "close")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        closeBtn.tintColor = .WhiteColor
        closeBtn.addTarget(self, action: #selector(didTapOnCloseBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["LabelTVCell","LoignOrSignupBtnsTVCell","TextfieldTVCell","ButtonTVCell","UnderLineTVCell","SignUpWithTVCell","EmptyTVCell"])
        
        appendLoginTvcells()
    }
    
    
    
    
    //MARK: - APPEND LOGIN TABLE VIEW CELLS
    func appendLoginTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.LoignOrSignupBtnsTVCell))
        tablerow.append(TableRow(title:"Email address",key: "email", text: "1", tempText: "Email ID",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Password",key: "pwd", text: "2", tempText: "Password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Log In",key:"login", bgColor: .ButtonColor,cellType:.ButtonTVCell))
        tablerow.append(TableRow(cellType:.UnderLineTVCell))
        tablerow.append(TableRow(cellType:.SignUpWithTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    
    //MARK: - SETUP SIGNUP TABLE VIEW CELLS
    func appendSignupTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.LoignOrSignupBtnsTVCell))
        tablerow.append(TableRow(title:"Email address",key: "signup", text: "4", tempText: "Address",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Password",key: "signuppwd", text: "5", tempText: "Password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Conform Password",key: "signuppwd", text: "6", tempText: "Password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Sign Up",key: "login",bgColor: .ButtonColor,cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
    }
    
    
    
    @objc func didTapOnCloseBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    override func didTapOnGoogleBtn(cell: SignUpWithTVCell) {
        print("didTapOnGoogleBtn")
    }
    
    
    
    
    //MARK: - FORGET BUTTON TAP ACTION
    override func didTapOnForGetPassword(cell: TextfieldTVCell) {
        guard let vc = ResetPasswordVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    
    
    //MARK: - TEXTFIELD EDITING
    override func editingTextField(tf: UITextField) {
        
        if loginKey == "reg" {
            switch tf.tag {
            case 4:
                email = tf.text ?? ""
                break
                
            case 5:
                pass = tf.text ?? ""
                break
                
            case 6:
                cpass = tf.text ?? ""
                break
                
           
            default:
                break
            }
        }else {
            switch tf.tag {
            case 1:
                uname = tf.text ?? ""
                break
                
            case 2:
                password = tf.text ?? ""
                break
                
            default:
                break
            }
        }
        
    }
    
    
    //MARK: - LOGIN BUTTON ACTION
    override func didTapOnLoginBtn(cell: LoignOrSignupBtnsTVCell) {
        loginKey = "login"
        cell.loginView.backgroundColor = .ButtonColor
        cell.loginlbl.textColor = .WhiteColor
        
        cell.signUpView.backgroundColor = .WhiteColor
        cell.signuplbl.textColor = .AppLabelColor
        
        appendLoginTvcells()
    }
    
    
    //MARK: - SIGNUP BUTTON ACTION
    override func didTapOnSignUpBtn(cell: LoignOrSignupBtnsTVCell) {
        loginKey = "reg"
        cell.loginView.backgroundColor = .WhiteColor
        cell.loginlbl.textColor = .AppLabelColor
        
        cell.signUpView.backgroundColor = .ButtonColor
        cell.signuplbl.textColor = .WhiteColor
        
        appendSignupTvcells()
    }
    
    
    //MARK: - DID TAP ON SHOW PASSWORD BUTTON ACTION
    override func didTapOnShowPasswordBtn(cell:TextfieldTVCell){
        
        if showPwdBool == true {
            cell.showImage.image = UIImage(named: "showpass")
            cell.txtField.isSecureTextEntry = false
            showPwdBool = false
        }else {
            cell.txtField.isSecureTextEntry = true
            cell.showImage.image = UIImage(named: "eyeslash")
            showPwdBool = true
        }
        
    }
    
    
    //MARK: - Login or Register Button Action
    override func btnAction(cell: ButtonTVCell) {
        if loginKey == "reg" {
           
            if email == "" {
                showToast(message: "Enter Email")
            }
            else if email.isValidEmail() == false {
                showToast(message: "Enter Valid Email ID")
            }
            else if pass == "" {
                showToast(message: "Enter Password")
            }else if cpass == "" {
                showToast(message: "Enter Conform Password")
            }else if pass != cpass {
                showToast(message: "Password not same")
            }else {
                print("call register api")
                
                payload["email"] = email
                payload["password"] = pass
                payload["confirm_password"] = cpass
                viewmodel?.CALL_REGISTER_USER_API(dictParam: payload)
            }
        }else {
            
            if uname == "" {
                showToast(message: "Enter Email")
            }else if uname.isValidEmail() == false {
                showToast(message: "Enter Valid Email")
            }else if password == "" {
                showToast(message: "Enter Password")
            }else {
                payload["username"] = uname
                payload["password"] = password
                viewmodel?.CALL_USER_LOGIN_API(dictParam: payload)
                
            }
        }
    }
    
    
    //MARK: - USER LOGIN RESPONSE
    func loginDetails(response: LoginModel) {
       
        if response.status == false {
            showToast(message: response.data ?? "")
        }else {
            defaults.set(true, forKey: sessionMgrDefaults.loggedInStatus)
            defaults.set(response.user_id, forKey: UserDefaultsKeys.userid)
            
            showToast(message: response.data ?? "")
          
            let seconds = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
              //  self.gotoHomeVC()
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadmenu"), object: nil)
                self.dismiss(animated: true)
            }
        }
        
    }
    
    
    
    //MARK: - USER REGISTER RESPONSE
    func registerDetails(response: RegisterModel) {
        
        if response.status == false {
            showToast(message: response.data ?? "")
        }else {
            
            showToast(message: response.data ?? "")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                //self.gotoHomeVC()
                
                self.appendLoginTvcells()
            }
            
        }
    }
    
    
    
    
    func gotoHomeVC() {
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.keyStr = "HomeVc"
        present(vc, animated: true)
    }
    
}
