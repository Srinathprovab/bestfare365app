//
//  ModifysearchVC.swift
//  BestFares365App
//
//  Created by FCI on 01/05/23.
//

import UIKit

class ModifysearchVC: BaseTableVC, OnewayViewModelDelegate {
    
    
    
    //MARK: - @IBOutlet
    @IBOutlet var holderView: UIView!
    @IBOutlet weak var logoHolderView: UIView!
    @IBOutlet weak var onewayView: UIView!
    @IBOutlet weak var onewaylbl: UILabel!
    @IBOutlet weak var onewayUL: UIView!
    @IBOutlet weak var onewayBtn: UIButton!
    @IBOutlet weak var rtView: UIView!
    @IBOutlet weak var rtlbl: UILabel!
    @IBOutlet weak var rtUL: UIView!
    @IBOutlet weak var rtBtn: UIButton!
    @IBOutlet weak var mcView: UIView!
    @IBOutlet weak var mclbl: UILabel!
    @IBOutlet weak var mcUL: UIView!
    @IBOutlet weak var mcBtn: UIButton!
    @IBOutlet weak var btnsView: UIStackView!
    @IBOutlet weak var btnsViewHeight: NSLayoutConstraint!
    @IBOutlet weak var logoBGViewHeight: NSLayoutConstraint!
    @IBOutlet weak var closeBtn: UIButton!
    
    
    
