//
//  HomeVC.swift
//  BestFares365App
//
//  Created by FCI on 27/10/22.
//

import UIKit

class HomeVC: BaseTableVC, OnewayViewModelDelegate {
    
    
    
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
    var viewmodel:OnewayViewModel?
    var flights = [[Flights]]()
    
    //MARK:- VIEW LOADING FUNCTION
    override func viewWillAppear(_ animated: Bool) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableViewFromNotifaction(_:)), name: NSNotification.Name(rawValue: "reload"), object: nil)
        
        //MARK:- RUN ONLY ONCE TO SET UP
        if !UserDefaults.standard.bool(forKey: "ExecuteOnce") {
            defaults.set("0", forKey: UserDefaultsKeys.moduleTabSelectedIndex)
            defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
            UserDefaults.standard.set(true, forKey: "ExecuteOnce")
        }
        
        cellIndex = Int(defaults.string(forKey: UserDefaultsKeys.moduleTabSelectedIndex) ?? "0") ?? 0
        print("cellIndex \(cellIndex)")
        selectModulesCV.selectItem(at: IndexPath(item: cellIndex, section: 0), animated: true, scrollPosition: .left)
        
        
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
    }
    
    
    @objc func reloadTableViewFromNotifaction(_ notify:NSNotification) {
        commonTableView.reloadData()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = OnewayViewModel(self)
    }
    
    //MARK:-INITIAL UI SETUP
    func setupUI() {
        holderView.backgroundColor = .NavBackColor
        logoHolderView.backgroundColor = .NavBackColor
        bgImg.image = UIImage(named: "")?.withRenderingMode(.alwaysOriginal)
        menuBtn.addTarget(self, action: #selector(didTapOnMenuButton(_:)), for: .touchUpInside)
        langBtn.addTarget(self, action: #selector(didTapOnLanguageBtn(_:)), for: .touchUpInside)
        langView.backgroundColor = .clear
        langLogoImg.image = UIImage(named: "lang")?.withRenderingMode(.alwaysOriginal)
        dropdownImg.image = UIImage(named: "dropdown")?.withRenderingMode(.alwaysOriginal)
        setupLabels(lbl: langlbl, text: "AUD", textcolor: .WhiteColor, font: .SigvarRegular(size: 14))
        setupLabels(lbl: titlelbl, text: "Best flight booking 365days", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20))
        
        onewayView.backgroundColor = .clear
        setupLabels(lbl: onewaylbl, text: "One Way", textcolor: .WhiteColor, font: .sigvarbold(size: 16))
        onewayUL.backgroundColor = .clear
        onewayBtn.setTitle("", for: .normal)
        onewayBtn.addTarget(self, action: #selector(didTapOnOneWayTabBtn(_:)), for: .touchUpInside)
        
        rtView.backgroundColor = .clear
        setupLabels(lbl: rtlbl, text: "Round Trip", textcolor: .WhiteColor, font: .sigvarbold(size: 16))
        rtUL.backgroundColor = .clear
        rtBtn.setTitle("", for: .normal)
        rtBtn.addTarget(self, action: #selector(didTapOnRTTabBtn(_:)), for: .touchUpInside)
        
        mcView.backgroundColor = .clear
        setupLabels(lbl: mclbl, text: "Multi-City", textcolor: .WhiteColor, font: .sigvarbold(size: 16))
        mcUL.backgroundColor = .clear
        mcBtn.setTitle("", for: .normal)
        mcBtn.addTarget(self, action: #selector(didTapOnMCTabBtn(_:)), for: .touchUpInside)
        setupCV()
        
        //MARK:- REGISTER TVCELLS
        commonTableView.registerTVCells(["EmptyTVCell","FromViewTVCell","DepartDateViewTVCell","ButtonTVCell","TravellersViewTVCell","MulticityTVCell"])
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        
        
    }
    
    
    //MARK:- SETUP ONEWAY TAB VIEW
    func setuupOneWayView() {
        onewayUL.backgroundColor = .TabSelectColor
        rtUL.backgroundColor = .clear
        mcUL.backgroundColor = .clear
        defaults.set("oneway", forKey: UserDefaultsKeys.journeyType)
        
        DispatchQueue.main.async {
            self.setupOneWayTableViewCells(str: "oneway")
        }
    }
    
    //MARK:- SETUP ROUND TRIP TAB VIEW
    func setuupRTView() {
        onewayUL.backgroundColor = .clear
        rtUL.backgroundColor = .TabSelectColor
        mcUL.backgroundColor = .clear
        defaults.set("circle", forKey: UserDefaultsKeys.journeyType)
        
        
        DispatchQueue.main.async {
            self.setupRoundTripTableViewCells(str: "circle")
        }
    }
    
    //MARK:- SETUP MULTICITY TAB VIEW
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
        setuupOneWayView()
    }
    
    @objc func didTapOnRTTabBtn(_ sender:UIButton) {
        setuupRTView()
    }
    
    @objc func didTapOnMCTabBtn(_ sender:UIButton) {
        setuupMCView()
    }
    
    
    //MARK:- SETUP UI LABELS
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    //MARK:- SETUP SELECT MODULES COLLECTIONVIEW
    func setupCV() {
        selectModulesCV.backgroundColor = .clear
        let nib = UINib(nibName: "SelectModuleCVCell", bundle: nil)
        selectModulesCV.register(nib, forCellWithReuseIdentifier: "cell")
        selectModulesCV.delegate = self
        selectModulesCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .vertical
        
        if screenHeight < 835 {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
        }else {
            layout.minimumInteritemSpacing = 20
            layout.minimumLineSpacing = 20
        }
        
        selectModulesCV.backgroundColor = .clear
        selectModulesCV.collectionViewLayout = layout
        selectModulesCV.isScrollEnabled = false
        
    }
    
    
    
    //MARK:- SETUP ONEWAY TRIP TABLE VIEW CELLS
    func setupOneWayTableViewCells(str:String) {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .FromViewTVCell))
        tablerow.append(TableRow(key:"dep",cellType: .DepartDateViewTVCell))
        tablerow.append(TableRow(cellType: .TravellersViewTVCell))
        tablerow.append(TableRow(height:66,cellType: .EmptyTVCell))
        tablerow.append(TableRow(title:"Search Flights",bgColor: .ButtonColor,cellType: .ButtonTVCell))
        tablerow.append(TableRow(height:200,cellType: .EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    //MARK:- SETUP ROUND TRIP TABLE VIEW CELLS
    func setupRoundTripTableViewCells(str:String) {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .FromViewTVCell))
        tablerow.append(TableRow(key:"ret",cellType: .DepartDateViewTVCell))
        tablerow.append(TableRow(cellType: .TravellersViewTVCell))
        tablerow.append(TableRow(height:66,cellType: .EmptyTVCell))
        tablerow.append(TableRow(title:"Search Flights",bgColor: .ButtonColor,cellType: .ButtonTVCell))
        tablerow.append(TableRow(height:200,cellType: .EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK:- SETUP MULTI TRIP TABLE VIEW CELLS
    func setupMultiCityTripTableViewCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType: .MulticityTVCell))
        tablerow.append(TableRow(height:70,cellType: .EmptyTVCell))
        tablerow.append(TableRow(cellType: .TravellersViewTVCell))
        tablerow.append(TableRow(height:66,cellType: .EmptyTVCell))
        tablerow.append(TableRow(title:"Search Flights",bgColor: .ButtonColor,cellType: .ButtonTVCell))
        tablerow.append(TableRow(height:200,cellType: .EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK:- MENU BUTTON ACTION FUNCTION
    @objc func didTapOnMenuButton(_ sender:UIButton){
        guard let vc = SideMenuVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    //MARK:- LANGUAGE BUTTON TAP FUNCTION
    @objc func didTapOnLanguageBtn(_ sender:UIButton){
        guard let vc = SelectLanguageVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    override func selectFromCityBtnAction(cell: FromViewTVCell) {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titleStr = "From"
        self.present(vc, animated: false)
    }
    
    override func selectToCityBtnAction(cell: FromViewTVCell) {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.titleStr = "To"
        self.present(vc, animated: false)
    }
    
    func gotoCalenderVC() {
        guard let vc = CalenderVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
    override func didTapOnAddTravellersBtnAction(cell: TravellersViewTVCell) {
        guard let vc = ChoosePassengerVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    override func didTapOndepartDateBtn(cell: DepartDateViewTVCell) {
        gotoCalenderVC()
    }
    
    override func didTapOnreturnDateBtn(cell: DepartDateViewTVCell) {
        gotoCalenderVC()
    }
    
    override func didTapOnFromCityBtn(cell: MulticityTVCell) {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = "From"
        present(vc, animated: true)
    }
    
    override func didTapOnToCityBtn(cell: MulticityTVCell) {
        guard let vc = SelectFromCityVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.titleStr = "To"
        present(vc, animated: true)
    }
    
    override func didTapOnDateBtn(cell: MulticityTVCell) {
        guard let vc = CalenderVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    override func btnAction(cell: ButtonTVCell) {
        if let selectedJourneyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if selectedJourneyType == "oneway" {
                callOneWayAPI()
            }else if selectedJourneyType == "circle"{
                CALLROUNDTRIPAPI()
            }else {
                // CALLMULTICITYAPI()
                gotoFlightsResultVC()
            }
        }
    }
    
    
    //MARK:-CALL ONE WAY TRIP API -------------------------------------------------------------------------
    func callOneWayAPI() {
        
        
        if defaults.string(forKey:UserDefaultsKeys.fromCity) == nil {
            showToast(message: "Please Select From City")
        }else if defaults.string(forKey:UserDefaultsKeys.toCity) == nil {
            showToast(message: "Please Select To City")
        }else if defaults.string(forKey:UserDefaultsKeys.calDepDate) == nil {
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
            payload["selected_currency"] = "INR"
            
            BASE_URL = "https://bestfares365.com/mobile_webservices/mobile/index.php/general/"
            viewmodel?.CallGetOneWayFlightListAPI(dictParam: payload)
            
        }
        
    }
    
    
    //MARL:- ONE WAY TRIP API RESPONSE
    func getOneWayFlightList(response: OneWayModel) {
        response.raw_flight_list?.flights.map({ i in
            flights = i
            oneWayFlights = i
        })
        
        gotoFlightsResultVC()
    }
    
    
    //MARK:-CALL ROUND TRIP API -------------------------------------------------------------------------
    func CALLROUNDTRIPAPI() {
        
        
        if defaults.string(forKey:UserDefaultsKeys.rfromCity) == nil {
            showToast(message: "Please Select From City")
        }else if defaults.string(forKey:UserDefaultsKeys.rtoCity) == nil {
            showToast(message: "Please Select To City")
        }else if defaults.string(forKey:UserDefaultsKeys.rcalDepDate) == nil {
            showToast(message: "Please Select Departure Date")
        }else if defaults.string(forKey:UserDefaultsKeys.rcalRetDate) == nil {
            showToast(message: "Please Select Return Date")
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
            payload["selected_currency"] = "INR"
            
            BASE_URL = "https://bestfares365.com/mobile_webservices/mobile/index.php/general/"
            viewmodel?.CallRoundTripApi(dictParam: payload)
            
        }
        
    }
    
    
    //MARL:- ROUND TRIP API RESPONSE
    func getRoundTripFlightList(response: OneWayModel) {
        response.raw_flight_list?.flights.map({ i in
            roundTripFlights = i
        })
        
        gotoFlightsResultVC()
    }
    
    
    
    //MARL:- GO TO FLIGHT RESULT SCREEN
    func gotoFlightsResultVC() {
        guard let vc = FlightsResultVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
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
    
    
    
}
