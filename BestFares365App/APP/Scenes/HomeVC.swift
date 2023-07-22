//
//  HomeVC.swift
//  BestFares365App
//
//  Created by FCI on 27/10/22.
//

import UIKit
import CoreData

class HomeVC: BaseTableVC, OnewayViewModelDelegate, UIGestureRecognizerDelegate, SearchHotelViewModelDelegate {
    
    
    
    //MARK: - @IBOutlet
    @IBOutlet var holderView: UIView!
    @IBOutlet weak var logoHolderView: UIView!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var langView: UIView!
    @IBOutlet weak var langLogoImg: UIImageView!
    @IBOutlet weak var langlbl: UILabel!
    @IBOutlet weak var dropdownImg: UIImageView!
    @IBOutlet weak var langBtn: UIButton!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var selectModulesCV: UICollectionView!
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
    static var newInstance: HomeVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HomeVC
        return vc
    }
    var modulesArray = ["Flight","Hotel","Car","Holiday"]
    var imagesArray = ["flight","hotel","car","holidays"]
    var tablerow = [TableRow]()
    var cellIndex = Int()
    var payload = [String:Any]()
    var payload1 = [String:Any]()
    var viewmodel:OnewayViewModel?
    var hotelVM: SearchHotelViewModel?
    var flights = [[Flights]]()
    var keyStr = String()
    var isformvc = String()
    
    //MARK: - side menu initial setup
    private var sideMenuViewController: SideMenuVC!
    private var sideMenuShadowView: UIView!
    private var sideMenuRevealWidth: CGFloat = 260
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    
    
    //MARK: Expand/Collapse the side menu by changing trailing's constant
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var revealSideMenuOnTop: Bool = true
    var gestureEnabled: Bool = true
    var defaultsclearKey = String()
    
    //MARK: - VIEW LOADING FUNCTION
    override func viewWillAppear(_ animated: Bool) {
        holderView.isHidden = false
        DispatchQueue.main.async {
            //self.clearInputs()
        }
       
        //MARK: RUN ONLY ONCE TO SET UP
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            defaults.set("0", forKey: UserDefaultsKeys.moduleTabSelectedIndex)
            defaults.set("Flight", forKey: UserDefaultsKeys.tabselect)
            defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
            defaults.set("AUD", forKey: UserDefaultsKeys.selectedCurrency)
            defaults.set("A$", forKey: UserDefaultsKeys.currencysymbol)
            langlbl.text = "AUD"
            
            
            if screenHeight > 835 {
                commonTableView.isScrollEnabled = false
            }
            
            btnsView.isHidden = false
            btnsViewHeight.constant = 30
            
            
            defaults.set("1", forKey: UserDefaultsKeys.adultCount)
            defaults.set("0", forKey: UserDefaultsKeys.childCount)
            defaults.set("0", forKey: UserDefaultsKeys.seatinfants)
            defaults.set("Economy", forKey: UserDefaultsKeys.selectClass)
            let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") Adults | \(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") Children | \(defaults.string(forKey: UserDefaultsKeys.seatinfants) ?? "0") Infants | \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "Economy")"
            defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
            
            defaults.set("1", forKey: UserDefaultsKeys.radultCount)
            defaults.set("0", forKey: UserDefaultsKeys.rchildCount)
            defaults.set("0", forKey: UserDefaultsKeys.rseatinfants)
            defaults.set("Economy", forKey: UserDefaultsKeys.rselectClass)
            let totaltraverlers1 = "\(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") Adults | \(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") Children | \(defaults.string(forKey: UserDefaultsKeys.rseatinfants) ?? "0") Infants | \(defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "")"
            defaults.set(totaltraverlers1, forKey: UserDefaultsKeys.rtravellerDetails)
            
            
            defaults.set("1", forKey: UserDefaultsKeys.madultCount)
            defaults.set("0", forKey: UserDefaultsKeys.mchildCount)
            defaults.set("0", forKey: UserDefaultsKeys.mseatinfants)
            defaults.set("Economy", forKey: UserDefaultsKeys.mselectClass)
            let totaltraverlers2 = "\(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") Adults | \(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") Children | \(defaults.string(forKey: UserDefaultsKeys.mseatinfants) ?? "0") Infants | \(defaults.string(forKey: UserDefaultsKeys.mselectClass) ?? "Economy")"
            defaults.set(totaltraverlers2, forKey: UserDefaultsKeys.mtravellerDetails)
            
            //Hotel
            defaults.set("Select City or Hotel", forKey: UserDefaultsKeys.hotelCity)
            defaults.set("Select Date", forKey: UserDefaultsKeys.checkin)
            defaults.set("Select Date", forKey: UserDefaultsKeys.checkout)
            defaults.set("1", forKey: UserDefaultsKeys.roomcount)
            defaults.set("1", forKey: UserDefaultsKeys.hoteladultscount)
            defaults.set("0", forKey: UserDefaultsKeys.hotelchildcount)
            
            
            defaults.set("\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1") Rooms,\(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "1") Adults,\(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "0") Childerns", forKey: UserDefaultsKeys.selectPersons)
           
            
            defaults.set("1 Rooms,1 Adults,0 Childerns", forKey: UserDefaultsKeys.selectPersons)

            
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
            
            
            
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableViewFromNotifaction(_:)), name: NSNotification.Name(rawValue: "reload"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(clearDefaults), name: NSNotification.Name(rawValue: "clearDefaults"), object: nil)
        
        
        
        if keyStr == "edit" {
            logoHolderView.isHidden = true
            self.view.backgroundColor = .black.withAlphaComponent(0.5)
            self.holderView.backgroundColor = .black.withAlphaComponent(0.5)
            logoBGViewHeight.constant = 50
            closeBtn.isHidden = false
        }else {
            logoHolderView.isHidden = false
            holderView.backgroundColor = .NavBackColor
            logoBGViewHeight.constant = 250
        }
        
        cellIndex = Int(defaults.string(forKey: UserDefaultsKeys.moduleTabSelectedIndex) ?? "0") ?? 0
        let indexPath = IndexPath(item: cellIndex, section: 0)
        selectModulesCV.selectItem(at: indexPath, animated: true, scrollPosition: .centeredVertically)
        self.collectionView(selectModulesCV, didSelectItemAt: indexPath)
        
        callSetupInitialView()
        
        
        if roomCountArray.isEmpty == true {
            roomCountArray.append(Int(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1") ?? 1)
        }
        if adultsCountArray.isEmpty == true {
            adultsCountArray.append(Int(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "1") ?? 1)
        }
        if childCountArray.isEmpty == true {
            childCountArray.append(Int(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "0") ?? 0)
        }
        
    }
    
    //MARK: - CLEAR ALL INPUTS WHEN PAGE LOADS
    func clearInputs() {
        if defaultsclearKey == "clear" {
            
            //Flights oneway
            defaults.set("Select City", forKey: UserDefaultsKeys.fromCity)
            defaults.set("Select City", forKey: UserDefaultsKeys.toCity)
            defaults.set("Select Date", forKey: UserDefaultsKeys.calDepDate)
            defaults.set("Select Date", forKey: UserDefaultsKeys.calRetDate)
            defaults.set("", forKey: UserDefaultsKeys.fromairportCode)
            defaults.set("", forKey: UserDefaultsKeys.toairportCode)
            
            defaults.set("1", forKey: UserDefaultsKeys.adultCount)
            defaults.set("0", forKey: UserDefaultsKeys.childCount)
            defaults.set("0", forKey: UserDefaultsKeys.seatinfants)
            
            
            let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") Adults | \(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") Children | \(defaults.string(forKey: UserDefaultsKeys.seatinfants) ?? "0") Infants | \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "")"
            defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
            
            
            //Flights roundtrip
            defaults.set("Select City", forKey: UserDefaultsKeys.rfromCity)
            defaults.set("Select City", forKey: UserDefaultsKeys.rtoCity)
            defaults.set("Select Date", forKey: UserDefaultsKeys.rcalDepDate)
            defaults.set("Select Date", forKey: UserDefaultsKeys.rcalRetDate)
            defaults.set("", forKey: UserDefaultsKeys.rfromairportCode)
            defaults.set("", forKey: UserDefaultsKeys.rtoairportCode)
            
            defaults.set("1", forKey: UserDefaultsKeys.radultCount)
            defaults.set("0", forKey: UserDefaultsKeys.rchildCount)
            defaults.set("0", forKey: UserDefaultsKeys.rseatinfants)
            
            defaults.set("1", forKey: UserDefaultsKeys.madultCount)
            defaults.set("0", forKey: UserDefaultsKeys.mchildCount)
            defaults.set("0", forKey: UserDefaultsKeys.mseatinfants)
            
            let totaltraverlers1 = "\(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") Adults | \(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") Children | \(defaults.string(forKey: UserDefaultsKeys.rseatinfants) ?? "0") Infants | \(defaults.string(forKey: UserDefaultsKeys.rselectClass) ?? "Economy")"
            defaults.set(totaltraverlers1, forKey: UserDefaultsKeys.rtravellerDetails)
            
            let totaltraverlers2 = "\(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") Adults | \(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") Children | \(defaults.string(forKey: UserDefaultsKeys.mseatinfants) ?? "0") Infants | \(defaults.string(forKey: UserDefaultsKeys.mselectClass) ?? "Economy")"
            defaults.set(totaltraverlers2, forKey: UserDefaultsKeys.mtravellerDetails)
            defaults.set("1", forKey: UserDefaultsKeys.totalTravellerCount)
            
            //Hotel
            defaults.set("Select City or Hotel", forKey: UserDefaultsKeys.hotelCity)
            defaults.set("Select Date", forKey: UserDefaultsKeys.checkin)
            defaults.set("Select Date", forKey: UserDefaultsKeys.checkout)
            defaults.set("1", forKey: UserDefaultsKeys.roomcount)
            defaults.set("1", forKey: UserDefaultsKeys.hoteladultscount)
            defaults.set("0", forKey: UserDefaultsKeys.hotelchildcount)
            
            
            defaults.set("\(defaults.string(forKey: UserDefaultsKeys.roomcount) ?? "1") Rooms,\(defaults.string(forKey: UserDefaultsKeys.hoteladultscount) ?? "1") Adults,\(defaults.string(forKey: UserDefaultsKeys.hotelchildcount) ?? "0") Childerns", forKey: UserDefaultsKeys.selectPersons)
           
            
            deleteAllRecords(str: "Adult")
            deleteAllRecords(str: "Child")
            deleteAllRecords(str: "Infant")
            
        }
        
        
       
        
        
    }
    
    
    @objc func clearDefaults() {
        defaultsclearKey = "clear"
       // clearInputs()
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
                
                
                
                
            case "Hotel":
                
                btnsView.isHidden = true
                btnsViewHeight.constant = 0
                setupHolteSearchTVCells()
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
        hotelVM = SearchHotelViewModel(self)
    }
    
    
    //MARK: -INITIAL UI SETUP
    func setupUI() {
        
        setupMenu()
        logoHolderView.backgroundColor = .NavBackColor
        bgImg.image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        menuBtn.addTarget(self, action: #selector(didTapOnMenuButton(_:)), for: .touchUpInside)
        langBtn.addTarget(self, action: #selector(didTapOnLanguageBtn(_:)), for: .touchUpInside)
        langView.backgroundColor = .clear
        langLogoImg.image = UIImage(named: "lang")?.withRenderingMode(.alwaysOriginal)
        dropdownImg.image = UIImage(named: "dropdown")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: langlbl, text: "\(defaults.string(forKey: UserDefaultsKeys.selectedCurrency) ?? "")", textcolor: .WhiteColor, font: .SigvarRegular(size: 14), align: .left)
        setuplabels(lbl: titlelbl, text: "BEST FLIGHT BOOKING 365DAYS", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20), align: .left)
        
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
        setupCV()
        
        closeBtn.isHidden = true
        closeBtn.setImage(UIImage(named: "close")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor), for: .normal)
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
    
    //MARK: - SETUP SELECT MODULES COLLECTIONVIEW
    func setupCV() {
        selectModulesCV.backgroundColor = .clear
        let nib = UINib(nibName: "SelectModuleCVCell", bundle: nil)
        selectModulesCV.register(nib, forCellWithReuseIdentifier: "cell")
        selectModulesCV.delegate = self
        selectModulesCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        
        if screenHeight > 835 {
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
        }else {
            
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }
        
        selectModulesCV.backgroundColor = .clear
        selectModulesCV.collectionViewLayout = layout
        selectModulesCV.isScrollEnabled = false
        
    }
    
    //MARK: - SETUP ONEWAY TRIP TABLE VIEW CELLS
    func setupOneWayTableViewCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .FromViewTVCell))
        tablerow.append(TableRow(key:"dep",cellType: .DepartDateViewTVCell))
        tablerow.append(TableRow(key:"flight",cellType: .TravellersViewTVCell))
        tablerow.append(TableRow(height:30,cellType: .EmptyTVCell))
        tablerow.append(TableRow(title:"Search Flights",bgColor: .ButtonColor,cellType: .ButtonTVCell))
        tablerow.append(TableRow(height:100,cellType: .EmptyTVCell))
        
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
        tablerow.append(TableRow(height:100,cellType: .EmptyTVCell))
        
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
        tablerow.append(TableRow(height:100,cellType: .EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    //MARK: - MENU BUTTON ACTION FUNCTION
    @objc func didTapOnMenuButton(_ sender:UIButton){
        NotificationCenter.default.post(name: NSNotification.Name("callMenuApi"), object: nil)
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    //MARK: - LANGUAGE BUTTON TAP FUNCTION
    @objc func didTapOnLanguageBtn(_ sender:UIButton){
        guard let vc = SelectLanguageVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
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
        }else {
            CALL_HOTEL_SEARCH_API()
        }
        
    }
    
    
    //MARK: -CALL ONE WAY TRIP API
    func callOneWayAPI() {
        
        payload.removeAll()
        
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
        }else if checkDepartureAndReturnDates1(payload, p1: "depature") == false {
            showToast(message: "Invalid Date")
        }else{
            
            holderView.isHidden = true
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
        }else if checkDepartureAndReturnDates(payload, p1: "depature", p2: "return") == false {
            showToast(message: "Invalid Date")
        }else{
            holderView.isHidden = true
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
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
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
        payload["rooms"] = defaults.string(forKey: UserDefaultsKeys.roomcount)
        payload["adult"] = ["\(defaults.string(forKey: UserDefaultsKeys.hoteladultscount ) ?? "1")"]
        payload["child"] = ["\(defaults.string(forKey: UserDefaultsKeys.hotelchildcount ) ?? "0")"]
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
            }else if checkDepartureAndReturnDates(payload, p1: "hotel_checkin", p2: "hotel_checkout") == false {
                showToast(message: "Invalid Date")
            }else if defaults.string(forKey: UserDefaultsKeys.checkin) == defaults.string(forKey: UserDefaultsKeys.checkout) {
                showToast(message: "Dates Should not same")
            }else if checkDepartureAndReturnDates(payload, p1: "hotel_checkin", p2: "hotel_checkout") == false {
                showToast(message: "Invalid Date")
            }else {
                
                holderView.isHidden = true
                payload1["search_params"] = jsonStringData
                hotelVM?.CALL_HOTEL_SEARCH_API(dictParam: payload1)
            }
            
            
        }catch{
            print(error.localizedDescription)
        }
        
        
    }
    
    
    func hotelSearchdetails(response: HotelSearchModel) {
        hotelList = response.data?.raw_hotel_list ?? []
        prices.removeAll()
        hotelList.forEach { i in
            prices.append("\(i.price ?? 0.0)")
        }
        prices.unique()
        hsearch_id = String(response.data?.search_id ?? 0)
        
        if response.status == 1 {
            guard let vc = HotelSearchResultVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
            
        }
    }
    
    
}



extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modulesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SelectModuleCVCell {
            cell.titlelbl.text = modulesArray[indexPath.row]
            cell.img.image = UIImage(named: imagesArray[indexPath.row])?.withRenderingMode(.alwaysOriginal)
            
            if indexPath.row == cellIndex {
                collectionView.selectItem(at: IndexPath(item: cellIndex, section: 0), animated: true, scrollPosition: .left)
                cell.selected()
            }
            commonCell = cell
        }
        return commonCell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectModuleCVCell{
            print(cell.titlelbl.text ?? "")
            defaults.set(cell.titlelbl.text, forKey: UserDefaultsKeys.tabselect)
            defaults.set(indexPath.row, forKey: UserDefaultsKeys.moduleTabSelectedIndex)
            
            
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
                    
                    
                case "Hotel":
                    
                    
                    btnsView.isHidden = true
                    btnsViewHeight.constant = 0
                    setupHolteSearchTVCells()
                    break
                default:
                    break
                }
            }
            
            cell.selected()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectModuleCVCell{
            cell.unselected()
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 120)
    }
    
    
    
    //MARK: - DELETING COREDATA OBJECT
    func deleteAllRecords(str:String) {
        
        
        if str == "Adult" {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
            do {
                let records = try context.fetch(fetchRequest)
                if records.count > 1 {
                    for i in 1..<records.count {
                        context.delete(records[i] as! NSManagedObject)
                    }
                    try context.save()
                }
            } catch {
                print("Error deleting records: \(error)")
            }
            
        }else {
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PassengerDetails")
            fetchRequest.predicate = NSPredicate(format: "passenger_type = %@", "\(str)")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            
            
            do {
                let result = try context.execute(deleteRequest) as? NSBatchDeleteResult
                let deletedObjectIDs = result?.result as? [NSManagedObjectID] ?? []
                NSManagedObjectContext.mergeChanges(fromRemoteContextSave: [NSDeletedObjectsKey: deletedObjectIDs], into: [context])
            } catch let error as NSError {
                print(error)
            }
            
            do {
                try context.save()
            } catch {
                print ("There was an error")
            }
        }
        
    }
    
    
}