    //MARK: - VARIABLES SETUP
    static var newInstance: ModifysearchVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ModifysearchVC
        return vc
    }
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var viewmodel:OnewayViewModel?
    var hotelVM: SearchHotelViewModel?
    var flights = [[Flights]]()
    var keyStr = String()
    var isformvc = String()
    
    //MARK: - VIEW LOADING FUNCTION
    override func viewWillAppear(_ animated: Bool) {
        callSetupInitialView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableViewFromNotifaction(_:)), name: NSNotification.Name(rawValue: "reload"), object: nil)
    }
    
    
    @objc func reloadTableViewFromNotifaction(_ notify:NSNotification) {
        callSetupInitialView()
    }
    
    
    func callSetupInitialView(){
        
        if let tabselect = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            switch tabselect {
            case "Flight":
                
                btnsView.isHidden = false
                btnsViewHeight.constant = 30
                
                if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    switch journyType {
                    case "oneway":
                        setuupOneWayView()
                        break
                    case "circle":
                        setuupRTView()
                        break
                    case "multicity":
                        setuupMCView()
                        break
                    default:
                        break
                    }
                    
                }
                break
                
                
            default:
                break
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = OnewayViewModel(self)
    }
    
    
    //MARK: -INITIAL UI SETUP
    func setupUI() {
        
        logoHolderView.backgroundColor = .clear
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        self.holderView.backgroundColor = .black.withAlphaComponent(0.5)

        
        onewayView.backgroundColor = .clear
        setuplabels(lbl: onewaylbl, text: "One Way", textcolor: .WhiteColor, font: .sigvarbold(size: 16), align: .left)
        onewayUL.backgroundColor = .clear
        onewayBtn.setTitle("", for: .normal)
        onewayBtn.addTarget(self, action: #selector(didTapOnOneWayTabBtn(_:)), for: .touchUpInside)
        
        rtView.backgroundColor = .clear
        setuplabels(lbl: rtlbl, text: "Round Trip", textcolor: .WhiteColor, font: .sigvarbold(size: 16), align: .left)
        rtUL.backgroundColor = .clear
        rtBtn.setTitle("", for: .normal)
        rtBtn.addTarget(self, action: #selector(didTapOnRTTabBtn(_:)), for: .touchUpInside)
        
        mcView.backgroundColor = .clear
        setuplabels(lbl: mclbl, text: "Multi-City", textcolor: .WhiteColor, font: .sigvarbold(size: 16), align: .left)
        mcUL.backgroundColor = .clear
        mcBtn.setTitle("", for: .normal)
        mcBtn.addTarget(self, action: #selector(didTapOnMCTabBtn(_:)), for: .touchUpInside)
        
        closeBtn.isHidden = false
        closeBtn.setImage(UIImage(named: "close"), for: .normal)
//                          ?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        
        
        //MARK: REGISTER TVCELLS
        commonTableView.registerTVCells(["EmptyTVCell",
                                         "FromViewTVCell",
                                         "DepartDateViewTVCell",
                                         "ButtonTVCell",
                                         "TravellersViewTVCell",
                                         "MulticityTVCell"])
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        
        
    }
    
    
    @objc func closeScreen(){
        dismiss(animated: true)
    }
    
    
    //MARK: - SETUP ONEWAY TAB VIEW
    func setuupOneWayView() {
        onewayUL.backgroundColor = .TabSelectColor
        rtUL.backgroundColor = .clear
        mcUL.backgroundColor = .clear
        defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
        
        DispatchQueue.main.async {
            self.setupOneWayTableViewCells()
        }
    }
    
    
    //MARK: - SETUP ROUND TRIP TAB VIEW
    func setuupRTView() {
        
        
        onewayUL.backgroundColor = .clear
        rtUL.backgroundColor = .TabSelectColor
        mcUL.backgroundColor = .clear
        defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
        
        
        DispatchQueue.main.async {
            self.setupRoundTripTableViewCells()
        }
    }
    
    
    //MARK: - SETUP MULTICITY TAB VIEW
    func setuupMCView() {
        onewayUL.backgroundColor = .clear
        rtUL.backgroundColor = .clear
        mcUL.backgroundColor = .TabSelectColor
        defaults.set("multicity", forKey: UserDefaultsKeys.journeyType)
        
        DispatchQueue.main.async {
            self.setupMultiCityTripTableViewCells()
        }
    }
    
    @objc func didTapOnOneWayTabBtn(_ sender:UIButton) {
        if screenHeight > 835 {
            commonTableView.isScrollEnabled = false
        }
        setuupOneWayView()
        NotificationCenter.default.post(name: Notification.Name("reload"), object: "oneway")
    }
    
    @objc func didTapOnRTTabBtn(_ sender:UIButton) {
        if screenHeight > 835 {
            commonTableView.isScrollEnabled = false
        }
        setuupRTView()
        NotificationCenter.default.post(name: Notification.Name("reload"), object: "circle")
    }
    
    @objc func didTapOnMCTabBtn(_ sender:UIButton) {
        commonTableView.isScrollEnabled = true
        setuupMCView()
    }
    
    
    //MARK: - SETUP ONEWAY TRIP TABLE VIEW CELLS
    func setupOneWayTableViewCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .FromViewTVCell))
        tablerow.append(TableRow(key:"dep",cellType: .DepartDateViewTVCell))
        tablerow.append(TableRow(key:"flight",cellType: .TravellersViewTVCell))
        tablerow.append(TableRow(height:30,cellType: .EmptyTVCell))
        tablerow.append(TableRow(title:"Search Flights",bgColor: .ButtonColor,cellType: .ButtonTVCell))
        tablerow.append(TableRow(height:200,cellType: .EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    //MARK: - SETUP ROUND TRIP TABLE VIEW CELLS
    func setupRoundTripTableViewCells() {
        
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .FromViewTVCell))
        tablerow.append(TableRow(key:"return",cellType: .DepartDateViewTVCell))
        tablerow.append(TableRow(key:"flight",cellType: .TravellersViewTVCell))
        tablerow.append(TableRow(height:30,cellType: .EmptyTVCell))
        tablerow.append(TableRow(title:"Search Flights",bgColor: .ButtonColor,cellType: .ButtonTVCell))
        tablerow.append(TableRow(height:200,cellType: .EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - SETUP MULTI TRIP TABLE VIEW CELLS
    func setupMultiCityTripTableViewCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .MulticityTVCell))
        tablerow.append(TableRow(height:20,cellType: .EmptyTVCell))
        tablerow.append(TableRow(key:"flight",cellType: .TravellersViewTVCell))
        tablerow.append(TableRow(height:30,cellType: .EmptyTVCell))
        tablerow.append(TableRow(title:"Search Flights",bgColor: .ButtonColor,cellType: .ButtonTVCell))
        tablerow.append(TableRow(height:200,cellType: .EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    //MARK: - GO TO FROM CITY SELECT VC
    override func selectFromCityBtnAction(cell: FromViewTVCell) {
        gotoSelectFromCityVC(str: "From", key: "flight")
    }
    
    
    //MARK: - GO TO TO CITY SELECT VC
    override func selectToCityBtnAction(cell: FromViewTVCell) {
        gotoSelectFromCityVC(str: "To", key: "flight")
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
    
    //MARK: - GOTO ADD PASSENGER VC
    override func didTapOnAddTravellersBtnAction(cell: TravellersViewTVCell) {
        guard let vc = ChoosePassengerVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    //MARK: - GO TO CALENEDERVC
    override func didTapOndepartDateBtn(cell: DepartDateViewTVCell) {
        gotoCalenderVC()
    }
    
    //MARK: - GO TO CALENEDERVC
    override func didTapOnreturnDateBtn(cell: DepartDateViewTVCell) {
        gotoCalenderVC()
    }
    
    //MARK: - GO TO FROM CITY VC FUNCTION
    override func didTapOnFromCityBtn(cell: MulticityTVCell) {
        gotoSelectFromCityVC(str: "From", key: "flight")
    }
    
    
    //MARK: - GO TO FROM CITY VC FUNCTION
    override func didTapOnToCityBtn(cell: MulticityTVCell) {
        gotoSelectFromCityVC(str: "To", key: "flight")
    }
    
    
    //MARK: - GO TO CALENDERVC FUNCTION
    override func didTapOnDateBtn(cell: MulticityTVCell) {
        guard let vc = CalenderVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    //MARK: - SEARCH FLIGHT OR HOTEL BUTTON ACTION
    override func btnAction(cell: ButtonTVCell) {
        
        if cell.titlelbl.text == "Search Flights" {
            if let selectedJourneyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if selectedJourneyType == "oneway" {
                    callOneWayAPI()
                }else if selectedJourneyType == "circle"{
                    CALLROUNDTRIPAPI()
                }else {
                    CALLMULTICITYAPI()
                }
            }
        }
        
    }
    
    
    //MARK: -CALL ONE WAY TRIP API
    func callOneWayAPI() {
        
        payload.removeAll()
        if defaults.string(forKey:UserDefaultsKeys.fromCity) == "Select City" {
            showToast(message: "Please Select From City")
        }else if defaults.string(forKey:UserDefaultsKeys.toCity) == "Select City" {
            showToast(message: "Please Select To City")
        }else if defaults.string(forKey:UserDefaultsKeys.toCity) == defaults.string(forKey:UserDefaultsKeys.fromCity) {
            showToast(message: "Please Select Different Citys")
        }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == "Select Date" {
            showToast(message: "Please Select Departure Date")
        }else if defaults.string(forKey:UserDefaultsKeys.travellerDetails) == nil {
            showToast(message: "Add Traveller")
        }else{
            
            payload["flight_type"] = "international"
            payload["plus_minusfare"] = "notallow"
            payload["trip_type"] = defaults.string(forKey:UserDefaultsKeys.journeyType)
            payload["depature"] = defaults.string(forKey:UserDefaultsKeys.calDepDate)
            payload["return"] = ""
            payload["v_class"] = defaults.string(forKey:UserDefaultsKeys.selectClass)
            payload["r_class"] = ""
            payload["adult"] = defaults.string(forKey:UserDefaultsKeys.adultCount)
            payload["child"] = defaults.string(forKey:UserDefaultsKeys.childCount)
            payload["infant_child"] = defaults.string(forKey:UserDefaultsKeys.seatinfants)
            payload["infant"] = defaults.string(forKey:UserDefaultsKeys.lapinfants)
            payload["from"] = defaults.string(forKey:UserDefaultsKeys.fromCity)
            payload["from_loc_id"] = defaults.string(forKey:UserDefaultsKeys.fromlocid)
            payload["to"] = defaults.string(forKey:UserDefaultsKeys.toCity)
            payload["to_loc_id"] = defaults.string(forKey:UserDefaultsKeys.tolocid)
            payload["carrier"] = ""
            payload["search_flight"] = "search"
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            payload["selected_currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency)
            
            viewmodel?.CallGetOneWayFlightListAPI(dictParam: payload)
            
        }
        
    }
    
    
    //MARK: - ONE WAY TRIP API RESPONSE
    func getOneWayFlightList(response: OneWayModel) {
        
        defaults.set(response.search_id, forKey: UserDefaultsKeys.searchid)
        defaults.set(response.booking_source, forKey: UserDefaultsKeys.bookingsource)
        defaults.set(response.session_id, forKey: UserDefaultsKeys.sessionid)
        
        
        response.raw_flight_list?.flights.map({ i in
            flights = i
            oneWayFlights = i
        })
        
        bookingsource = response.booking_source ?? ""
        searchid = String(response.search_id ?? 0)
        sessionid = response.session_id ?? ""
        
        response.raw_flight_list?.flights?.forEach({ i in
            i.forEach { j in
                fcurrency = j.fareDetails?.b2c_PriceDetails?.currency ?? ""
                fcurrencySymbol = j.fareDetails?.b2c_PriceDetails?.currencySymbol ?? ""
            }
        })
        
        gotoFlightsResultVC()
        
    }
    
    
    //MARK: - CALL ROUND TRIP API
    func CALLROUNDTRIPAPI() {
        payload.removeAll()
        
        if defaults.string(forKey:UserDefaultsKeys.rfromCity) == "Select City" {
            showToast(message: "Please Select From City")
        }else if defaults.string(forKey:UserDefaultsKeys.rtoCity) == "Select City" {
            showToast(message: "Please Select To City")
        }else if defaults.string(forKey:UserDefaultsKeys.rtoCity) == defaults.string(forKey:UserDefaultsKeys.rfromCity) {
            showToast(message: "Please Select Different Citys")
        }else if defaults.string(forKey:UserDefaultsKeys.rcalDepDate) == "Select Date" {
            showToast(message: "Please Select Departure Date")
        }else if defaults.string(forKey:UserDefaultsKeys.rcalRetDate) == "Select Date" {
            showToast(message: "Please Select Return Date")
        }else if defaults.string(forKey:UserDefaultsKeys.rcalDepDate) == defaults.string(forKey:UserDefaultsKeys.rcalRetDate) {
            showToast(message: "Please Select Different Dates")
        }else if defaults.string(forKey:UserDefaultsKeys.rtravellerDetails) == nil {
            showToast(message: "Add Traveller")
        }else{
            
            payload["flight_type"] = "international"
            payload["plus_minusfare"] = "notallow"
            payload["trip_type"] = defaults.string(forKey:UserDefaultsKeys.journeyType)
            payload["depature"] = defaults.string(forKey:UserDefaultsKeys.rcalDepDate)
            payload["return"] = defaults.string(forKey:UserDefaultsKeys.rcalDepDate)
            payload["v_class"] = defaults.string(forKey:UserDefaultsKeys.rselectClass)
            payload["r_class"] = ""
            payload["adult"] = defaults.string(forKey:UserDefaultsKeys.radultCount)
            payload["child"] = defaults.string(forKey:UserDefaultsKeys.rchildCount)
            payload["infant_child"] = defaults.string(forKey:UserDefaultsKeys.rseatinfants)
            payload["infant"] = defaults.string(forKey:UserDefaultsKeys.rlapinfants)
            payload["from"] = defaults.string(forKey:UserDefaultsKeys.rfromCity)
            payload["from_loc_id"] = defaults.string(forKey:UserDefaultsKeys.rfromlocid)
            payload["to"] = defaults.string(forKey:UserDefaultsKeys.rtoCity)
            payload["to_loc_id"] = defaults.string(forKey:UserDefaultsKeys.rtolocid)
            payload["carrier"] = ""
            payload["search_flight"] = "search"
            payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
            payload["selected_currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency)
            
            viewmodel?.CallRoundTripApi(dictParam: payload)
            
        }
    }
    
    
    //MARK: - ROUND TRIP API RESPONSE
    func getRoundTripFlightList(response: OneWayModel) {
        
        defaults.set(response.search_id, forKey: UserDefaultsKeys.searchid)
        defaults.set(response.booking_source, forKey: UserDefaultsKeys.bookingsource)
        defaults.set(response.session_id, forKey: UserDefaultsKeys.sessionid)
        response.raw_flight_list?.flights.map({ i in
            roundTripFlights = i
            oneWayFlights = i
        })
        
        bookingsource = response.booking_source ?? ""
        searchid = String(response.search_id ?? 0)
        sessionid = response.session_id ?? ""
        gotoFlightsResultVC()
    }
    
    //MARK: -CALL MULTICITY TRIP API
    func CALLMULTICITYAPI() {
        
        payload["flight_type"] = "international"
        payload["plus_minusfare"] = "notallow"
        payload["trip_type"] = defaults.string(forKey:UserDefaultsKeys.journeyType)
        payload["depature"] = depatureDatesArray
        payload["return"] = ""
        payload["v_class"] = defaults.string(forKey:UserDefaultsKeys.rselectClass)
        payload["r_class"] = ""
        payload["adult"] = defaults.string(forKey:UserDefaultsKeys.madultCount)
        payload["child"] = defaults.string(forKey:UserDefaultsKeys.mchildCount)
        payload["infant_child"] = defaults.string(forKey:UserDefaultsKeys.mseatinfants)
        payload["infant"] = defaults.string(forKey:UserDefaultsKeys.mlapinfants)
        payload["from"] = fromCityNameArray
        payload["from_loc_id"] = fromlocidArray
        payload["to"] = toCityNameArray
        payload["to_loc_id"] = tolocidArray
        payload["search_flight"] = "search"
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["selected_currency"] = defaults.string(forKey:UserDefaultsKeys.selectedCurrency)
        
        
        do {
            let arrJson = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let theJSONText = NSString(data: arrJson, encoding: String.Encoding.utf8.rawValue)
            print(theJSONText ?? "")
            
            payload1["search_params"] = theJSONText
            viewmodel?.CallMultiCitySearchFlightList(dictParam: payload1)
            
        }catch let error as NSError{
            print(error.description)
        }
        
    }
    
    
    func getMulticityFlightList(response: OneWayModel) {
        
        defaults.set(response.search_id, forKey: UserDefaultsKeys.searchid)
        defaults.set(response.booking_source, forKey: UserDefaultsKeys.bookingsource)
        defaults.set(response.session_id, forKey: UserDefaultsKeys.sessionid)
        
        response.raw_flight_list?.flights.map({ i in
            roundTripFlights = i
            oneWayFlights = i
        })
        
        bookingsource = response.booking_source ?? ""
        searchid = String(response.search_id ?? 0)
        sessionid = response.session_id ?? ""
        
        gotoFlightsResultVC()
    }
    
    
    //MARK: - GO TO FLIGHT RESULT SCREEN
    func gotoFlightsResultVC() {
        guard let vc = FlightsResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    // MARK: - HOTEL RELATED STUFF
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
        tablerow.append(TableRow(height:300,cellType: .EmptyTVCell))
        
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
    
    override func didTapOnNoOfPersonsBtn(cell:DepartDateViewTVCell){
        guard let vc = AddRoomsVCViewController.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
    func CALL_HOTEL_SEARCH_API() {
        
        payload.removeAll()
        payload1.removeAll()
        payload["city"] = defaults.string(forKey: UserDefaultsKeys.hotelCity)
        payload["hotel_destination"] = defaults.string(forKey: UserDefaultsKeys.hoteldestinationCode)
        payload["hotel_checkin"] = defaults.string(forKey: UserDefaultsKeys.checkin)
        payload["hotel_checkout"] = defaults.string(forKey: UserDefaultsKeys.checkout)
        payload["rooms"] = "1"
        payload["adult"] = ["2"]
        payload["child"] = ["0"]
        payload["childAge_1"] = ["0"]
        payload["nationality"] = "IN"
        
        
        do{
            
            let jsonData = try JSONSerialization.data(withJSONObject: payload, options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonStringData =  NSString(data: jsonData as Data, encoding: NSUTF8StringEncoding)! as String
            print(jsonStringData)
            
            if defaults.string(forKey: UserDefaultsKeys.hotelCity) == "Select City or Hotel" {
                showToast(message: "Select City or Hotel")
            }else if defaults.string(forKey: UserDefaultsKeys.checkin) == "Select Date" {
                showToast(message: "Select Check In Date")
            }else if defaults.string(forKey: UserDefaultsKeys.checkout) == "Select Date" {
                showToast(message: "Select Check Out Date")
            }else if defaults.string(forKey: UserDefaultsKeys.checkin) == defaults.string(forKey: UserDefaultsKeys.checkout) {
                showToast(message: "Dates Should not same")
            }else {
                
                
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
            guard let vc = HotelSearchResultVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    
}
