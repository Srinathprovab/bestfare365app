//
//  ViewFlightDetaisVC.swift
//  BestFares365App
//
//  Created by FCI on 25/03/23.
//

import UIKit

class ViewFlightDetaisVC: BaseTableVC, FlightDetailsViewModelDelegate {
    
    @IBOutlet weak var closeImg: UIImageView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var cityCodeslbl: UILabel!
    @IBOutlet weak var clkImg: UIImageView!
    @IBOutlet weak var myView: UIView!

    @IBAction func didTapOnCloseBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var segmentDuration = String()
    var viewmodel:FlightDetailsViewModel?
    
    static var newInstance: ViewFlightDetaisVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ViewFlightDetaisVC
        return vc
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        if callapibool == true {
            if showflightDetailskey == true {
                self.view.backgroundColor = .WhiteColor
                myView.isHidden = true
                commonTableView.isHidden = true
                callAPI()
            }else {
                self.view.backgroundColor = .black.withAlphaComponent(0.5)
            }
        }
    }
    
    //MARK: - VIEW LOADING FUNCTION
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = FlightDetailsViewModel(self)
       
    }
    
    
    //MARK: - CALL_GET_FLIGHTDETAILS_API
    func callAPI() {
        flight_details1?.removeAll()
        payload["search_id"] = searchid
        payload["selectedResult"] = defaults.string(forKey: UserDefaultsKeys.selectedResult)
        payload["booking_source"] = bookingsource
        payload["session_id"] = sessionid
        viewmodel?.CALL_GET_FLIGHTDETAILS_API(dictParam: payload)
    }
    
    func getFlightDetails(response: FlightDetailsModel) {
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        myView.isHidden = false
        commonTableView.isHidden = false
        flight_details1 = response.data?.flight_details
        
        DispatchQueue.main.async {[self] in
            setupTVCells()
        }
        
    }
    
    
    //MARK: - SETUP UI
    func setupUI() {
        
        closeBtn.setTitle("", for: .normal)
        closeImg.image = UIImage(named: "close")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
        clkImg.image = UIImage(named: "clk")?.withRenderingMode(.alwaysOriginal)
        
        myView.layer.cornerRadius = 10
        myView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        myView.clipsToBounds = true
        
        commonTableView.backgroundColor = .WhiteColor
        commonTableView.registerTVCells(["BaggageTVCell",
                                         "BottomBookNowTVCell",
                                         "FareRulesTVCell",
                                         "EmptyTVCell",
                                         "OnboardFacTVcell",
                                         "FDTVCell"])
       // commonTableView.isScrollEnabled = false
        
        setupTvcellByDependOnJournyType()
        setupTVCells()
        
    }
    
    
    
    //MARK: - SCREEN INITIAL SETUP
    func setupTvcellByDependOnJournyType() {
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            switch journyType {
            case "oneway":
                
                setuplabels(lbl: cityCodeslbl, text: "\(defaults.string(forKey: UserDefaultsKeys.fromairport_city) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.toairport_city) ?? "")", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 20), align: .left)
                
                break
            case "circle":
                
                setuplabels(lbl: cityCodeslbl, text: "\(defaults.string(forKey: UserDefaultsKeys.rfromairport_city) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.rtoairport_city) ?? "")", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 20), align: .left)
                
                
                break
            case "multicity":
                
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
        tablerow.removeAll()
        
        flight_details1?.forEach({ i in
            tablerow.append(TableRow(moreData:i,cellType:.FDTVCell))
        })
        
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnMoreButton(cell: FareRulesTVCell) {
        cell.moreBtn.isHidden = true
    }
    
    
    @objc func didTapOnBookNowButton(_ sender:UIButton){
        guard let vc = ContinueToPaymentVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isFromVC = "details"
        self.present(vc, animated: false)
    }
    
    
    
}
