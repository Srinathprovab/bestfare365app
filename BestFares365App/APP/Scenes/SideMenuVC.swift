//
//  SideMenuVC.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit
var img1 = String()


class SideMenuVC: BaseTableVC, MyProfileViewModelDelegate {
    
    
    @IBOutlet weak var logoutBtnView: UIView!
    @IBOutlet weak var logoutlbl: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    
    static var newInstance: SideMenuVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SideMenuVC
        return vc
    }
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var vm:MyProfileViewModel?
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadmenu(_:)), name: NSNotification.Name(rawValue: "reloadmenu"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(callMenuApi(_:)), name: NSNotification.Name(rawValue: "callMenuApi"), object: nil)
        
    }
    
    @objc func callMenuApi(_ notify:NSNotification) {
        callapi()
    }
    
    
    func callapi(){
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid)
        vm?.CALL_GET_PROFILE_DETAILS_API(dictParam: payload)
    }
    
    
    
    func profileDetails(response: MyProfileModel) {
        profileDetailsArray = response
        img1 = response.profile_image ?? ""
        setupMenuTVCells()
    }
    
    
    @objc func reloadmenu(_ notify:NSNotification) {
        logoutBtnView.isHidden = false
        callapi()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        
        vm = MyProfileViewModel(self)
        
        setupUI()
    }
    
    
    func setupUI(){
        
        commonTableView.isScrollEnabled = false
        logoutBtnView.backgroundColor = HexColor("#003399")
        logoutBtnView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 5)
        setuplabels(lbl: logoutlbl, text: "Logout", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 18), align: .center)
        logoutBtnView.isHidden = true
        if defaults.bool(forKey: sessionMgrDefaults.loggedInStatus) == true {
            logoutBtnView.isHidden = false
        }
        commonTableView.registerTVCells(["MenuBGTVCell","MenuTVCell","EmptyTVCell"])
    }
    
    
    
    func setupMenuTVCells() {
        
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.MenuBGTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        if defaults.bool(forKey: sessionMgrDefaults.loggedInStatus) == true {
            tablerow.append(TableRow(title:"My Account",key: "menu", image: "myprofile",cellType:.MenuTVCell))
            tablerow.append(TableRow(title:"My Bookings",key: "menu", image: "mybookings",cellType:.MenuTVCell))
            
        }
        tablerow.append(TableRow(title:"About Us",key: "menu", image: "mybookings",cellType:.MenuTVCell))
        tablerow.append(TableRow(title:"Privacy Policy",key: "menu", image: "mybookings",cellType:.MenuTVCell))
        tablerow.append(TableRow(title:"Terms & Conditions",key: "menu", image: "mybookings",cellType:.MenuTVCell))
        tablerow.append(TableRow(title:"Refund Policy",key: "menu", image: "mybookings",cellType:.MenuTVCell))
        tablerow.append(TableRow(title:"Cancellation & Refund Policy",key: "menu", image: "mybookings",cellType:.MenuTVCell))
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnLoginBtn(cell: MenuBGTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.isVcFrom = "sidemenu"
        present(vc, animated: true)
    }
    
    override func didTapOnEditProfileBtn(cell: MenuBGTVCell) {
        gotoEditProfileVC(str: "edit")
    }
    
    
    func gotoEditProfileVC(str:String) {
        guard let vc = EditProfileVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = str
        present(vc, animated: true)
    }
    
    
    func gotoAboutUsVC(str:String) {
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = str
        present(vc, animated: true)
    }
    
    
    @IBAction func didTapOnLogoutBtn(_ sender: Any) {
        defaults.set(false, forKey: sessionMgrDefaults.loggedInStatus)
        defaults.setValue("0", forKey: UserDefaultsKeys.userid)
        logoutBtnView.isHidden = true
        setupMenuTVCells()
    }
    
}



extension SideMenuVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MenuTVCell {
            print(cell.titlelbl.text)
            switch cell.titlelbl.text {
                
            case "My Account":
                gotoEditProfileVC(str: "show")
                break
                
                
            case "About Us":
                gotoAboutUsVC(str: "aboutus")
                break
                
            case "Privacy Policy":
                gotoAboutUsVC(str: "privacy")
                break
                
                
            case "Terms & Conditions":
                gotoAboutUsVC(str: "terms")
                break
                
                
            case "Refund Policy":
                gotoAboutUsVC(str: "refund")
                break
                
            case "Cancellation & Refund Policy":
                gotoAboutUsVC(str: "cancellation")
                break
                
                
                
                
            default:
                break
            }
        }
    }
    
    
    
    
}
