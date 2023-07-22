//
//  SelectFromCityVC.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit
import Alamofire


class SelectFromCityVC: BaseTableVC, SelectCityViewModelProtocal, HotelCityViewModelDelegte {
    
    
    @IBOutlet weak var searchTextfieldHolderView: UIView!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    var filtered:[SelectCityModel] = []
    var cityList:[SelectCityModel] = []
    var hfiltered:[HotelCityModel] = []
    var hotelCityList:[HotelCityModel] = []
    var cityViewModel: SelectCityViewModel?
    var hotelCityVM: HotelCityViewModel?
    var tablerow = [TableRow]()
    var titleStr = String()
    var payload = [String:Any]()
    var isSearchBool = Bool()
    var searchText = String()
    var celltag = Int()
    var key = String()
    
    
    static var newInstance: SelectFromCityVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectFromCityVC
        return vc
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        searchTF.becomeFirstResponder()
        
        if key == "flight" {
            CallShowCityListAPI(str: "")
        }else {
            callHotelOrCityAPI(str: "")
        }
        
        self.celltag = Int(defaults.string(forKey: UserDefaultsKeys.cellTag) ?? "0") ?? 0
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV(notification:)), name: NSNotification.Name("reloadTV"), object: nil)
        if screenHeight < 835 {
            navHeight.constant = 110
        }else {
            navHeight.constant = 160
        }
        
    }
    
    
    @objc func reloadTV(notification:NSNotification) {
        if key == "flight" {
            CallShowCityListAPI(str: "")
        }else {
            callHotelOrCityAPI(str: "")
        }
    }
    
    
    //MARK: - callHotelOrCityAPI
    func callHotelOrCityAPI(str:String) {
        payload["term"] = str
        hotelCityVM?.CALL_HOTEL_CITY_API(dictParam: payload)
    }
    
    
    func hotelCityList(response: [HotelCityModel]) {
        self.hotelCityList = response
        self.hfiltered = response
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    
    
    
    //MARK: - Call Show City ListA PI
    func CallShowCityListAPI(str:String) {
        payload["term"] = str
        payload["input_src"] = "from"
        cityViewModel?.CallShowCityListAPI(dictParam: payload)
    }
    
    
    func ShowCityList(response: [SelectCityModel]) {
        
        self.cityList = response
        self.filtered = response
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        cityViewModel = SelectCityViewModel(self)
        hotelCityVM = HotelCityViewModel(self)
        
    }
    
    func setupUI() {
        
        nav.titlelbl.textColor = .AppLabelColor
        if key == "flight" {
            nav.titlelbl.text = "Choose a destination"
            searchTF.placeholder = "Enter Location or Airport name"
            
        }else {
            nav.titlelbl.text = "Choose a hotel"
            searchTF.placeholder = "Region city/ area  location"
            
        }
        nav.backImg.image = UIImage(named: "leftarrow")?.withRenderingMode(.alwaysOriginal)
        nav.backBtn.addTarget(self, action: #selector(dismisVC(_:)), for: .touchUpInside)
        setupViews(v: searchTextfieldHolderView, radius: 6, color: HexColor("#F9F9F9"))
        nav.contentView.backgroundColor = .WhiteColor
        
        searchImg.image = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        searchTF.backgroundColor = HexColor("#F9F9F9")
        searchTF.setLeftPaddingPoints(20)
        searchTF.font = UIFont.poppinsRegular(size: 13)
        
        searchTF.addTarget(self, action: #selector(searchTextChanged(_:)), for: .editingChanged)
        
        
        setupLabels(lbl: titlelbl, text: "Popular Airports", textcolor: .AppLabelColor, font: .poppinsSemiBold(size: 18))
        commonTableView.register(UINib(nibName: "FromCityTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        commonTableView.separatorStyle = .singleLine
        commonTableView.separatorColor = .lightGray
    }
    
    
    
    @objc func dismisVC(_ sender:UIButton) {
        self.dismiss(animated: true)
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 1
        v.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    
    
    var searchTimer: Timer?
    
    @objc func searchTextChanged(_ sender: UITextField) {
        searchText = sender.text ?? ""
        
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        } else {
            isSearchBool = true
            filterContentForSearchText(searchText)
            
        }
        
        if key == "flight" {
            // Invalidate previous timer if there is any
            searchTimer?.invalidate()
            // Start a new timer with a delay of 0.5 seconds
            searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
                guard let self = self else { return }
                self.CallShowCityListAPI(str: self.searchText)
            }
        } else {
            // Invalidate previous timer if there is any
            searchTimer?.invalidate()
            // Start a new timer with a delay of 0.5 seconds
            searchTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
                guard let self = self else { return }
                self.callHotelOrCityAPI(str: self.searchText)
            }
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        filtered.removeAll()
        hfiltered.removeAll()
        
        if key == "flight" {
            filtered = self.cityList.filter { thing in
                return "\(thing.lable?.lowercased() ?? "")".contains(searchText.lowercased())
            }
        } else {
            hfiltered = self.hotelCityList.filter { thing in
                return "\(thing.label?.lowercased() ?? "")".contains(searchText.lowercased())
            }
        }
        
        DispatchQueue.main.async {
            self.commonTableView.reloadData()
        }
    }
    
    
    
    
    func gotoHomeVC() {
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.keyStr = "SelectFromCityVC"
        vc.isformvc = "city"
        self.present(vc, animated: false)
    }
    
    @objc func deleteCity(_ sender:UIButton) {
        print("deleteCity")
    }
    
    
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}


extension SelectFromCityVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //check search text & original text
        
        if key == "flight" {
            if( isSearchBool == true){
                return filtered.count
            }else{
                return cityList.count
            }
        }else {
            if( isSearchBool == true){
                return hfiltered.count
            }else{
                return hotelCityList.count
            }
        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FromCityTVCell
        cell.selectionStyle = .none
        var ccell = UITableViewCell()
        
        if key == "flight" {
            if( isSearchBool == true){
                let dict = filtered[indexPath.row]
                cell.titlelbl.text = dict.lable
                cell.subTitlelbl.text = dict.airport_code
                cell.id = dict.origin ?? ""
                cell.airportCode = dict.airport_name ?? ""
                cell.airportcity = dict.lable ?? ""
                cell.closeBtn.addTarget(self, action: #selector(deleteCity(_:)), for: .touchUpInside)
            }else{
                let dict = cityList[indexPath.row]
                cell.titlelbl.text = dict.lable
                cell.subTitlelbl.text = dict.airport_code
                cell.id = dict.origin ?? ""
                cell.airportCode = dict.airport_name ?? ""
                cell.airportcity = dict.lable ?? ""
                cell.closeBtn.addTarget(self, action: #selector(deleteCity(_:)), for: .touchUpInside)
                
            }
            
            ccell = cell
        }else {
            if( isSearchBool == true){
                let dict = hfiltered[indexPath.row]
                cell.titlelbl.text = dict.label
                cell.subTitlelbl.text = dict.value
                cell.id = dict.id ?? ""
                
            }else{
                let dict = hotelCityList[indexPath.row]
                cell.titlelbl.text = dict.label
                cell.subTitlelbl.text = dict.value
                cell.id = dict.id ?? ""
            }
            
            ccell = cell
        }
        return ccell
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? FromCityTVCell {
            
            
            if let selectedtab = defaults.string(forKey: UserDefaultsKeys.tabselect) {
                if selectedtab == "Flight" {
                    if let selectedJourneyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                        if selectedJourneyType == "oneway" {
                            if titleStr == "From" {
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.fromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.fromlocid)
                                defaults.set(cell.airportCode , forKey: UserDefaultsKeys.fromairportCode)
                                defaults.set(cell.airportcity , forKey: UserDefaultsKeys.fromairport_city)
                                
                            }else {
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.toCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.tolocid)
                                defaults.set(cell.airportCode , forKey: UserDefaultsKeys.toairportCode)
                                defaults.set(cell.airportcity , forKey: UserDefaultsKeys.toairport_city)
                                
                            }
                        }else if selectedJourneyType == "circle" {
                            if titleStr == "From" {
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.rfromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.rfromlocid)
                                defaults.set(cell.airportCode , forKey: UserDefaultsKeys.rfromairportCode)
                                defaults.set(cell.airportcity , forKey: UserDefaultsKeys.rfromairport_city)
                                
                                
                            }else {
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.rtoCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.rtolocid)
                                defaults.set(cell.airportCode , forKey: UserDefaultsKeys.rtoairportCode)
                                defaults.set(cell.airportcity , forKey: UserDefaultsKeys.rtoairport_city)
                                
                            }
                        }else {
                            if titleStr == "From" {
                                
                                
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.mfromCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.mfromlocid)
                                defaults.set(cell.airportCode , forKey: UserDefaultsKeys.mfromairportCode)
                                defaults.set(cell.value , forKey: UserDefaultsKeys.mfromCityValue)
                                defaults.set(cell.airportcity , forKey: UserDefaultsKeys.fromairport_city)
                                
                                
                                fromCityNameArray[self.celltag] = cell.titlelbl.text ?? ""
                                fromCityShortNameArray[self.celltag] = cell.airportCode
                                //                                mfromCityNameArray[self.celltag] = cell.airportcity
                                //                                mfromCityShortNameArray[self.celltag] = cell.subTitlelbl.text ?? ""
                                
                                fromCityArray[self.celltag] = cell.titlelbl.text ?? ""
                                fromlocidArray[self.celltag] = cell.id
                                
                            }else {
                                defaults.set(cell.titlelbl.text ?? "", forKey: UserDefaultsKeys.mtoCity)
                                defaults.set(cell.id , forKey: UserDefaultsKeys.mtolocid)
                                defaults.set(cell.airportCode , forKey: UserDefaultsKeys.mtoairportCode)
                                defaults.set(cell.value , forKey: UserDefaultsKeys.mtoCityValue)
                                defaults.set(cell.airportcity , forKey: UserDefaultsKeys.mtoairport_city)
                                
                                
                                toCityNameArray[self.celltag] = cell.titlelbl.text ?? ""
                                toCityShortNameArray[self.celltag] = cell.airportCode
                                //                                mtoCityNameArray[self.celltag] = cell.airportcity
                                //                                mtoCityShortNameArray[self.celltag] = cell.subTitlelbl.text ?? ""
                                
                                
                                toCityArray[self.celltag] = cell.titlelbl.text ?? ""
                                tolocidArray[self.celltag] = cell.id
                                
                            }
                        }
                    }
                    
                    
                    
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    //  self.gotoHomeVC()
                    self.dismiss(animated: true)
                }
                else {
                    
                    
                    defaults.set(hotelCityList[indexPath.row].value, forKey: UserDefaultsKeys.hotelCity)
                    defaults.set(hotelCityList[indexPath.row].id, forKey: UserDefaultsKeys.hoteldestinationCode)
                    
                    NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)
                    self.dismiss(animated: true)
                }
            }
        }
        
        
    }
}
