//
//  FlightsResultVC.swift
//  BestFares365App
//
//  Created by FCI on 28/10/22.
//

import UIKit

class FlightsResultVC: BaseTableVC {
    
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
    
    static var newInstance: FlightsResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FlightsResultVC
        return vc
    }
    var tablerow = [TableRow]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            switch journyType {
            case "oneway":
                
                oneWayFlights.map { j in
                    j.map { k in
                        
                        priceArray.append("\( k.fareDetails?.b2c_PriceDetails?.currency ?? "") \(k.fareDetails?.b2c_PriceDetails?.currencySymbol ?? "") \(k.fareDetails?.b2c_PriceDetails?.baseFare ?? 0)")
                        
                        k.segmentSummary?.forEach({ m in
                            airlinesArray.append(m.airlineDetails?.airlineCode ?? "")
                        })
                    }
                }
                
                setupOneWayTVCells()
                
                break
            case "circle":
                setupRoundTripTVCells()
                break
            case "multicity":
                setupMulticityTripTVCells()
                break
            default:
                break
            }
        }
        
        priceArray = priceArray.unique()
        airlinesArray = airlinesArray.unique()
        
    }
    
    
    //MARK:- VIEW LOADING FUNCTION
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    //MARK:- SETUP UI
    func setupUI() {
        
        setupLabels(lbl: nav.titlelbl, text: "Dubai - kuwait", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20))
        nav.datelbl.isHidden = false
        setupLabels(lbl: nav.datelbl, text: "15 Thu - 3 Adults - Economy", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 20))
        nav.titlelbl.textAlignment = .center
        nav.datelbl.textAlignment = .center
        nav.backImg.image = UIImage(named: "leftarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        nav.backBtn.addTarget(self, action: #selector(dismisVC(_:)), for: .touchUpInside)
        if screenHeight > 835 {
            navHeight.constant = 150
        }else {
            navHeight.constant = 120
        }
        rightImg.image = UIImage(named: "right")?.withRenderingMode(.alwaysOriginal)
        leftImg.image = UIImage(named: "left")?.withRenderingMode(.alwaysOriginal)
        rightBtn.setTitle("", for: .normal)
        leftBtn.setTitle("", for: .normal)
        rightBtn.addTarget(self, action: #selector(didTapOnScrollAirlinwsRightButton(_:)), for: .touchUpInside)
        leftBtn.addTarget(self, action: #selector(didTapOnScrollAirlinwsLeftButton(_:)), for: .touchUpInside)
        setupCV()
        
        //MARK:- REGISTER TABLE VIEW CALLS
        commonTableView.registerTVCells(["FlightResultTVCell","BottomFilterTVCell","RoundTripTVCell","EmptyTVCell"])
        
    }
    
    
    //MARK:- DISMISS VIEW
    @objc func dismisVC(_ sender:UIButton) {
        self.dismiss(animated: true)
    }
    
    
    //MARK:- SETUP COLLECTION VIEW
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
    
    
    //MARK:- SETUP LABELS
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    
    //MARK:- APPEND TABLE VIEW CELLS
    func setupOneWayTVCells() {
        tablerow.removeAll()
        
        
        oneWayFlights.forEach { i in
            i.forEach { j in
                
                j.segmentSummary?.forEach({ k in
                    
                    tablerow.append(TableRow(fromTime:k.originDetails?._DateTime,
                                             toTime: k.destinationDetails?._DateTime,
                                             fromCity: k.originDetails?.cityName,
                                             toCity: k.destinationDetails?.cityName,
                                             noosStops: String(k.totalStops ?? 0),
                                             airlineslogo: k.airlineDetails?.flightImage,
                                             airlinesname: k.airlineDetails?.airlineName,
                                             airlinesCode: "(\(k.airlineDetails?.fareClass ?? "") \(k.airlineDetails?.flightNumber ?? ""))",
                                             seatsLeft: "0",
                                             baggage: k.originDetails?.baggage,
                                             price: "\( j.fareDetails?.b2c_PriceDetails?.currency ?? "") \(j.fareDetails?.b2c_PriceDetails?.currencySymbol ?? "") \(j.fareDetails?.b2c_PriceDetails?.baseFare ?? 0)",
                                             travelTime: k.totalDuaration,
                                             cellType:.FlightResultTVCell))
                })
            }
        }
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    //MARK:- APPEND TABLE VIEW CELLS
    func setupRoundTripTVCells() {
        tablerow.removeAll()
        
        for _ in 0...10 {
            
        }
        
        roundTripFlights.forEach { i in
            i.forEach { j in
                tablerow.append(TableRow(title:"",
                                         price: "\( j.fareDetails?.b2c_PriceDetails?.currency ?? "") \(j.fareDetails?.b2c_PriceDetails?.currencySymbol ?? "") \(j.fareDetails?.b2c_PriceDetails?.baseFare ?? 0)",moreData:j.segmentSummary,
                                         cellType:.RoundTripTVCell))
            }
        }
        
        
        tablerow.append(TableRow(height:200,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    //MARK:- APPEND TABLE VIEW CELLS
    func setupMulticityTripTVCells() {
        tablerow.removeAll()
        
        for _ in 0...10 {
            tablerow.append(TableRow(characterLimit:5,cellType:.RoundTripTVCell))
        }
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    
    //MARK:- SCROLL AIRLINCE TO LEFT
    @objc func didTapOnScrollAirlinwsLeftButton(_ sender:UIButton) {
        print("didTapOnScrollAirlinwsLeftButton")
    }
    
    //MARK:- SCROLL AIRLINCE TO RIGHT
    @objc func didTapOnScrollAirlinwsRightButton(_ sender:UIButton) {
        print("didTapOnScrollAirlinwsRightButton")
    }
    
    
    //MARK:- SHOW FLIGHT DETAILS ACTION
    override func didTapOnShowFlightDetails(cell: FlightResultTVCell) {
        flightcellIndex = cell.indexPath?.row ?? 0
        showFlightDetails()
    }
    
    
    //MARK:- SHOW FLIGHT DETAILS ACTION
    override func didTapOnShowFlightDetails(cell: RoundTripTVCell) {
        showFlightDetails()
    }
    
    
    func showFlightDetails() {
        guard let vc = ShowFlightDetailsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    //MARK:- TAP ON FILTER BUTTON ACTION
    @objc func didTapOnFilterButton(_ sender:UIButton) {
        guard let vc = FilterVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
}



extension FlightsResultVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return airlinesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AirlinesListCVCell {
            cell.titlelbl.text = airlinesArray[indexPath.row]
            cell.subtitlelbl.text = priceArray[indexPath.row]
            commonCell = cell
        }
        return commonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //                let label = UILabel(frame: CGRect.zero)
        //                label.text = priceArray[indexPath.item]
        //                label.sizeToFit()
        //                return CGSize(width: label.frame.width + 25, height: 50)
        
        return CGSize(width: 125, height: 50)
        
    }
    
}



extension FlightsResultVC {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let cell =  Bundle.main.loadNibNamed("BottomFilterTVCell", owner: self, options: nil)?.first as! BottomFilterTVCell
        cell.filterBtn.addTarget(self, action: #selector(didTapOnFilterButton(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 65
    }
    
}
