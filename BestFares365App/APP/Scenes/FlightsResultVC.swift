//
//  FlightsResultVC.swift
//  BestFares365App
//
//  Created by FCI on 28/10/22.
//

import UIKit

class FlightsResultVC: BaseTableVC, BottomFilterTVCellDelegate {
    
    //MARK: - @IBOutlet
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var rightView: UIView!
    @IBOutlet weak var rightImg: UIImageView!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var leftView: UIView!
    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var airlinesListCV: UICollectionView!
    @IBOutlet weak var bottomHolderView: UIView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var noOfStopsCV: UICollectionView!
    @IBOutlet weak var cvHolderView: UIView!
    
    
    //MARK: - VERIABLES SETUP
    static var newInstance: FlightsResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FlightsResultVC
        return vc
    }
    var tablerow = [TableRow]()
    var filterStr = String()
    let refreshControl = UIRefreshControl()
    var currentIndexPath: Int = 0
    var filterdFlightList = [[Flights]]()
    var noofstopsArray = ["Non Stop","1 Stop","1+ stop"]
    
    
    //MARK: - VIEW LOADING FUNCTION
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupResreshControl()
        setupTvcellByDependOnJournyType()
        
    }
    
    
    //MARK: - SETUP PULL TO REFRESH CONTROLL
    func setupResreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        commonTableView.addSubview(refreshControl)
    }
    
    
    //MARK: Pull to refresh
    @objc func refresh(_ sender: AnyObject) {
        noofStopsFilterIndex = 10
        if oneWayFlights.count != 0 {
            airlinesListCV.scrollToItem(at: IndexPath(item: 0, section: 0), at: .left, animated: true)
        }
        airlinesListCV.reloadData()
        setupTvcellByDependOnJournyType()
    }
    
    
    //MARK: SCREEN INITIAL SETUP
    func setupTvcellByDependOnJournyType() {
        
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            self.refreshControl.endRefreshing()
        }
        
        priceArray.removeAll()
        airlinesArray.removeAll()
        airlinesImgArray.removeAll()
        cityCodesArray.removeAll()
        airlinesNAMEArray.removeAll()
        airlinesLogoArray.removeAll()
        connectingFlifhtsArray.removeAll()
        departureFromArray.removeAll()
        arrivingFlightsArray.removeAll()
        
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            switch journyType {
            case "oneway":
                setuplabels(lbl: nav.titlelbl, text: "\(defaults.string(forKey: UserDefaultsKeys.fromairport_city) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.toairport_city) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20), align: .center)
                
                setuplabels(lbl: nav.datelbl, text: "On \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.calDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM"))\n\(defaults.string(forKey: UserDefaultsKeys.travellerDetails) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 18), align: .center)
                
                
                
                oneWayFlights.map { j in
                    j.map { k in
                        
                        defaults.set(k.fareDetails?.b2c_PriceDetails?.currencySymbol ?? "", forKey: UserDefaultsKeys.APICurrencyType)
                        priceArray.append("\(k.fareDetails?.b2c_PriceDetails?.currencySymbol ?? "") \(k.fareDetails?.b2c_PriceDetails?.baseFare ?? 0)")
                        prices.append("\(k.fareDetails?.b2c_PriceDetails?.baseFare ?? 0)")
                        
                        k.segmentSummary?.forEach({ m in
                            airlinesArray.append(m.airlineDetails?.airlineCode ?? "")
                            airlinesImgArray.append(m.airlineDetails?.flightImage ?? "")
                            airlinesNAMEArray.append(m.airlineDetails?.airlineName ?? "")
                            airlinesLogoArray.append(m.airlineDetails?.flightImage ?? "")
                            arrivingFlightsArray.append(m.destinationDetails?.airportCode ?? "")
                            connectingFlifhtsArray.append(m.originDetails?.cityName ?? "")
                            departureFromArray.append(m.originDetails?.airportCode ?? "")
                        })
                    }
                }
                
                oneWayFilteredList(list: oneWayFlights)
                
                break
            case "circle":
                
                setuplabels(lbl: nav.titlelbl, text: "\(defaults.string(forKey: UserDefaultsKeys.rfromairport_city) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.rtoairport_city) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20), align: .center)
                
                setuplabels(lbl: nav.datelbl, text: "On \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.rcalDepDate) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM")) & Return \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.rcalRetDate) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM"))\n\(defaults.string(forKey: UserDefaultsKeys.rtravellerDetails) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 18), align: .center)
                
                roundTripFlights.map { j in
                    j.map { k in
                        
                        priceArray.append("\(k.fareDetails?.b2c_PriceDetails?.currencySymbol ?? "") \(k.fareDetails?.b2c_PriceDetails?.baseFare ?? 0)")
                        prices.append("\(k.fareDetails?.b2c_PriceDetails?.baseFare ?? 0)")
                        k.segmentSummary?.forEach({ m in
                            airlinesArray.append(m.airlineDetails?.airlineCode ?? "")
                            airlinesImgArray.append(m.airlineDetails?.flightImage ?? "")
                            airlinesNAMEArray.append(m.airlineDetails?.airlineName ?? "")
                            airlinesLogoArray.append(m.airlineDetails?.flightImage ?? "")
                            arrivingFlightsArray.append(m.originDetails?.airportCode ?? "")
                            connectingFlifhtsArray.append(m.originDetails?.cityName ?? "")
                            departureFromArray.append(m.originDetails?.airportCode ?? "")
                            
                        })
                    }
                }
                
                
                roundtripFilteredList(list: roundTripFlights)
                break
            case "multicity":
                
                
                setupLabels(lbl: nav.titlelbl, text: "\(defaults.string(forKey: UserDefaultsKeys.mfromairport_city) ?? "") - \(defaults.string(forKey: UserDefaultsKeys.mtoairport_city) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 18))
                
                setupLabels(lbl: nav.datelbl, text: "\(defaults.string(forKey: UserDefaultsKeys.mcalDepDate) ?? "") \(defaults.string(forKey: UserDefaultsKeys.mtravellerDetails) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 18))
                
                
                roundTripFlights.map { j in
                    j.map { k in
                        
                        priceArray.append("\(k.fareDetails?.b2c_PriceDetails?.currencySymbol ?? "") \(k.fareDetails?.b2c_PriceDetails?.baseFare ?? 0)")
                        prices.append("\(k.fareDetails?.b2c_PriceDetails?.baseFare ?? 0)")
                        
                        k.segmentSummary?.forEach({ m in
                            airlinesArray.append(m.airlineDetails?.airlineCode ?? "")
                            airlinesImgArray.append(m.airlineDetails?.flightImage ?? "")
                            airlinesNAMEArray.append(m.airlineDetails?.airlineName ?? "")
                            airlinesLogoArray.append(m.airlineDetails?.flightImage ?? "")
                            arrivingFlightsArray.append(m.originDetails?.airportCode ?? "")
                            connectingFlifhtsArray.append(m.originDetails?.cityName ?? "")
                            departureFromArray.append(m.originDetails?.airportCode ?? "")
                            
                        })
                    }
                }
                
                roundtripFilteredList(list: roundTripFlights)
                break
            default:
                break
            }
        }
        
        prices = prices.unique()
        priceArray = priceArray.unique()
        airlinesArray = airlinesArray.unique()
        airlinesImgArray = airlinesImgArray.unique()
        airlinesNAMEArray = airlinesNAMEArray.unique()
        airlinesLogoArray = airlinesLogoArray.unique()
        connectingFlifhtsArray = connectingFlifhtsArray.unique()
        arrivingFlightsArray = arrivingFlightsArray.unique()
        departureFromArray = departureFromArray.unique()
        
        
    }
    
    //MARK: SETUP UI
    func setupUI() {
        
        nav.datelbl.isHidden = false
        nav.editView.isHidden = false
        nav.titlelbl.textAlignment = .center
        nav.datelbl.textAlignment = .center
        nav.backImg.image = UIImage(named: "leftarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        nav.backBtn.addTarget(self, action: #selector(dismisVC(_:)), for: .touchUpInside)
        if screenHeight < 835 {
            navHeight.constant = 150
        }else {
            navHeight.constant = 180
        }
        rightImg.image = UIImage(named: "right")?.withRenderingMode(.alwaysOriginal)
        leftImg.image = UIImage(named: "left")?.withRenderingMode(.alwaysOriginal)
        rightBtn.setTitle("", for: .normal)
        leftBtn.setTitle("", for: .normal)
        rightBtn.addTarget(self, action: #selector(didTapOnScrollAirlinwsRightButton(_:)), for: .touchUpInside)
        leftBtn.addTarget(self, action: #selector(didTapOnScrollAirlinwsLeftButton(_:)), for: .touchUpInside)
        nav.editBtn.addTarget(self, action: #selector(didTapOnEditSearchFlight(_:)), for: .touchUpInside)
        
        setupCV()
        filterBtn.setTitle("", for: .normal)
        bottomHolderView.addCornerRadiusWithShadow(color: .AppLabelColor.withAlphaComponent(0.16), borderColor: .BorderColor, cornerRadius: 0)
        setupLabels(lbl: titlelbl, text: "no of stops", textcolor: .AppLabelColor, font: .SigvarRegular(size: 14))
        titlelbl.numberOfLines = 2
        
        cvHolderView.addBottomBorderWithColor(color: .lightGray, width: 0.5)
        setupBottomCV()
        
        //MARK: REGISTER TABLE VIEW CALLS
        commonTableView.registerTVCells(["FlightResultTVCell","BottomFilterTVCell","RoundTripTVCell","EmptyTVCell"])
        
    }
    
    func setupBottomCV() {
        
        let nib = UINib(nibName: "SelectClassCVCell", bundle: nil)
        noOfStopsCV.register(nib, forCellWithReuseIdentifier: "cell1")
        noOfStopsCV.delegate = self
        noOfStopsCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        noOfStopsCV.backgroundColor = .clear
        noOfStopsCV.collectionViewLayout = layout
        noOfStopsCV.isScrollEnabled = false
    }
    
    
    
    //MARK: TAP ON EDIT BUTTON TO SEARCH FLIGHT
    @objc func didTapOnEditSearchFlight(_ sender:UIButton) {
        guard let vc = ModifysearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    //MARK: GOTO HOME VC
    func gotoHomeVC(str:String) {
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.keyStr = str
        vc.isformvc = "homevc"
        vc.defaultsclearKey = "dontclear"
        self.present(vc, animated: false)
    }
    
    
    //MARK: DISMISS VIEW
    @objc func dismisVC(_ sender:UIButton) {
        callapibool = false
        noofStopsFilterIndex = 10
        gotoHomeVC(str: "home")
    }
    
    
    //MARK: SETUP COLLECTION VIEW
    func setupCV() {
        
        let nib = UINib(nibName: "AirlinesListCVCell", bundle: nil)
        airlinesListCV.register(nib, forCellWithReuseIdentifier: "cell")
        airlinesListCV.delegate = self
        airlinesListCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        airlinesListCV.backgroundColor = .clear
        airlinesListCV.collectionViewLayout = layout
        
    }
    
    
    //MARK: SETUP LABELS
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    
    //MARK: SCROLL AIRLINCE TO LEFT
    @objc func didTapOnScrollAirlinwsLeftButton(_ sender:UIButton) {
        print("didTapOnScrollAirlinwsLeftButton")
        let collectionBounds = self.airlinesListCV.bounds
        let contentOffset = CGFloat(floor(self.airlinesListCV.contentOffset.x - collectionBounds.size.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)
        
    }
    
    //MARK: SCROLL AIRLINCE TO RIGHT
    @objc func didTapOnScrollAirlinwsRightButton(_ sender:UIButton) {
        print("didTapOnScrollAirlinwsRightButton")
        let collectionBounds = self.airlinesListCV.bounds
        let contentOffset = CGFloat(floor(self.airlinesListCV.contentOffset.x + collectionBounds.size.width))
        self.moveCollectionToFrame(contentOffset: contentOffset)
    }
    
    
    func moveCollectionToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x : contentOffset ,y : self.airlinesListCV.contentOffset.y ,width : self.airlinesListCV.frame.width,height : self.airlinesListCV.frame.height)
        self.airlinesListCV.scrollRectToVisible(frame, animated: true)
    }
    
    
    //MARK: SHOW FLIGHT DETAILS ACTION
    override func didTapOnShowFlightDetails(cell: FlightResultTVCell) {
        flightcellIndex = cell.indexPath?.row ?? 0
        
        oneWayFlights.forEach { i in
            i.forEach { j in
                defaults.set(j.token, forKey: UserDefaultsKeys.token)
                defaults.set(j.tokenKey, forKey: UserDefaultsKeys.tokenkey)
            }
        }
        flightcellIndex = Int(cell.selectedResult ) ?? 0
        selectedResult = cell.selectedResult
        
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        showFlightDetails()
    }
    
    
    
    //MARK: SHOW FLIGHT DETAILS ACTION
    override func didTapOnShowFlightDetails(cell: RoundTripTVCell) {
        flightcellIndex = cell.indexPath?.row ?? 0
        flightcellIndex = Int(cell.selectedResult ) ?? 0
        selectedResult = cell.selectedResult
        roundTripFlights.forEach { i in
            i.forEach { j in
                defaults.set(j.token, forKey: UserDefaultsKeys.token)
                defaults.set(j.tokenKey, forKey: UserDefaultsKeys.tokenkey)
            }
        }
        
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        showFlightDetails()
    }
    
    
    func showFlightDetails() {
        guard let vc = ShowFlightDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
    // MARK: - FILTER RELATED STUFF
    @IBAction func didTapOnFilterBtnAction(_ sender: Any) {
        guard let vc = FilterVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = "flights"
        vc.delegate = self
        present(vc, animated: true)
    }
    
    
    
    
    //MARK: FILTER BY NO STOPS
    func didTapOnFilterBtn(cell: SelectClassCVCell) {
        
        if cell.titlelbl.text == "Non Stop" {
            filterStr = "0"
        }else if cell.titlelbl.text == "1 Stop" {
            filterStr = "1"
        }else {
            filterStr = "2"
        }
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journyType == "oneway" {
                
                
                let filteredArray = oneWayFlights.map { $0.filter { flight in
                    if let segmentSummary = flight.segmentSummary {
                        return segmentSummary.contains { "\($0.totalStops ?? 0)".lowercased().contains(filterStr.lowercased()) }
                    } else {
                        return false
                    }
                }}
                
                oneWayFilteredList(list: filteredArray)
                
                
            }else {
                
                let filteredArray = roundTripFlights.map { $0.filter { flight in
                    if let segmentSummary = flight.segmentSummary {
                        return segmentSummary.contains { "\($0.totalStops ?? 0)".lowercased().contains(filterStr.lowercased()) }
                    } else {
                        return false
                    }
                }}
                
                roundtripFilteredList(list: filteredArray)
                
            }
        }
        
        
    }
    
    
    
    func didTapOnAirlinesFilter(str:String) {
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journyType == "oneway" {
                
                let filteredArray = oneWayFlights.map { $0.filter { flight in
                    if let segmentSummary = flight.segmentSummary {
                        return segmentSummary.contains { "\($0.airlineDetails?.airlineCode ?? "") \($0.airlineDetails?.flightNumber ?? "")".lowercased().contains(str.lowercased()) }
                    } else {
                        return false
                    }
                }}
                
                oneWayFilteredList(list: filteredArray)
                
                
            }else {
                
                let filteredArray = roundTripFlights.map { $0.filter { flight in
                    if let segmentSummary = flight.segmentSummary {
                        return segmentSummary.contains { "\($0.airlineDetails?.airlineCode ?? "") \($0.airlineDetails?.flightNumber ?? "")".lowercased().contains(str.lowercased()) }
                    } else {
                        return false
                    }
                }}
                
                roundtripFilteredList(list: filteredArray)
            }
        }
        
    }
    
    
    
    override func didTapOnBookNowBtnAction(cell:FlightResultTVCell){
        selectedResult = cell.selectedResult
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        gotoContinueToPaymentVC()
    }
    
    override func didTapOnBookNowBtnAction(cell:RoundTripTVCell){
        selectedResult = cell.selectedResult
        defaults.set(cell.selectedResult, forKey: UserDefaultsKeys.selectedResult)
        gotoContinueToPaymentVC()
    }
    
    
    func gotoContinueToPaymentVC() {
        guard let vc = ContinueToPaymentVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.isFromVC = "FlightResultVC"
        showflightDetailskey = true
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
    
   

    func isTimeInRange(time: String, rangeString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        
        guard let timeValue = dateFormatter.date(from: time),
              let startTime = dateFormatter.date(from: rangeString.components(separatedBy: " - ")[0]),
              let endTime = dateFormatter.date(from: rangeString.components(separatedBy: " - ")[1]) else {
            return false
        }
        
        return timeValue >= startTime && timeValue <= endTime
    }



    
    
    
    
}



extension FlightsResultVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == noOfStopsCV {
            return noofstopsArray.count
        }else {
            return airlinesArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        
        
        if collectionView == noOfStopsCV {
            
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell1", for: indexPath) as? SelectClassCVCell {
                
                cell.titlelbl.text = noofstopsArray[indexPath.row]
                cell.titlelbl.font = .SigvarRegular(size: 14)
                
                if indexPath.row == noofStopsFilterIndex {
                    collectionView.selectItem(at: IndexPath(item: noofStopsFilterIndex, section: 0), animated: true, scrollPosition: .left)
                    cell.selected()
                }
                commonCell = cell
            }
        }else {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AirlinesListCVCell {
                cell.titlelbl.text = airlinesArray[indexPath.row]
                cell.subtitlelbl.text = priceArray[indexPath.row]
                cell.logoImg.sd_setImage(with: URL(string: airlinesImgArray[indexPath.row]), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
                commonCell = cell
            }
        }
        
        
        return commonCell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == noOfStopsCV {
            if let cell = collectionView.cellForItem(at: indexPath) as? SelectClassCVCell {
                noofStopsFilterIndex = indexPath.row
                cell.selected()
                self.didTapOnFilterBtn(cell: cell)
            }
        }else {
            if let cell = collectionView.cellForItem(at: indexPath) as? AirlinesListCVCell {
                didTapOnAirlinesFilter(str: cell.titlelbl.text ?? "")
            }
            
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == noOfStopsCV {
            if let cell = collectionView.cellForItem(at: indexPath) as? SelectClassCVCell {
                cell.unselected()
            }
        }
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == noOfStopsCV {
            let label = UILabel(frame: CGRect.zero)
            label.text = noofstopsArray[indexPath.item]
            label.sizeToFit()
            return CGSize(width: label.frame.width + 20, height: 40)
        }else {
            return CGSize(width: 130, height: 50)
        }
        
    }
    
}




extension FlightsResultVC: AppliedFilters{
    
    
    
    //MARK: - FILTERS
    func filterByApplied(airlinesArray: [String], depfromarray: [String], minpricerange: Double, maxpricerange: Double, ArrivingatArray: [String], departureTimefilterStrimg: String, arrivalTimefilterStrimg: String) {
        
        print(" ++++++ filterByApplied airlinesArray ++++++ \n\(airlinesArray.joined(separator: ","))")
        print(" ++++++ depfromarray  ++++++ \n\(depfromarray.joined(separator: ","))")
        print(" ++++++ ArrivingatArray  ++++++ \n\(ArrivingatArray.joined(separator: ","))")
        print(" ++++++ minpricerange  ++++++ \n\(minpricerange )")
        print(" ++++++ maxpricerange  ++++++ \n\(maxpricerange )")
        print(" ++++++ filterByApplied departureTimefilterStrimg ++++++ \n\(departureTimefilterStrimg)")
        print(" ++++++ filterByApplied arrivalTimefilterStrimg ++++++ \n\(arrivalTimefilterStrimg)")
        
        
        
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journyType == "oneway" {
                
                
                let filteredList = oneWayFlights.map { flights in
                    flights.filter { flight in
                        flight.segmentSummary?.allSatisfy { segment in
                            guard let airlineName = segment.airlineDetails?.airlineName else { return false }
                            guard let depfromname = segment.originDetails?.airportCode else { return false }
                            guard let arrivingatflightname = segment.destinationDetails?.airportCode else { return false }
                            guard let departureTime = segment.originDetails?._DateTime else { return false }
                            guard let arrivalTime = segment.destinationDetails?._DateTime else { return false }
                            
                            let isAirlineMatched = airlinesArray.isEmpty || airlinesArray.contains(airlineName)
                            let isDepFromMatched = depfromarray.isEmpty || depfromarray.contains(depfromname)
                            let isArrivingAtMatched = ArrivingatArray.isEmpty || ArrivingatArray.contains(arrivingatflightname)
                            
                            let isDepTimeInRange = departureTimefilterStrimg.isEmpty || isTimeInRange(time: departureTime, rangeString: departureTimefilterStrimg)
                            let isArrivalTimeInRange = arrivalTimefilterStrimg.isEmpty || isTimeInRange(time: arrivalTime, rangeString: arrivalTimefilterStrimg)

                            
                            let isPriceInRange = flight.fareDetails?.b2c_PriceDetails?.baseFare.flatMap { price -> Bool? in
                                let minPrice = Double(minpricerange)
                                let maxPrice = Double(maxpricerange)
                                return (Double(price) >= minPrice && Double(price) <= maxPrice )
                            } ?? false
                            
                            return isAirlineMatched && isDepFromMatched && isArrivingAtMatched && isDepTimeInRange && isArrivalTimeInRange && isPriceInRange
                        } ?? false
                    }
                }
                
                oneWayFilteredList(list: filteredList)
                
            }else {
                
                let filteredList = roundTripFlights.map { flights in
                    flights.filter { flight in
                        flight.segmentSummary?.allSatisfy { segment in
                            guard let airlineName = segment.airlineDetails?.airlineName else { return false }
                            guard let depfromname = segment.originDetails?.airportCode else { return false }
                            guard let arrivingatflightname = segment.destinationDetails?.airportCode else { return false }
                            guard let departureTime = segment.originDetails?._DateTime else { return false }
                            guard let arrivalTime = segment.destinationDetails?._DateTime else { return false }
                            
                            let isAirlineMatched = airlinesArray.isEmpty || airlinesArray.contains(airlineName)
                            let isDepFromMatched = depfromarray.isEmpty || depfromarray.contains(depfromname)
                            let isArrivingAtMatched = ArrivingatArray.isEmpty || ArrivingatArray.contains(arrivingatflightname)
                            
                            let isDepTimeInRange = departureTimefilterStrimg.isEmpty || isTimeInRange(time: departureTime, rangeString: departureTimefilterStrimg)
                            let isArrivalTimeInRange = arrivalTimefilterStrimg.isEmpty || isTimeInRange(time: arrivalTime, rangeString: arrivalTimefilterStrimg)

                            
                            let isPriceInRange = flight.fareDetails?.b2c_PriceDetails?.baseFare.flatMap { price -> Bool? in
                                let minPrice = Double(minpricerange)
                                let maxPrice = Double(maxpricerange)
                                return (Double(price) >= minPrice && Double(price) <= maxPrice )
                            } ?? false
                            
                            return isAirlineMatched && isDepFromMatched && isArrivingAtMatched && isDepTimeInRange && isArrivalTimeInRange && isPriceInRange
                        } ?? false
                    }
                }
                
                self.roundtripFilteredList(list: filteredList)
                
            }
        }
        
    }
    
    
    //MARK: - SORT BY FILTERS
    func filtersSortByApplied(sortBy: SortParameter) {
        
        
        switch sortBy {
            
            
        case .PriceLow:
            
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    
                    let sortedArray = oneWayFlights.map { i in
                        i.sorted(by: {$0.fareDetails?.b2c_PriceDetails?.totalFare ?? 0 < $1.fareDetails?.b2c_PriceDetails?.totalFare ?? 0})
                    }
                    
                    DispatchQueue.main.async {
                        self.oneWayFilteredList(list: sortedArray)
                    }
                    
                    DispatchQueue.main.async {[self] in
                        commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                    }
                }else {
                    let sortedArray = roundTripFlights.map { i in
                        i.sorted(by: {$0.fareDetails?.b2c_PriceDetails?.totalFare ?? 0 < $1.fareDetails?.b2c_PriceDetails?.totalFare ?? 0})
                    }
                    
                    DispatchQueue.main.async {
                        self.roundtripFilteredList(list: sortedArray)
                    }
                    
                    DispatchQueue.main.async {[self] in
                        commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
                    }
                }
            }
            
            break
            
        case .PriceHigh:
            
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    let sortedArray = oneWayFlights.map { i in
                        i.sorted(by: {$0.fareDetails?.b2c_PriceDetails?.totalFare ?? 0 > $1.fareDetails?.b2c_PriceDetails?.totalFare ?? 0})
                    }
                    
                    DispatchQueue.main.async {
                        self.oneWayFilteredList(list: sortedArray)
                    }
                }else {
                    let sortedArray = roundTripFlights.map { i in
                        i.sorted(by: {$0.fareDetails?.b2c_PriceDetails?.totalFare ?? 0 > $1.fareDetails?.b2c_PriceDetails?.totalFare ?? 0})
                    }
                    
                    DispatchQueue.main.async {
                        self.roundtripFilteredList(list: sortedArray)
                    }
                }
            }
            
            break
            
            
            
        case .DepartureLow:
            
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    let sortedArray = oneWayFlights.map { flights -> [Flights] in
                        return flights.sorted { flight1, flight2 in
                            let dateTime1 = flight1.segmentSummary?.first?.originDetails?._DateTime ?? ""
                            let dateTime2 = flight2.segmentSummary?.first?.originDetails?._DateTime ?? ""
                            
                            return dateTime1 < dateTime2
                        }
                    }
                    
                    oneWayFilteredList(list: sortedArray)
                    
                    
                }else {
                    let sortedArray = oneWayFlights.map { flights -> [Flights] in
                        return flights.sorted { flight1, flight2 in
                            let dateTime1 = flight1.segmentSummary?.first?.originDetails?._DateTime ?? ""
                            let dateTime2 = flight2.segmentSummary?.first?.originDetails?._DateTime ?? ""
                            
                            return dateTime1 < dateTime2
                        }
                    }
                    
                    roundtripFilteredList(list: sortedArray)
                }
            }
            break
            
        case .DepartureHigh:
            
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    let sortedArray = oneWayFlights.map { flights -> [Flights] in
                        return flights.sorted { flight1, flight2 in
                            let dateTime1 = flight1.segmentSummary?.first?.originDetails?._DateTime ?? ""
                            let dateTime2 = flight2.segmentSummary?.first?.originDetails?._DateTime ?? ""
                            
                            return dateTime1 > dateTime2
                        }
                    }
                    
                    oneWayFilteredList(list: sortedArray)
                }else {
                    let sortedArray = oneWayFlights.map { flights -> [Flights] in
                        return flights.sorted { flight1, flight2 in
                            let dateTime1 = flight1.segmentSummary?.first?.originDetails?._DateTime ?? ""
                            let dateTime2 = flight2.segmentSummary?.first?.originDetails?._DateTime ?? ""
                            
                            return dateTime1 > dateTime2
                        }
                    }
                    
                    
                    roundtripFilteredList(list: sortedArray)
                }
            }
            break
            
            
            
        case .ArrivalLow:
            
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    
                    let sortedArray = oneWayFlights.map { flights -> [Flights] in
                        return flights.sorted { flight1, flight2 in
                            let dateTime1 = flight1.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            let dateTime2 = flight2.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            
                            return dateTime1 < dateTime2
                        }
                    }
                    
                    oneWayFilteredList(list: sortedArray)
                    
                }else {
                    let sortedArray = oneWayFlights.map { flights -> [Flights] in
                        return flights.sorted { flight1, flight2 in
                            let dateTime1 = flight1.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            let dateTime2 = flight2.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            
                            return dateTime1 < dateTime2
                        }
                    }
                    
                    roundtripFilteredList(list: sortedArray)
                }
            }
            break
            
        case .ArrivalHigh:
            
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    let sortedArray = oneWayFlights.map { flights -> [Flights] in
                        return flights.sorted { flight1, flight2 in
                            let dateTime1 = flight1.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            let dateTime2 = flight2.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            
                            return dateTime1 > dateTime2
                        }
                    }
                    
                    oneWayFilteredList(list: sortedArray)
                }else {
                    
                    let sortedArray = oneWayFlights.map { flights -> [Flights] in
                        return flights.sorted { flight1, flight2 in
                            let dateTime1 = flight1.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            let dateTime2 = flight2.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            
                            return dateTime1 > dateTime2
                        }
                    }
                    
                    roundtripFilteredList(list: sortedArray)
                }
            }
            break
            
            
            
            
        case .DurationLow:
            
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    let sortedArray = oneWayFlights.map { flight -> [Flights] in
                        return flight.sorted { (flight1, flight2) -> Bool in
                            let duration1 = flight1.segmentSummary?.first?.totalDuaration ?? ""
                            let dateTime1 = flight1.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            let duration2 = flight2.segmentSummary?.first?.totalDuaration ?? ""
                            let dateTime2 = flight2.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            
                            return duration1 < duration2
                        }
                    }
                    
                    oneWayFilteredList(list: sortedArray)
                    
                }else {
                    let sortedArray = oneWayFlights.map { flight -> [Flights] in
                        return flight.sorted { (flight1, flight2) -> Bool in
                            let duration1 = flight1.segmentSummary?.first?.totalDuaration ?? ""
                            let dateTime1 = flight1.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            let duration2 = flight2.segmentSummary?.first?.totalDuaration ?? ""
                            let dateTime2 = flight2.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            
                            return duration1 < duration2
                        }
                    }
                    
                    roundtripFilteredList(list: sortedArray)
                }
            }
            break
            
        case .DurationHigh:
            
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    let sortedArray = oneWayFlights.map { flight -> [Flights] in
                        return flight.sorted { (flight1, flight2) -> Bool in
                            let duration1 = flight1.segmentSummary?.first?.totalDuaration ?? ""
                            let dateTime1 = flight1.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            let duration2 = flight2.segmentSummary?.first?.totalDuaration ?? ""
                            let dateTime2 = flight2.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            
                            return duration1 > duration2
                        }
                    }
                    
                    oneWayFilteredList(list: sortedArray)
                    
                }else {
                    let sortedArray = oneWayFlights.map { flight -> [Flights] in
                        return flight.sorted { (flight1, flight2) -> Bool in
                            let duration1 = flight1.segmentSummary?.first?.totalDuaration ?? ""
                            let dateTime1 = flight1.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            let duration2 = flight2.segmentSummary?.first?.totalDuaration ?? ""
                            let dateTime2 = flight2.segmentSummary?.first?.destinationDetails?._DateTime ?? ""
                            
                            return duration1 > duration2
                        }
                    }
                    
                    roundtripFilteredList(list: sortedArray)
                }
            }
            break
            
            
        case .airlineaz:
            
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    
                    let sortedArray = oneWayFlights.map({$0.sorted(by: {$0.segmentSummary?.first?.airlineDetails?.airlineName ?? "" < $1.segmentSummary?.first?.airlineDetails?.airlineName ?? ""})})
                    
                    oneWayFilteredList(list: sortedArray)
                    
                }else {
                    
                    let sortedArray = roundTripFlights.map({$0.sorted(by: {$0.segmentSummary?.first?.airlineDetails?.airlineName ?? "" < $1.segmentSummary?.first?.airlineDetails?.airlineName ?? ""})})
                    
                    roundtripFilteredList(list: sortedArray)
                }
            }
            break
            
        case .airlineza:
            
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    
                    let sortedArray = oneWayFlights.map({$0.sorted(by: {$0.segmentSummary?.first?.airlineDetails?.airlineName ?? "" > $1.segmentSummary?.first?.airlineDetails?.airlineName ?? ""})})
                    
                    oneWayFilteredList(list: sortedArray)
                }else {
                    let sortedArray = roundTripFlights.map({$0.sorted(by: {$0.segmentSummary?.first?.airlineDetails?.airlineName ?? "" > $1.segmentSummary?.first?.airlineDetails?.airlineName ?? ""})})
                    
                    roundtripFilteredList(list: sortedArray)
                }
            }
            break
            
            
        case .nothing:
            if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                if journyType == "oneway" {
                    oneWayFilteredList(list: oneWayFlights)
                }else {
                    roundtripFilteredList(list: roundTripFlights)
                }
            }
            break
            
            
            
        default:
            break
        }
        
        
        
        
    }
    
    
    
    
    func oneWayFilteredList1(list:[Flights]){
        
        tablerow.removeAll()
        
        if list.count == 0 {
            tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            
            list.forEach { j in
                j.segmentSummary?.forEach({ k in
                    
                    tablerow.append(TableRow(title:String(j.selectedResult ?? 0) ,
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
                                             price: "\(j.fareDetails?.b2c_PriceDetails?.currencySymbol ?? "") \(j.fareDetails?.b2c_PriceDetails?.baseFare ?? 0)",
                                             travelTime: k.totalDuaration,
                                             cellType:.FlightResultTVCell))
                })
            }
            
        }
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
        if list.count == 0 {
            tablerow.removeAll()
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
    }
    
    
    func oneWayFilteredList(list:[[Flights]]){
        
        tablerow.removeAll()
        
        if list.count == 0 {
            tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            list.forEach { i in
                i.forEach { j in
                    j.segmentSummary?.forEach({ k in
                        
                        tablerow.append(TableRow(title:String(j.selectedResult ?? 0) ,
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
                                                 price: "\(j.fareDetails?.b2c_PriceDetails?.currencySymbol ?? "") \(j.fareDetails?.b2c_PriceDetails?.baseFare ?? 0)",
                                                 travelTime: k.totalDuaration,
                                                 cellType:.FlightResultTVCell))
                    })
                }
            }
            
            
            
            
        }
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
        if list.count == 0 {
            tablerow.removeAll()
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
    }
    
    
    
    func roundtripFilteredList(list:[[Flights]]){
        
        
        
        tablerow.removeAll()
        
        if list.count == 0 {
            
            tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
        }else {
            TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
            
            
            list.forEach { i in
                i.forEach { j in
                    tablerow.append(TableRow(title: String(j.selectedResult ?? 0) ,
                                             price: "\(j.fareDetails?.b2c_PriceDetails?.currencySymbol ?? "") \(j.fareDetails?.b2c_PriceDetails?.baseFare ?? 0)",moreData:j.segmentSummary,
                                             cellType:.RoundTripTVCell))
                    
                }
            }
            
            //commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
        
        
        if list.count == 0 {
            tablerow.removeAll()
            TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
            commonTVData = tablerow
            commonTableView.reloadData()
        }
        
        
        
    }
    
}

