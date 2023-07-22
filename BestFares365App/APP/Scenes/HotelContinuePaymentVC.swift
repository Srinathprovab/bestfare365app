//
//  HotelContinuePaymentVC.swift
//  BestFares365App
//
//  Created by FCI on 08/11/22.
//

import UIKit
import CoreData

class HotelContinuePaymentVC: BaseTableVC, HMBViewModelDelegate {
   
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var sessionTimerView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var subtitlelbl: UILabel!
    
    var country_code = String()
    var billing_email = String()
    var mobileNo = String()
    var timer: Timer?
    var totalTime = 1
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    
    static var newInstance: HotelContinuePaymentVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelContinuePaymentVC
        return vc
    }
    var text1 = "To avois last minutesuprises, fly in out without any majoor hitches, track your service receove timely update and scedule reminder."
    
    var text2 = "To avois last minutesuprises, fly in out without any majoor hitches, track your service receove timely update and scedule reminder more information"
    
    
    
    var vm:HMBViewModel?
    var token = String()
    var searchid = String()
    var bookingsource = String()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if callapibool == true {
            holderView.isHidden = true
            callAPI()
        }
    }
    
    func callAPI(){
        
        payload["token"] = htoken
        payload["search_id"] = hsearchid
        payload["agent_markup"] = "0"
        payload["admin_markup"] = "0"
        payload["booking_source"] = hbookingsource
        payload["rateKey"] = "[\(rateKeyArray.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["rooms"] = "[\(roomCountArray.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["adults"] = "[\(adultsCountArray.map { "\"\($0)\"" }.joined(separator: ","))]"
        payload["childs"] = "[\(childCountArray.map { "\"\($0)\"" }.joined(separator: ","))]"
        
        vm?.CALL_HOTEL_MOBILE_BOOKING_API(dictParam: payload)
    }
    
    var rateKeya = [String]()
    func hotelDetails(response: HMBModel) {
        holderView.isHidden = false
        hoteldetails = response.pre_booking_params?.token?.data
        
        rateKeya = response.pre_booking_params?.rateKey ?? []
        
        DispatchQueue.main.async {
            self.setupTVCells()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = HMBViewModel(self)
    }
    
    
    
    
    //MARK:  SETUP UI
    func setupUI() {
        
        nav.datelbl.isHidden = false
        setuplabels(lbl: nav.titlelbl, text: "Dubai ", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20), align: .center)
        setuplabels(lbl: nav.datelbl, text: "\(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "", f1: "dd-MM-yyy", f2: "dd MMM")) - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM")) - \(defaults.string(forKey: UserDefaultsKeys.selectPersons) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 18), align: .center)
        nav.backImg.image = UIImage(named: "leftarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        nav.backBtn.addTarget(self, action: #selector(dismisVC(_:)), for: .touchUpInside)
        if screenHeight < 835 {
            navHeight.constant = 140
        }else {
            navHeight.constant = 180
        }
        
        sessionTimerView.isHidden = true
        sessionTimerView.backgroundColor = .WhiteColor
        sessionTimerView.addCornerRadiusWithShadow(color: .AppBorderColor, borderColor: .clear, cornerRadius: 5)
        setuplabels(lbl: titlelbl, text: "Your Session Expires In : ", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16), align: .left)
        setuplabels(lbl: subtitlelbl, text: "", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16), align: .left)
        
        //MARK: REGISTER TABLE VIEW CALLS
        commonTableView.registerTVCells(["FlightResultTVCell",
                                         "EmptyTVCell",
                                         "ButtonTVCell",
                                         "TDetailsLoginTVCell",
                                         "CheckinBaggageTVCell",
                                         "ExtraBaggagesTVCell",
                                         "PassengerDetailsTVCell",
                                         "ContactDetailsTVCell",
                                         "AddAdultTravellerTVCell",
                                         "AddChildTravellerTVCell",
                                         "FareSummaryTVCell",
                                         "HotelResultTVCell",
                                         "TravelDetailsTVCell",
                                         "CharityTVCell"])
        
        
    }
    
    //MARK: DISMISS VIEW
    @objc func dismisVC(_ sender:UIButton) {
        callapibool = false
        self.dismiss(animated: true)
    }
    
    
    //MARK: APPEND TABLE VIEW CELLS
    func setupTVCells() {
        sessionTimerView.isHidden = false
        startTimer()
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key:"details",cellType:.HotelResultTVCell))
        tablerow.append(TableRow(cellType:.TDetailsLoginTVCell))
        tablerow.append(TableRow(cellType:.AddAdultTravellerTVCell))
        tablerow.append(TableRow(cellType:.AddChildTravellerTVCell))
        //  tablerow.append(TableRow(title:"Guest Details",key: "hotel",moreData:details,cellType:.PassengerDetailsTVCell))
        tablerow.append(TableRow(title:"Get Flight Details Through SMS",subTitle: text1, image:"sms",cellType:.CharityTVCell))
        tablerow.append(TableRow(title:"Charity",subTitle: text2, image:"charity",cellType:.CharityTVCell))
        tablerow.append(TableRow(cellType:.ContactDetailsTVCell))
        tablerow.append(TableRow(cellType:.FareSummaryTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnLoginBtn(cell: TDetailsLoginTVCell) {
        guard let vc = LoginVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    override func didTapOnSelectPassengerBtn(cell: ExtraBaggagesTVCell) {
        print("didTapOnSelectPassengerBtn")
    }
    
    override func didTapOnAddPassangerBtnAction(cell: PassengerDetailsTVCell) {
        guard let vc = AddTravellerDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = "show"
        present(vc, animated: true)
    }
    
    override func didTapOnEditPassengerBtn(cell:PassengerDetailsTVCell){
        guard let vc = AddTravellerDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = "edit"
        present(vc, animated: true)
    }
    
    
    override func editingChanged(tf: UITextField) {
        if tf.tag == 1 {
            self.billing_email = tf.text ?? ""
        }else {
            self.mobileNo = tf.text ?? ""
        }
    }
    
    
    override func didTapoNCountryCodeBtn(cell: ContactDetailsTVCell) {
        country_code = cell.countryCodelbl.text ?? ""
    }
    
    override func addCharityBtnAction(cell: CharityTVCell) {
        print(cell.totalPerBookingValurlbl.text)
    }
    
    override func didTapOnMoreInformationBtnAction(cell: CharityTVCell) {
        print(cell.totalPerBookingValurlbl.text)
    }
    
    var array: Any?
    
    @objc func didTaponContinueToPaymentButton(_ sender:UIButton) {
        //        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        //        vc.modalPresentationStyle = .fullScreen
        //        present(vc, animated: true)
        
       

     
        
        
        payload.removeAll()
        payload["token"] = hotel_details?.token
        payload["token_key"] = hotel_details?.tokenKey
        payload["search_id"] = hsearchid
        payload["booking_source"] = hbookingsource
        payload["rateKey"] = ""
        payload["guests"] = ""
        payload["payment_method"] = "PAY_WAY"
        payload["hotel_address_inf"] = haddress
        payload["lead_passenger"] = "1"
        payload["confirm"] = "0"
        payload["continue"] = "Continue"
        payload["billing_email"] = self.billing_email
        payload["passenger_contact"] = self.mobileNo
        payload["total_price"] = hprice
        payload["currency"] = hcurrency
        payload["convenience_fees"] = ""
        
        vm?.CALL_HOTEL_MOBILE_PRE_BOOKING_API(dictParam: payload)
    }
    
    
    func hotelmobileprebookingDetails(response: HotelMobilePreBookingModel) {
        BASE_URL = ""
        vm?.CALL_HOTEL_MOBILE_PROCESS_BOOKING_API(dictParam: [:], url: response.url ?? "")
    }
    
    
    
    func hotelmobileprocessbookingDetails(response: HotelMobilePreBookingModel) {
        BASE_URL = BASE_URL1
        print("hotelmobileprocessbookingDetails hotelmobileprocessbookingDetails hotelmobileprocessbookingDetails \n\(response.url)")
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


extension HotelContinuePaymentVC {
    
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
    
}
