//
//  ModifyHotelSearchVC.swift
//  BestFares365App
//
//  Created by FCI on 15/03/23.
//

import UIKit

class ModifyHotelSearchVC: BaseTableVC, SearchHotelViewModelDelegate {
    
    @IBOutlet weak var closeImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    
    static var newInstance: ModifyHotelSearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifyHotelSearchVC
        return vc
    }
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var hotelVM: SearchHotelViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        hotelVM = SearchHotelViewModel(self)
    }
    
    func setupUI() {
        self.view.backgroundColor = .black.withAlphaComponent(0.6)
        setuplabels(lbl: titlelbl, text: "Modify Search", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 18), align: .center)
        closeImg.image = UIImage(named: "close")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        closeBtn.setTitle("", for: .normal)
        
        //MARK: REGISTER TVCELLS
        commonTableView.registerTVCells(["EmptyTVCell","FromViewTVCell","DepartDateViewTVCell","ButtonTVCell","TravellersViewTVCell","MulticityTVCell"])
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        setupHolteSearchTVCells()
    }
    
    
    //MARK:- SETUP HOTEL SEARCH TABLE VIEW CELLS
    func setupHolteSearchTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(key:"hotel",cellType: .TravellersViewTVCell))
        tablerow.append(TableRow(height:16,cellType: .EmptyTVCell))
        tablerow.append(TableRow(key:"hotelcheckin",cellType: .DepartDateViewTVCell))
        tablerow.append(TableRow(height:16,cellType: .EmptyTVCell))
        tablerow.append(TableRow(key:"hotelnights",cellType: .DepartDateViewTVCell))
        tablerow.append(TableRow(height:30,cellType: .EmptyTVCell))
        tablerow.append(TableRow(title:"Search Hotels",bgColor: .ButtonColor,cellType: .ButtonTVCell))
        tablerow.append(TableRow(key:"modifyhotel", height:100,cellType: .EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    //MARK: SELECT CITY OR HOTEL TAP FUNCTION
    override func didTapSelectHotelOrCity(cell:TravellersViewTVCell){
        gotoSelectFromCityVC(str: "Choose a hotel", key: "hotel")
    }
    
    
    override func didTapOnCheckinBtn(cell:DepartDateViewTVCell){
        gotoCalenderVC()
    }
    
    
    override func didTapOnCheckoutBtn(cell:DepartDateViewTVCell){
        gotoCalenderVC()
    }
    
    
    override func didTapOnNoOfNightsBtn(cell:DepartDateViewTVCell){
        print("didTapOnNoOfNightsBtn \(cell.noofNightsSelected)")
        
    }
    
    
    //MARK: - GO TO SELECT CITY VC
    func gotoSelectFromCityVC(str:String,key:String) {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titleStr = str
        vc.key = key
        self.present(vc, animated: false)
    }
    
    //MARK: - GO TO CALENEDERVC
    func gotoCalenderVC() {
        guard let vc = CalenderVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    //MARK: - didTapOnNoOfPersonsBtn
    override func didTapOnNoOfPersonsBtn(cell:DepartDateViewTVCell){
        guard let vc = AddRoomsGuestsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
        
    }
    
    //MARK: - CALL_HOTEL_SEARCH_API
    func CALL_HOTEL_SEARCH_API() {
        
        payload.removeAll()
        payload1.removeAll()
        
        payload["city"] = defaults.string(forKey: UserDefaultsKeys.hotelCity)
        payload["hotel_destination"] = defaults.string(forKey: UserDefaultsKeys.hoteldestinationCode)
        payload["hotel_checkin"] = defaults.string(forKey: UserDefaultsKeys.checkin)
        payload["hotel_checkout"] = defaults.string(forKey: UserDefaultsKeys.checkout)
        payload["rooms"] = "1"
        payload["adult"] = ["4"]
        payload["child"] = ["1"]
        payload["childAge_1"] = ["0"]
        payload["nationality"] = "IN"
        
        
        do{
            
            let jsonData = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonStringData =  NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding)! as String
            print(jsonStringData)
            
            if defaults.string(forKey: UserDefaultsKeys.hotelCity) == "Select City or Hotel" {
                showToast(message: "")
            }else if defaults.string(forKey: UserDefaultsKeys.checkin) == "Select Date" {
                showToast(message: "")
            }else if defaults.string(forKey: UserDefaultsKeys.checkout) == "Select Date" {
                showToast(message: "")
            }else {
                BASE_URL = "https://bestfares365.com/mobile_webservices1/mobile/index.php/"
                payload1["search_params"] = jsonStringData
                hotelVM?.CALL_HOTEL_SEARCH_API(dictParam: payload1)
            }
            
        }catch{
            print(error.localizedDescription)
        }
        
    }
    
    
    func hotelSearchdetails(response: HotelSearchModel) {
        hotelList = response.data?.raw_hotel_list ?? []
        hsearch_id = String(response.data?.search_id ?? 0)
        
        if response.status == 1 {
            gotoHotelSearchResultVC()
        }
    }
    
    
    func gotoHotelSearchResultVC() {
        guard let vc = HotelSearchResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
}
