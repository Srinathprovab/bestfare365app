//
//  ShowFlightDetailsVC.swift
//  BestFares365App
//
//  Created by FCI on 31/10/22.
//

import UIKit

class ShowFlightDetailsVC: BaseTableVC, FlightDetailsViewModelDelegate {
    
    @IBOutlet weak var holderView: UIView!

    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var cityCodeslbl: UILabel!
    @IBOutlet weak var clkImg: UIImageView!
    @IBOutlet weak var hourlbl: UILabel!
    
    static var newInstance: ShowFlightDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ShowFlightDetailsVC
        return vc
    }
    var tablerow = [TableRow]()
    var viewmodel:FlightDetailsViewModel?
    var payload = [String:Any]()
    var farerules = [FareRulehtml]()
    var segmentDuration = String()
    var farePrice = String()
    var airportNamesArray = [String]()
    var isExpanded = false
    
    
    
    //MARK: - VIEW LOADING FUNCTION
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = FlightDetailsViewModel(self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        if callapibool == true {
            showflightDetailskey = false
            holderView.isHidden = true
            DispatchQueue.main.async {
                self.callAPI()
            }
        }
    }
    
    
    
    //MARK: - SETUP UI
    func setupUI() {
        
        nav.datelbl.isHidden = false
        setupTvcellByDependOnJournyType()
        
        nav.backImg.image = UIImage(named: "leftarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        nav.backBtn.addTarget(self, action: #selector(dismisVC(_:)), for: .touchUpInside)
        if screenHeight < 835 {
            navHeight.constant = 150
        }else {
            navHeight.constant = 180
        }
        
        
        setuplabels(lbl: hourlbl, text: segmentDuration, textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16), align: .left)
        clkImg.image = UIImage(named: "clk")?.withRenderingMode(.alwaysOriginal)
        clkImg.isHidden = true
        
        //MARK:- REGISTER TABLE VIEW CALLS
        commonTableView.registerTVCells(["BaggageTVCell",
                                         "BottomBookNowTVCell",
                                         "FareRulesTVCell",
                                         "EmptyTVCell",
                                         "OnboardFacTVcell",
                                         "FDTVCell"])
        commonTableView.isHidden = true
        cityCodeslbl.isHidden = true
        
    }
    
    
    //MARK: - CALL_GET_FLIGHTDETAILS_API
    func callAPI() {
        payload["search_id"] = searchid
        payload["selectedResult"] = selectedResult
        payload["booking_source"] = bookingsource
        payload["session_id"] = sessionid
        
        
        viewmodel?.CALL_GET_FLIGHTDETAILS_API(dictParam: payload)
    }
    
    func getFlightDetails(response: FlightDetailsModel) {
        holderView.isHidden = false
     //   farerules = response.data?.fare ?? []
        flight_details1 = response.data?.flight_details
        farePrice = String(response.data?.fare_details?.baseFare ?? 0)
        
        DispatchQueue.main.async {[self] in
            setupTVCells()
        }
        
        
    }
    
    
    
    //MARK: - SCREEN INITIAL SETUP
    func setupTvcellByDependOnJournyType() {
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            switch journyType {
            case "oneway":
                setuplabels(lbl: nav.titlelbl, text: "\(defaults.string(forKey: UserDefaultsKeys.fromairport_city) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.toairport_city) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20), align: .center)
                
                setuplabels(lbl: nav.datelbl, text: "On \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM"))\n\(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 18), align: .center)
                
                setuplabels(lbl: cityCodeslbl, text: "\(defaults.string(forKey: UserDefaultsKeys.fromairport_city) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.toairport_city) ?? "")", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 20), align: .left)
                
                break
            case "circle":
                
                setuplabels(lbl: nav.titlelbl, text: "\(defaults.string(forKey: UserDefaultsKeys.rfromairport_city) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.rtoairport_city) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20), align: .center)
                
                setuplabels(lbl: nav.datelbl, text: "On \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.rcalDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM")) & Return \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.rcalRetDate) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM"))\n\(defaults.string(forKey: UserDefaultsKeys.rtravellerDetails) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 18), align: .center)
                
                
                setuplabels(lbl: cityCodeslbl, text: "\(defaults.string(forKey: UserDefaultsKeys.rfromairport_city) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.rtoairport_city) ?? "")", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 20), align: .left)
                
                
                break
            case "multicity":
                
                
                setuplabels(lbl: nav.titlelbl, text: "\(defaults.string(forKey: UserDefaultsKeys.mfromairport_city) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.mtoairport_city) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 18), align: .center)
                
                setuplabels(lbl: nav.datelbl, text: "On:\(defaults.string(forKey: UserDefaultsKeys.mcalDepDate) ?? "") \(defaults.string(forKey: UserDefaultsKeys.mtravellerDetails) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 18), align: .center)
                
                setuplabels(lbl: cityCodeslbl, text: "\(defaults.string(forKey: UserDefaultsKeys.mfromairport_city) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.mtoairport_city) ?? "")", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 20), align: .left)
                
                break
            default:
                break
            }
        }
        
        
    }
    
    
    //MARK: - DISMISS VIEW
    @objc func dismisVC(_ sender:UIButton) {
        callapibool = false
        self.dismiss(animated: true)
    }
    
    
    //MARK: - APPEND TABLE VIEW CELLS
    func setupTVCells() {
        cityCodeslbl.isHidden = false
        commonTableView.isHidden = false
        clkImg.isHidden = false
        tablerow.removeAll()
        
        
        flight_details1?.forEach({ i in
            tablerow.append(TableRow(moreData:i,cellType:.FDTVCell))
            //            tablerow.append(TableRow(title:"Onboard Facilities",key: "fac",moreData: i,cellType:.OnboardFacTVcell))
            //            tablerow.append(TableRow(title:"Baggage info",key: "baggage",moreData: i,cellType:.OnboardFacTVcell))
        })
        
        flight_details1?.forEach({ i in
            tablerow.append(TableRow(title:"Onboard Facilities",key: "fac",moreData: i,cellType:.OnboardFacTVcell))
        })
        
        flight_details1?.forEach({ i in
            tablerow.append(TableRow(title:"Baggage info",key: "baggage",moreData: i,cellType:.OnboardFacTVcell))
        })
        
        
        
        if farerules.isEmpty == false {
            farerules.forEach { i in
                tablerow.append(TableRow(title:i.rule_content,cellType:.FareRulesTVCell))
            }
        }
        
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    override func didTapOnMoreButton(cell: FareRulesTVCell) {
        if isExpanded {
            cell.moreBtn.setTitle("+ More", for: .normal)
            cell.viewHeight.constant = 200
        } else {
            cell.moreBtn.setTitle("- Less", for: .normal)
            let subtitleHeight = cell.subtitlelbl.sizeThatFits(CGSize(width: cell.subtitlelbl.frame.width, height: CGFloat.greatestFiniteMagnitude)).height
            cell.viewHeight.constant = 200 + subtitleHeight
        }
        isExpanded = !isExpanded
        cell.contentView.clipsToBounds = true
        UIView.animate(withDuration: 0.3) {
            cell.layoutIfNeeded()
        }
    }
    
    
    
    
    
    @objc func didTapOnBookNowButton(_ sender:UIButton){
        guard let vc = ContinueToPaymentVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isFromVC = "details"
        callapibool = true
        self.present(vc, animated: false)
    }
    
}



extension ShowFlightDetailsVC {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell =  Bundle.main.loadNibNamed("BottomBookNowTVCell", owner: self, options: nil)?.first as! BottomBookNowTVCell
        
        cell.titlelbl.text = "\(defaults.string(forKey: UserDefaultsKeys.currencysymbol) ?? "") \(farePrice)"
        cell.bookNowBtn.addTarget(self, action: #selector(didTapOnBookNowButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 88
    }
    
}