extension HomeVC {
    
    
    //MARK: -  MENU RELATED STUFF
    
    
    @objc func TapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }
    
    //MARK:  Call this Button Action from the View Controller you want to Expand/Collapse when you tap a button
    //    @IBAction func menuButtonAction(_ sender: Any) {
    //        self.sideMenuState(expanded: self.isExpanded ? false : true)
    //    }
    
    //MARK: SETUP SIDE MENU
    func setupMenu(){
        
        //MARK: Shadow Background View
        self.sideMenuShadowView = UIView(frame: self.view.bounds)
        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.sideMenuShadowView.backgroundColor = .black
        self.sideMenuShadowView.alpha = 0.0
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(TapGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        self.sideMenuShadowView.addGestureRecognizer(tapGestureRecognizer)
        if self.revealSideMenuOnTop {
            view.insertSubview(self.sideMenuShadowView, at: 1)
        }
        
        //MARK: Side Menu
        let storyboard = UIStoryboard(name: "Login", bundle: Bundle.main)
        self.sideMenuViewController = storyboard.instantiateViewController(withIdentifier: "SideMenuVC") as? SideMenuVC
        view.insertSubview(self.sideMenuViewController!.view, at: self.revealSideMenuOnTop ? 2 : 0)
        addChild(self.sideMenuViewController!)
        self.sideMenuViewController!.didMove(toParent: self)
        
        //MARK: Side Menu AutoLayout
        self.sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth + 50),
            self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        //MARK: Side Menu Gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    //MARK: Keep the state of the side menu (expanded or collapse) in rotation
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { _ in
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = self.isExpanded ? 0 : (-self.sideMenuRevealWidth - self.paddingForRotation)
            }
        }
    }
    
    func animateShadow(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            //MARK: When targetPosition is 0, which means side menu is expanded, the shadow opacity is 0.6
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }
    
    
    
    func sideMenuState(expanded: Bool) {
        if expanded {
            NotificationCenter.default.post(name: NSNotification.Name("callMenuApi"), object: nil)

            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
            }
            // Animate Shadow (Fade In)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
        }
        else {
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
            }
            // Animate Shadow (Fade Out)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    // Dragging Side Menu
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        guard gestureEnabled == true else { return }
        
        let position: CGFloat = sender.translation(in: self.view).x
        let velocity: CGFloat = sender.velocity(in: self.view).x
        
        switch sender.state {
        case .began:
            
            // If the user tries to expand the menu more than the reveal width, then cancel the pan gesture
            if velocity > 0, self.isExpanded {
                sender.state = .cancelled
            }
            
            // If the user swipes right but the side menu hasn't expanded yet, enable dragging
            if velocity > 0, !self.isExpanded {
                self.draggingIsEnabled = true
            }
            // If user swipes left and the side menu is already expanded, enable dragging
            else if velocity < 0, self.isExpanded {
                self.draggingIsEnabled = true
            }
            
            if self.draggingIsEnabled {
                // If swipe is fast, Expand/Collapse the side menu with animation instead of dragging
                let velocityThreshold: CGFloat = 550
                if abs(velocity) > velocityThreshold {
                    self.sideMenuState(expanded: self.isExpanded ? false : true)
                    self.draggingIsEnabled = false
                    return
                }
                
                if self.revealSideMenuOnTop {
                    self.panBaseLocation = 0.0
                    if self.isExpanded {
                        self.panBaseLocation = self.sideMenuRevealWidth
                    }
                }
            }
            
        case .changed:
            
            // Expand/Collapse side menu while dragging
            if self.draggingIsEnabled {
                if self.revealSideMenuOnTop {
                    // Show/Hide shadow background view while dragging
                    let xLocation: CGFloat = self.panBaseLocation + position
                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                    
                    let alpha = percentage >= 0.6 ? 0.6 : percentage
                    self.sideMenuShadowView.alpha = alpha
                    
                    // Move side menu while dragging
                    if xLocation <= self.sideMenuRevealWidth {
                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
                    }
                }
                else {
                    if let recogView = sender.view?.subviews[1] {
                        // Show/Hide shadow background view while dragging
                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth
                        
                        let alpha = percentage >= 0.6 ? 0.6 : percentage
                        self.sideMenuShadowView.alpha = alpha
                        
                        // Move side menu while dragging
                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
                            recogView.frame.origin.x = recogView.frame.origin.x + position
                            sender.setTranslation(CGPoint.zero, in: view)
                        }
                    }
                }
            }
        case .ended:
            self.draggingIsEnabled = false
            // If the side menu is half Open/Close, then Expand/Collapse with animation
            if self.revealSideMenuOnTop {
                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
                self.sideMenuState(expanded: movedMoreThanHalf)
            }
            else {
                if let recogView = sender.view?.subviews[1] {
                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
                    self.sideMenuState(expanded: movedMoreThanHalf)
                }
            }
        default:
            break
        }
    }
    
    
    
    
}
