//
//  ContinueToPaymentVC.swift
//  BestFares365App
//
//  Created by FCI on 31/10/22.
//

import UIKit
import CoreData

class ContinueToPaymentVC: BaseTableVC, MobilePreBookingViewModelDelegate {
    
    @IBOutlet weak var holderView: UIView!

    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var sessionTimerView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    
    
   
    var timer: Timer?
    var totalTime = 1
    var cart_global_id = String()
    var search_access_key = String()
    var sd = [SegmentSummary]()
    var price = String()
    static var newInstance: ContinueToPaymentVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ContinueToPaymentVC
        return vc
    }
    var tablerow = [TableRow]()
    var text1 = "To avois last minutesuprises, fly in out without any majoor hitches, track your service receove timely update and scedule reminder."
    
    var text2 = "To avois last minutesuprises, fly in out without any majoor hitches, track your service receove timely update and scedule reminder more information"
    var payload = [String:Any]()
    //    var searchid = String()
    var token = String()
    var tokenkey = String()
    var bookingsource = String()
    var sessionid = String()
    var viewmodel:MobilePreBookingViewModel?
    var isFromVC = String()
    var mobileNo = String()
    var billing_email = String()
    var adultsCount = Int()
    var childCount = Int()
    var infantsCount = Int()
    
    var fnameA = [String]()
    var passengertypeA = [String]()
    var title2A = [String]()
    var mnameA = [String]()
    var lnameA = [String]()
    var dobA = [String]()
    var passportNoA = [String]()
    var countryCodeA = [String]()
    var genderA = [String]()
    var passportexpiryA = [String]()
    var passportissuingcountryA = [String]()
    var passportNationalityA = [String]()
    var middleNameA = [String]()
    var leadPassengerA = [String]()
    var passportExpireDayA = [String]()
    var passportExpireMonthA = [String]()
    var passportExpireYearA = [String]()
    var passengerPassportExpiryDateA = [String]()
    
    var secureBookigAPIKey = Bool()
    
    override func viewWillDisappear(_ animated: Bool) {
        BASE_URL = BASE_URL1
    }
    
    override func viewWillAppear(_ animated: Bool) {
        secureBookigAPIKey = false
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.seatinfants) ?? "0") ?? 0
                
            }else if journeyType == "circle"{
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rseatinfants) ?? "0") ?? 0
            }else {
                
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                infantsCount = Int(defaults.string(forKey: UserDefaultsKeys.mseatinfants) ?? "0") ?? 0
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadmenu(_:)), name: NSNotification.Name(rawValue: "reloadmenu"), object: nil)
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadmenu(_:)), name: NSNotification.Name(rawValue: "reload"), object: nil)
        
        
        if callapibool == true {
            holderView.isHidden = true
            DispatchQueue.main.async {
                self.fetchCoreDataValues()
                self.callAPI()
            }
        }
        
    }
    
    
    
    //MARK: - FETCHING COREDATA VALUES
    func fetchCoreDataValues() {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
        //request.predicate = NSPredicate(format: "age = %@", "21")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            print(result)
            details = result
            
            DispatchQueue.main.async {[self] in
                //setupTV()
            }
            
        } catch {
            print("Failed")
        }
    }
    
    
    //MARK: - call get Mobile Booking Details API
    func callAPI() {
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["selectedResult"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
        payload["session_id"] = defaults.string(forKey: UserDefaultsKeys.sessionid)
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        
        viewmodel?.CALL_MOBILE_BOKKING_API(dictParam: payload)
    }
    
   
    func getMobileBookingDetails(response: MobilePreBookingModel) {
        
        holderView.isHidden = false
        cart_global_id = String(response.data?.cart_global_id ?? 0) ?? ""
        search_access_key = response.data?.search_access_key ?? ""
        price = "\(response.data?.pre_booking_summery?.fareDetails?.b2c_PriceDetails?.currencySymbol ?? "") \(response.data?.pre_booking_summery?.fareDetails?.b2c_PriceDetails?.baseFare ?? 0)"
        sd = response.data?.pre_booking_summery?.segmentSummary ?? []
        phoneCodeArray = response.data?.phone_code ?? []
        
        BaseFare = "\(response.data?.pre_booking_summery?.fareDetails?.b2c_PriceDetails?.baseFare ?? 0)"
        TotalTax = "\(response.data?.pre_booking_summery?.fareDetails?.b2c_PriceDetails?.totalTax ?? 0)"
        TotalFare = "\(response.data?.pre_booking_summery?.fareDetails?.b2c_PriceDetails?.totalFare ?? 0)"
        
        
        setuupFareSummeryDetails()
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    @objc func reloadmenu(_ notify:NSNotification) {
        setupTVCells()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = MobilePreBookingViewModel(self)
        
    }
    
    
    
    //MARK: SCREEN INITIAL SETUP
    func setupTvcellByDependOnJournyType() {
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            switch journyType {
            case "oneway":
                setuplabels(lbl: nav.titlelbl, text: "\(defaults.string(forKey: UserDefaultsKeys.fromairport_city) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.toairport_city) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20), align: .center)
                
                setuplabels(lbl: nav.datelbl, text: "On \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM"))\n\(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 18), align: .center)
                
                
                break
            case "circle":
                
                setuplabels(lbl: nav.titlelbl, text: "\(defaults.string(forKey: UserDefaultsKeys.rfromairport_city) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.rtoairport_city) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20), align: .center)
                
                setuplabels(lbl: nav.datelbl, text: "On \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.rcalDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM")) & Return \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.rcalRetDate) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM"))\n\(defaults.string(forKey: UserDefaultsKeys.rtravellerDetails) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 18), align: .center)
                
                
                break
            case "multicity":
                
                
                setuplabels(lbl: nav.titlelbl, text: "\(defaults.string(forKey: UserDefaultsKeys.mfromairport_city) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.mtoairport_city) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20), align: .center)
                
                setuplabels(lbl: nav.datelbl, text: "On:\(defaults.string(forKey: UserDefaultsKeys.mcalDepDate) ?? "") \(defaults.string(forKey: UserDefaultsKeys.mtravellerDetails) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 20), align: .center)
                
                
                break
            default:
                break
            }
        }
        
    }
    
    
    //MARK:  SETUP UI
    func setupUI() {
        setupTvcellByDependOnJournyType()
        nav.datelbl.isHidden = false
        nav.backImg.image = UIImage(named: "leftarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        nav.backBtn.addTarget(self, action: #selector(dismisVC(_:)), for: .touchUpInside)
        if screenHeight < 835 {
            navHeight.constant = 150
        }else {
            navHeight.constant = 180
        }
        
        sessionTimerView.isHidden = true
        sessionTimerView.backgroundColor = .WhiteColor
        sessionTimerView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 5)
        setuplabels(lbl: titlelbl, text: "Your Session Expires In : ", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16), align: .left)
        setuplabels(lbl: subtitlelbl, text: "", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16), align: .left)
        
        commonTableView.isHidden = true
        //MARK:- REGISTER TABLE VIEW CALLS
        commonTableView.registerTVCells(["FlightResultTVCell",
                                         "EmptyTVCell",
                                         "ButtonTVCell",
                                         "TDetailsLoginTVCell",
                                         "CheckinBaggageTVCell",
                                         "ExtraBaggagesTVCell",
                                         "PassengerDetailsTVCell",
                                         "ContactDetailsTVCell",
                                         "FareSummaryTVCell",
                                         "RoundTripTVCell",
                                         "CharityTVCell",
                                         "AddAdultTravellerTVCell",
                                         "AddChildTravellerTVCell",
                                         "AddInfantaTravellerTVCell",
                                         "SeatSelectionTVCell",
                                         "AddTravellerTVCell"])
        
    }
    
    //MARK: DISMISS VIEW
    @objc func dismisVC(_ sender:UIButton) {
        callapibool = false
        if secureBookigAPIKey == true {
            guard let vc = HomeVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: false)
        }else {
            self.dismiss(animated: true)
        }
        
    }
    
    
    
    //MARK: APPEND TABLE VIEW CELLS
    func setupTVCells() {
        sessionTimerView.isHidden = false
        startTimer()
        commonTableView.isHidden = false
        tablerow.removeAll()
        
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            switch journyType {
            case "oneway":
                
                sd.forEach { k in
                    tablerow.append(TableRow(
                        fromTime:k.originDetails?._DateTime,
                        toTime: k.destinationDetails?._DateTime,
                        fromCity: k.originDetails?.cityName,
                        toCity: k.destinationDetails?.cityName,
                        noosStops: String(k.totalStops ?? 0),
                        airlineslogo: k.airlineDetails?.flightImage,
                        airlinesname: k.airlineDetails?.airlineName,
                        airlinesCode: "(\(k.airlineDetails?.fareClass ?? "") \(k.airlineDetails?.flightNumber ?? ""))",
                        seatsLeft: "\(k.seatLeft ?? 0)",
                        baggage: k.originDetails?.baggage,
                        price: self.price,
                        travelTime: k.totalDuaration,
                        key: "fd",
                        cellType:.FlightResultTVCell))
                }
                
                break
            case "circle","multicity":
                
                tablerow.append(TableRow(
                    price: self.price,
                    key: "fd",
                    moreData:sd,
                    cellType:.RoundTripTVCell))
                
                break
                
                
            default:
                break
            }
        }
        
        
        if defaults.bool(forKey: sessionMgrDefaults.loggedInStatus) == false {
            tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        }
        
        tablerow.append(TableRow(cellType:.CheckinBaggageTVCell))
        tablerow.append(TableRow(cellType:.AddAdultTravellerTVCell))
        if childCount != 0 {
            tablerow.append(TableRow(cellType:.AddChildTravellerTVCell))
        }
        if infantsCount != 0 {
            tablerow.append(TableRow(cellType:.AddInfantaTravellerTVCell))
        }
        tablerow.append(TableRow(title:"Get Flight Details Through SMS",subTitle: text1, image:"sms",cellType:.CharityTVCell))
        tablerow.append(TableRow(title:"Charity",subTitle: text2, image:"charity",cellType:.CharityTVCell))
        //   tablerow.append(TableRow(cellType:.SeatSelectionTVCell))
        tablerow.append(TableRow(cellType:.ContactDetailsTVCell))
        tablerow.append(TableRow(cellType:.FareSummaryTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
    }
    
    
    override func didTapOnLoginBtn(cell: TDetailsLoginTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.isVcFrom = "ContinueToPaymentVC"
        present(vc, animated: true)
    }
    
    override func didTapOnSelectPassengerBtn(cell: ExtraBaggagesTVCell) {
        print("didTapOnSelectPassengerBtn")
    }
    
    override func didTapOnSelectAdultTraveller(Cell: AddAdultsOrGuestTVCell) {
        print("didTapOnSelectAdultTraveller")
    }
    
    
    override func didTapOnAddAdultBtn(cell: AddAdultTravellerTVCell) {
        gotoAddTravellerDetailsVC(passengertype: "Adult", key: "add", id: "")
    }
    
    override func didTapOnAddChildBtn(cell: AddChildTravellerTVCell) {
        gotoAddTravellerDetailsVC(passengertype: "Children", key: "add", id: "")
    }
    override func didTapOnAddInfantaBtn(cell: AddInfantaTravellerTVCell) {
        gotoAddTravellerDetailsVC(passengertype: "Infantas", key: "add", id: "")
    }
    
    
    override func didTapOnEditTraveller(cell:AddAdultsOrGuestTVCell){
        gotoAddTravellerDetailsVC(passengertype: cell.passengerType ?? "", key: "edit", id: cell.travellerId)
    }
    
    
    override func didTapOndeleteTravellerBtnAction(cell:AddAdultsOrGuestTVCell){
        //  deleteRecords(index: cell.indexPath?.row ?? 0, id: cell.travellerId)
    }
    
    
    func gotoAddTravellerDetailsVC(passengertype:String,key:String,id:String){
        guard let vc = AddTravellerDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.passenger_type = passengertype
        vc.key = key
        vc.passenger_type = passengertype
        vc.id = id
        present(vc, animated: true)
    }
    
    
    
    override func editingChanged(tf: UITextField) {
        if tf.tag == 1 {
            self.billing_email = tf.text ?? ""
        }else {
            self.mobileNo = tf.text ?? ""
        }
    }
    
    var country_code = String()
    override func didTapoNCountryCodeBtn(cell: ContactDetailsTVCell) {
        country_code = cell.countryCodelbl.text ?? ""
    }
    
    
    
    override func addCharityBtnAction(cell: CharityTVCell) {
        print(cell.totalPerBookingValurlbl.text)
    }
    
    override func didTapOnMoreInformationBtnAction(cell: CharityTVCell) {
        print(cell.totalPerBookingValurlbl.text)
    }
    
    
    override func didTapOnChooseYourSeatBtn(cell: SeatSelectionTVCell) {
        print(cell.titlelbl.text)
    }
    
    //MARK: SHOW FLIGHT DETAILS ACTION
    override func didTapOnShowFlightDetails(cell: FlightResultTVCell) {
        // flightcellIndex = cell.indexPath?.row ?? 0
        flightcellIndex = Int(cell.selectedResult ) ?? 0
        selectedResult = cell.selectedResult
        
        //     showFlightDetails()
        
        guard let vc = ViewFlightDetaisVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
    //MARK: SHOW FLIGHT DETAILS ACTION
    override func didTapOnShowFlightDetails(cell: RoundTripTVCell) {
        // flightcellIndex = cell.indexPath?.row ?? 0
        flightcellIndex = Int(cell.selectedResult ) ?? 0
        selectedResult = cell.selectedResult
        
        // showFlightDetails()
        
        guard let vc = ViewFlightDetaisVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @objc func didTaponContinueToPaymentButton(_ sender:UIButton) {
        callMobilePreBookingAPI()
    }
    
    
    func callMobilePreBookingAPI() {
        payload.removeAll()
        
        fnameA.removeAll()
        passengertypeA.removeAll()
        title2A.removeAll()
        mnameA.removeAll()
        dobA.removeAll()
        passportNoA.removeAll()
        genderA.removeAll()
        lnameA.removeAll()
        passportNationalityA.removeAll()
        passportissuingcountryA.removeAll()
        middleNameA.removeAll()
        leadPassengerA.removeAll()
        passportExpireDayA.removeAll()
        passportExpireMonthA.removeAll()
        passportExpireYearA.removeAll()
        passengerPassportExpiryDateA.removeAll()
        
        passengerA.forEach { i in
            fnameA.append(i.firstName)
            passengertypeA.append(i.passengerType)
            title2A.append(i.title2Code)
            mnameA.append(i.middleName)
            dobA.append(i.dateOfBirth)
            passportNoA.append(i.passportNumber)
            genderA.append(i.gender)
            passportissuingcountryA.append(i.passportIssuingCountry)
            passportNationalityA.append(i.passportNationality)
            middleNameA.append(i.middleName)
            lnameA.append(i.lastName)
            leadPassengerA.append(i.isLeadPassenger)
            passportExpireDayA.append(i.passportExpiryDay)
            passportExpireMonthA.append(i.passportExpiryMonth)
            passportExpireYearA.append(i.passportExpiryYear)
            passengerPassportExpiryDateA.append(i.passenger_passport_expiry_date)
            
        }
        
 
        
        payload["search_id"] = defaults.string(forKey: UserDefaultsKeys.searchid)
        payload["selectedResult"] = selectedResult
        payload["user_id"] = defaults.string(forKey: UserDefaultsKeys.userid) ?? "0"
        payload["booking_source"] = defaults.string(forKey: UserDefaultsKeys.bookingsource)
        
        
        payload["passenger_dob"] = "[\(dobA.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["passenger_type"] = "[\(passengertypeA.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["lead_passenger"] = "[\(leadPassengerA.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["gender"] = "[\(genderA.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["passenger_nationality"] = "[\(passportNationalityA.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["name_title"] = "[\(title2A.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["first_name"] = "[\(fnameA.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["last_name"] = "[\(lnameA.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["passenger_passport_number"] = "[\(passportNoA.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["passenger_passport_issuing_country"] = "[\(passportissuingcountryA.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["passenger_passport_expiry_day"] = "[\(passportExpireDayA.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["passenger_passport_expiry_month"] = "[\(passportExpireMonthA.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["passenger_passport_expiry_year"] = "[\(passportExpireYearA.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["afrequent_air"] = "[\("EY")]"
        payload["afrequent_flyer"] = "[\("")]"
        payload["mealcode"] = "[\("")]"
        payload["special_assistance"] = "[\("")]"

        payload["extra_bag_charge"] = ""
        payload["extra_bag_charge1"] = ""
        payload["extra_bag_charge2"] = ""
        payload["extra_bag_charge3"] = ""
        payload["extra_bag_charge4"] = ""
        payload["extra_bag_charge5"] = ""
        payload["seat_radio_BLR_AUH"] = "BLR_AUH_A1"
        payload["passenger_contact"] = self.mobileNo
        payload["billing_email"] = self.billing_email
        payload["confirm_billing_email"] = self.billing_email
        payload["paymode"] = "paycard"
        payload["payment_method"] = "payway"
        payload["tc"] = "on"
        payload["search_access_key"] = search_access_key
        payload["cart_global_id"] = cart_global_id
        
        if passengerA.count != Int(defaults.string(forKey: UserDefaultsKeys.totalTravellerCount) ?? "1"){
            showToast(message: "Select Traveller Details")
        }else if billing_email == "" {
            showToast(message: "Enter Email Id")
        }else if billing_email.isValidEmail() == false {
            showToast(message: "Enter Valid Email Id")
        }else if mobileNo == "" {
            showToast(message: "Enter Mobile Number")
        }else if mobileNo.validateAsPhone() == false {
            showToast(message: "Enter Valid Mobile Number")
        }else if country_code == "" {
            showToast(message: "Select Country Code")
        }
        else {
            DispatchQueue.main.async {[self] in
                viewmodel?.CALL_MOBILE_PREBOKKING_API(dictParam: payload)
            }
        }
        
        
        
    }
    
    
    func getMobilePreBookingDetails(response: SecureBookingModel) {
        if response.status == true {
            secureBookigAPIKey = true
            DispatchQueue.main.async {[self] in
                viewmodel?.CALL_SECURE_BOOKING_API(dictParam: [:], url: response.url ?? "")
            }
        }
    }
    
    
    func secureBookingSucess(response: SecureBookingModel) {
        
        self.viewmodel?.view?.hideLoader()
        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.vocherurl = response.url ?? ""
        present(vc, animated: true)
    }
    
    
   
    
    //MARK: - Timer functions
    
    func sessionStop() {
        if let timer = self.timer {
            timer.invalidate()
            self.timer = nil
        }
    }
    
    func startTimer() {
        self.totalTime = 1400
        self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        self.subtitlelbl.text = self.timeFormatted(self.totalTime) // will show timer
        if totalTime != 0 {
            totalTime -= 1  // decrease counter timer
        } else {
            if let timer = self.timer {
                timer.invalidate()
                self.timer = nil
                sessionStop()
                gotoPopupScreen()
            }
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    func gotoPopupScreen() {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
}


extension ContinueToPaymentVC {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell =  Bundle.main.loadNibNamed("ButtonTVCell", owner: self, options: nil)?.first as! ButtonTVCell
        setuplabels(lbl: cell.titlelbl, text: "Continue To Payment", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 18), align: .center)
        cell.btnView.backgroundColor = .ButtonColor
        cell.btn.addTarget(self, action: #selector(didTaponContinueToPaymentButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 80
    }
    
    
    
    func setuupFareSummeryDetails() {
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            
            switch journyType {
            case "oneway":
                
                oneWayFlights.forEach { i in
                    adt = "\(i[flightcellIndex].passengerFareBreakdown?.aDT?.passengerCount ?? 0) adts(\(i[flightcellIndex].passengerFareBreakdown?.aDT?.passengerCount ?? 0) X \(Double(i[flightcellIndex].passengerFareBreakdown?.aDT?.baseFare?.rounded() ?? 0)))"
                    
                    child = "\(i[flightcellIndex].passengerFareBreakdown?.cH?.passengerCount ?? 0) ch(\(i[flightcellIndex].passengerFareBreakdown?.cH?.passengerCount ?? 0) X \(Double(i[flightcellIndex].passengerFareBreakdown?.cH?.baseFare?.rounded() ?? 0)))"
                    
                    
                    infnta = "\(i[flightcellIndex].passengerFareBreakdown?.iNF?.passengerCount ?? 0) Inf(\(i[flightcellIndex].passengerFareBreakdown?.iNF?.passengerCount ?? 0) X \(Double(i[flightcellIndex].passengerFareBreakdown?.iNF?.baseFare?.rounded() ?? 0)))"
                    
                    
                    adtTax = "\(i[flightcellIndex].passengerFareBreakdown?.aDT?.passengerCount ?? 0) adts(\(i[flightcellIndex].passengerFareBreakdown?.aDT?.passengerCount ?? 0) X \(Double(i[flightcellIndex].passengerFareBreakdown?.aDT?.tax ?? "0") ?? 0.0))"
                    
                    childTax = "\(i[flightcellIndex].passengerFareBreakdown?.cH?.passengerCount ?? 0) ch(\(i[flightcellIndex].passengerFareBreakdown?.cH?.passengerCount ?? 0) X \(Double(i[flightcellIndex].passengerFareBreakdown?.cH?.tax ?? "0") ?? 0.0))"
                    
                    
                    infntaTax = "\(i[flightcellIndex].passengerFareBreakdown?.iNF?.passengerCount ?? 0) Inf(\(i[flightcellIndex].passengerFareBreakdown?.iNF?.passengerCount ?? 0) X \(Double(i[flightcellIndex].passengerFareBreakdown?.iNF?.tax ?? "0") ?? 0.0))"
                    
                    adtPassCount = i[flightcellIndex].passengerFareBreakdown?.aDT?.passengerCount ?? 0
                    cHPassCount = i[flightcellIndex].passengerFareBreakdown?.cH?.passengerCount ?? 0
                    iNFPassCount = i[flightcellIndex].passengerFareBreakdown?.iNF?.passengerCount ?? 0
                    
                }
                break
                
            case "circle","multicity":
                
                roundTripFlights.forEach { i in
                    adt = "\(i[flightcellIndex].passengerFareBreakdown?.aDT?.passengerCount ?? 0) adts(\(i[flightcellIndex].passengerFareBreakdown?.aDT?.passengerCount ?? 0)X\(Double(i[flightcellIndex].passengerFareBreakdown?.aDT?.baseFare?.rounded() ?? 0)))"
                    
                    child = "\(i[flightcellIndex].passengerFareBreakdown?.cH?.passengerCount ?? 0) ch(\(i[flightcellIndex].passengerFareBreakdown?.cH?.passengerCount ?? 0) X \(Double(i[flightcellIndex].passengerFareBreakdown?.aDT?.baseFare?.rounded() ?? 0)))"
                    
                    
                    infnta = "\(i[flightcellIndex].passengerFareBreakdown?.iNF?.passengerCount ?? 0) Inf(\(i[flightcellIndex].passengerFareBreakdown?.iNF?.passengerCount ?? 0) X \(Double(i[flightcellIndex].passengerFareBreakdown?.iNF?.baseFare?.rounded() ?? 0)))"
                    
                    
                    adtTax = "\(i[flightcellIndex].passengerFareBreakdown?.aDT?.passengerCount ?? 0) adts(\(i[flightcellIndex].passengerFareBreakdown?.aDT?.passengerCount ?? 0) X \(Double(i[flightcellIndex].passengerFareBreakdown?.aDT?.baseFare?.rounded() ?? 0)))"
                    
                    childTax = "\(i[flightcellIndex].passengerFareBreakdown?.cH?.passengerCount ?? 0) ch(\(i[flightcellIndex].passengerFareBreakdown?.cH?.passengerCount ?? 0) X \(Double(i[flightcellIndex].passengerFareBreakdown?.cH?.baseFare?.rounded() ?? 0)))"
                    
                    
                    infntaTax = "\(i[flightcellIndex].passengerFareBreakdown?.iNF?.passengerCount ?? 0) Inf(\(i[flightcellIndex].passengerFareBreakdown?.iNF?.passengerCount ?? 0) X \(Double(i[flightcellIndex].passengerFareBreakdown?.iNF?.baseFare?.rounded() ?? 0)))"
                    
                    adtPassCount = i[flightcellIndex].passengerFareBreakdown?.aDT?.passengerCount ?? 0
                    cHPassCount = i[flightcellIndex].passengerFareBreakdown?.cH?.passengerCount ?? 0
                    iNFPassCount = i[flightcellIndex].passengerFareBreakdown?.iNF?.passengerCount ?? 0
                    
                }
                break
                
            default:
                break
            }
            
        }
        
        
    }
    
}
