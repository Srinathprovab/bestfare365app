//
//  EditProfileVC.swift
//  BestFares365App
//
//  Created by FCI on 31/01/23.
//

import UIKit
import MobileCoreServices
import Alamofire
import SDWebImage
import Photos


class EditProfileVC: BaseTableVC, MyProfileViewModelDelegate {
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var changeProfilePiclbl: UILabel!
    @IBOutlet weak var changeProfilePicBtn: UIButton!
    @IBOutlet weak var changeProfilePicBtnView: UIView!
    @IBOutlet weak var editBtnView: UIView!
    @IBOutlet weak var editlbl: UILabel!
    @IBOutlet weak var editBtn: UIButton!
    
    var tablerow = [TableRow]()
    var fname = String()
    var lname = String()
    var email = String()
    var mobile = String()
    var key = String()
    var vm:MyProfileViewModel?
    var payload = [String:Any]()
    var pickerbool = false
    
    static var newInstance: EditProfileVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? EditProfileVC
        return vc
    }
    
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        
        if pickerbool == true {
            
        }else {
            
            callAPI()
            
            //            if defaults.bool(forKey: sessionMgrDefaults.loggedInStatus) == true {
            //
            //            }else {
            //                profileImg.image = UIImage(named: "profile1")
            //            }
            
        }
        
    }
    
    func callAPI() {
        self.payload.removeAll()
        self.payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
        self.vm?.CALL_GET_PROFILE_DETAILS_API(dictParam: self.payload)
    }
    
    
    func profileDetails(response: MyProfileModel) {
        profileDetailsArray = response
        
        fname = profileDetailsArray?.first_name ?? ""
        lname = profileDetailsArray?.last_name ?? ""
        mobile = profileDetailsArray?.phone ?? ""
        email = profileDetailsArray?.email ?? ""
        profileView.isHidden = false
        self.profileImg.sd_setImage(with: URL(string: profileDetailsArray?.profile_image ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
        
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = MyProfileViewModel(self)
    }
    
    
    
    // MARK: - setupUI
    func setupUI(){
        
        
        if screenHeight > 835 {
            navHeight.constant = 190
        }else {
            navHeight.constant = 160
        }
        changeProfilePicBtnView.isHidden = true
        setuplabels(lbl: nav.titlelbl, text: "My Profile", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 22), align: .center)
        nav.backBtn.addTarget(self, action: #selector(backBtnAction(_:)), for: .touchUpInside)
        setuplabels(lbl: changeProfilePiclbl, text: "Change Picture", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 14), align: .center)
        changeProfilePicBtn.addTarget(self, action: #selector(didTapOnChangePictureBtn(_:)), for: .touchUpInside)
        profileImg.contentMode = .scaleToFill
        profileView.layer.cornerRadius = 50
        profileView.clipsToBounds = true
        profileView.layer.borderWidth = 3
        profileView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        editBtnView.backgroundColor = HexColor("#009DEA")
        editBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 5)
        setuplabels(lbl: editlbl, text: "EDIT", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 18), align: .center)
        editBtn.addTarget(self, action: #selector(didTapOnEditBtnAction(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["TextfieldTVCell",
                                         "ButtonTVCell",
                                         "EmptyTVCell"])
        setupTVCells()
        
    }
    
    
    // MARK: - didTapOnEditBtnAction
    @objc func didTapOnEditBtnAction(_ sender:UIButton) {
        self.key = "edit"
        changeProfilePicBtnView.isHidden = false
        setupTVCells()
    }
    
    
    
    // MARK: - backBtnAction
    @objc func backBtnAction(_ sender:UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadmenu"), object: nil)
        dismiss(animated: true)
    }
    
    
    // MARK: - didTapOnChangePictureBtn
    @objc func didTapOnChangePictureBtn(_ sender:UIButton) {
        
        let alert = UIAlertController(title: "Choose To Open", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Open Gallery", style: .default){ (action) in
            self.openGallery()
        })
        alert.addAction(UIAlertAction(title: "Open Camera", style: .default){ (action) in
            self.openCemera()
        })
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel){ (action) in
        })
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // MARK: - setupTVCells
    func setupTVCells() {
        tablerow.removeAll()
        
        
        if key == "edit" {
            
            tablerow.append(TableRow(title:"First Name",subTitle: fname, key: "editprofile",text: "1", tempText: "First Name",cellType:.TextfieldTVCell))
            tablerow.append(TableRow(title:"Last Name",subTitle: lname, key: "editprofile", text: "2", tempText: "Last Name",cellType:.TextfieldTVCell))
            tablerow.append(TableRow(title:"Email Address",subTitle: email, key: "editprofile", text: "3", tempText: "Email Address",cellType:.TextfieldTVCell))
            tablerow.append(TableRow(title:"Mobile Number",subTitle: mobile, key: "editprofile", text: "44", tempText: "Mobile Number",cellType:.TextfieldTVCell))
            
            
            tablerow.append(TableRow(title:"UPDATE",key: "profile",bgColor: .ButtonColor,cellType:.ButtonTVCell))
            tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        }else {
            
            tablerow.append(TableRow(title:"First Name",subTitle: fname, key: "profile",text: "1", tempText: "First Name",cellType:.TextfieldTVCell))
            tablerow.append(TableRow(title:"Last Name",subTitle: lname, key: "profile", text: "2", tempText: "Last Name",cellType:.TextfieldTVCell))
            tablerow.append(TableRow(title:"Email Address",subTitle: email, key: "profile", text: "3", tempText: "Email Address",cellType:.TextfieldTVCell))
            tablerow.append(TableRow(title:"Mobile Number",subTitle: mobile, key: "profile", text: "44", tempText: "Mobile Number",cellType:.TextfieldTVCell))
            
            
        }
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    // MARK: - editingChanged
    override func editingTextField(tf: UITextField) {
        switch tf.tag {
        case 1:
            self.fname = tf.text ?? ""
            break
            
        case 2:
            self.lname = tf.text ?? ""
            break
            
            
        case 3:
            self.email = tf.text ?? ""
            break
            
        case 44:
            self.mobile = tf.text ?? ""
            break
            
            
        default:
            break
        }
    }
    
    
    
    // MARK: - update button action
    override func btnAction(cell: ButtonTVCell) {
        if fname.isEmpty == true {
            showToast(message: "Enter First Name")
        }else if lname.isEmpty == true {
            showToast(message: "Enter Last Name")
        }else if email.isEmpty == true {
            showToast(message: "Enter Email")
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Valid Email")
        }else if mobile.isEmpty == true {
            showToast(message: "Enter Mobile Number")
        }
        //        else if mobile.validateAsPhone() == false {
        //            showToast(message: "Enter Valid Mobile Number")
        //        }
        
        else{
            
            payload["title"] = "1"
            payload["first_name"] = fname
            payload["last_name"] = lname
            payload["country_code"] = "+91"
            payload["phone"] = mobile
            payload["address"] = "ECity"
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
            
            callUpdateProfileAPI()
        }
    }
    
    
    
    // MARK: - callUpdateProfileAPI
    func callUpdateProfileAPI() {
        
        self.vm?.view.showLoader()
        
        AF.upload(multipartFormData: { MultipartFormData  in
            
            for(key,value) in self.payload{
                MultipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
            
            if let img =  self.profileImg.image {
                if let imageData = img.jpegData(compressionQuality: 0.4) {
                    MultipartFormData.append(imageData, withName: "image", fileName: "\(Date()).jpeg", mimeType: "image/jpeg")
                }
            }
            
            
        }, to: "\(BASE_URL)user/\(ApiEndpoints.mobileeditprofile)").responseDecodable(of: ResetPasswordModel.self){ resp in
            
            switch resp.result{
            case let .success(data):
                print("AF.upload ===== >")
                
                self.showToast(message: data.msg ?? "")
                DispatchQueue.main.async {
                    self.key = "show"
                    self.changeProfilePicBtnView.isHidden = true
                    self.callAPI()
                }
                
                break
                
            case .failure(let encodingError):
                self.vm?.view.hideLoader()
                print("ERROR RESPONSE: \(encodingError)")
                
            }
            
        }
        
    }
    
}




extension EditProfileVC:UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let tempImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.profileImg.image = tempImage
        }
        
        self.pickerbool = true
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
    
    func openCemera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    
}


