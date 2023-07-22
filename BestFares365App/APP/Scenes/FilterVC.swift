//
//  FilterVC.swift
//  BestFares365App
//
//  Created by FCI on 29/10/22.
//

import UIKit



enum SortParameter {
    case PriceHigh
    case PriceLow
    case DurationHigh
    case DurationLow
    case DepartureHigh
    case DepartureLow
    case ArrivalHigh
    case ArrivalLow
    case starLow
    case starHeigh
    case airlineaz
    case airlineza
    case nothing
}

protocol AppliedFilters:AnyObject {
    
    func filtersSortByApplied(sortBy: SortParameter)
    func filterByApplied(airlinesArray:[String],
                         depfromarray:[String],
                         minpricerange:Double,
                         maxpricerange:Double,
                         ArrivingatArray:[String],
                         departureTimefilterStrimg:String,
                         arrivalTimefilterStrimg:String)
    
    
}

protocol AppliedHotelFilters:AnyObject {
    
    func filterByApplied(minpricerange:Double,
                         maxpricerange:Double,
                         filterStarValue:String)
                         
}

class FilterVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var sortbyView: UIView!
    @IBOutlet weak var sortbylbl: UILabel!
    @IBOutlet weak var sortbyimg: UIImageView!
    @IBOutlet weak var sortbyBtn: UIButton!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterlbl: UILabel!
    @IBOutlet weak var filterimg: UIImageView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var resetView: UIView!
    @IBOutlet weak var resetlbl: UILabel!
    @IBOutlet weak var resetBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    
    
    
    static var newInstance: FilterVC? {
        let storyboard = UIStoryboard(name: Storyboard.Filter.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FilterVC
        return vc
    }
    var tablerow = [TableRow]()
    var price = ["Low to high","High to low"]
    var key = String()
    var sortBy: SortParameter = .nothing
    weak var delegate: AppliedFilters?
    weak var hoteldelegate: AppliedHotelFilters?
    var minpricerangefilter = Double()
    var maxpricerangefilter = Double()
    var filterbtnTap = String()
    var filterStarValue = String()
    //MARK: - LOADING FUNCTIONS
    override func viewWillAppear(_ animated: Bool) {
        //MARK:- RUN ONLY ONCE TO SET UP
        if !UserDefaults.standard.bool(forKey: "FilterExecuteOnce") {
            defaults.set("0", forKey: UserDefaultsKeys.filterIndex)
            UserDefaults.standard.set(true, forKey: "FilterExecuteOnce")
        }
        
        
        if key == "flights" {
            if let filterIndex = defaults.string(forKey: UserDefaultsKeys.filterIndex) {
                if filterIndex == "0" {
                    sortbyFunction()
                }else {
                    filterFunction()
                }
            }
        }else {
            filterView.isHidden = true
            sortbyView.isHidden = true
            setupHotelFiltersTableViewCells()
        }
        
    }
    
    //MARK: - LOADING FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    //MARK: - SETUP UI
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        sortbyView.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#DADADA"), cornerRadius: 23.5)
        filterView.addCornerRadiusWithShadow(color: .clear, borderColor: HexColor("#DADADA"), cornerRadius: 23.5)
        resetView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 5)
        resetView.backgroundColor = HexColor("#009FE3")
        setuplabels(lbl: sortbylbl, text: "Sort by", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16), align: .center)
        setuplabels(lbl: filterlbl, text: "Filters", textcolor: .AppLabelColor, font: .ProximaNovaRegular(size: 16), align: .center)
        setuplabels(lbl: resetlbl, text: "Reset all", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 16), align: .center)
        sortbyimg.image = UIImage(named: "sort")?.withRenderingMode(.alwaysOriginal)
        filterimg.image = UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        sortbyBtn.addTarget(self, action: #selector(didTapOnSortByButton(_:)), for: .touchUpInside)
        filterBtn.addTarget(self, action: #selector(didTapOnFiltersButton(_:)), for: .touchUpInside)
        resetBtn.addTarget(self, action: #selector(didTapResetAllButton(_:)), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(didTapOnCloseVCButton(_:)), for: .touchUpInside)
        
        //MARK:  REGISTER TABLE VIEW
        commonTableView.registerTVCells(["SelectCabinClassTVCell",
                                         "EmptyTVCell",
                                         "ButtonTVCell",
                                         "PriceFilterTVCell",
                                         "SortByPriceTVCell",
                                         "AirlinesFilterTVCell",
                                         "StarRatingsFilterTVCell",
                                         "DepartureTimeTVCell"])
        
    }
    
    
    
    //MARK: - APPEND SORTBY FILTER TABLE VIEW CELLS
    func setupSortByTableViewCells() {
        tablerow.removeAll()
        
        
        tablerow.append(TableRow(title:"PRICE",subTitle: "Low to high",buttonTitle: "High to low",cellType:.SortByPriceTVCell))
        tablerow.append(TableRow(title:"Departure Time",subTitle: "Earlist  flight",buttonTitle: "Latest flight",cellType:.SortByPriceTVCell))
        tablerow.append(TableRow(title:"Arrival Time",subTitle: "Earlist  flight",buttonTitle: "Latest flight",cellType:.SortByPriceTVCell))
        tablerow.append(TableRow(title:"Duration",subTitle: "Low to high",buttonTitle: "High to low",cellType:.SortByPriceTVCell))
        tablerow.append(TableRow(title:"AIRLINE",subTitle: "A-Z",buttonTitle: "Z-A",cellType:.SortByPriceTVCell))
        
        
        tablerow.append((TableRow(height:30,cellType: .EmptyTVCell)))
        tablerow.append((TableRow(title:"Apply",key: "btn",cellType: .ButtonTVCell)))
        tablerow.append((TableRow(height:50,cellType: .EmptyTVCell)))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - APPEND SORTBY FILTER TABLE VIEW CELLS
    func setupFiltersTableViewCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Price",subTitle: "",cellType:.PriceFilterTVCell))
        tablerow.append(TableRow(title:"Loyover",subTitle: "0 h - 15 h",cellType:.PriceFilterTVCell))
        tablerow.append(TableRow(title:"Airlines",key: "show",moreData: airlinesNAMEArray,cellType:.AirlinesFilterTVCell))
        
        tablerow.append(TableRow(title:"Departure Time",data: ["Morning","Afternoon"," Evening","Night"],moreData: ["12:00 - 06:00 AM","06:00 - 12:00 PM","12:00 - 06:00 PM","06:00 - 12:00 AM"],cellType:.DepartureTimeTVCell))
        tablerow.append(TableRow(title:"Arrival Time",data: ["Morning","Afternoon"," Evening","Night"],moreData: ["12:00 - 06:00 AM","06:00 - 12:00 PM","12:00 - 06:00 PM","06:00 - 12:00 AM"],cellType:.DepartureTimeTVCell))
        
        tablerow.append(TableRow(title:"Departure from",key:"hide",moreData: departureFromArray,cellType:.AirlinesFilterTVCell))
        tablerow.append(TableRow(title:"Arriving at",key:"hide",moreData: arrivingFlightsArray,cellType:.AirlinesFilterTVCell))
        tablerow.append(TableRow(title:"Connecting in",key:"hide",moreData: connectingFlifhtsArray,cellType:.AirlinesFilterTVCell))
        
        tablerow.append((TableRow(height:30,cellType: .EmptyTVCell)))
        tablerow.append((TableRow(title:"Apply",bgColor: .ButtonColor,cellType: .ButtonTVCell)))
        tablerow.append((TableRow(height:50,cellType: .EmptyTVCell)))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - APPEND SORTBY FILTER TABLE VIEW CELLS
    func setupHotelFiltersTableViewCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"Price",
                                 subTitle: "",
                                 cellType:.PriceFilterTVCell))
        tablerow.append(TableRow(cellType:.StarRatingsFilterTVCell))
        
        
        tablerow.append((TableRow(height:30,cellType: .EmptyTVCell)))
        tablerow.append((TableRow(title:"Apply",bgColor: .ButtonColor,cellType: .ButtonTVCell)))
        tablerow.append((TableRow(height:50,cellType: .EmptyTVCell)))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    override func didTapOnStarRatingBtnAction(cell:StarRatingsFilterTVCell){
        filterStarValue = cell.selectedStarValue
    }
    
   
    func sortbyFunction(){
        filterbtnTap = "sortby"
        sortbyView.backgroundColor = .ButtonColor
        filterView.backgroundColor = .BtnUnselectedColor
        sortbylbl.textColor = .WhiteColor
        filterlbl.textColor = .AppLabelColor
        sortbyimg.image = UIImage(named: "sort")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        filterimg.image = UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        //  defaults.set("0", forKey: UserDefaultsKeys.filterIndex)
        setupSortByTableViewCells()
    }
    
    func filterFunction(){
        filterbtnTap = "filter"
        sortbyView.backgroundColor = .BtnUnselectedColor
        filterView.backgroundColor = .ButtonColor
        sortbylbl.textColor = .AppLabelColor
        filterlbl.textColor = .WhiteColor
        sortbyimg.image = UIImage(named: "sort")?.withRenderingMode(.alwaysOriginal).withTintColor(.AppLabelColor)
        filterimg.image = UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        // defaults.set("1", forKey: UserDefaultsKeys.filterIndex)
        setupFiltersTableViewCells()
    }
    
    
    //MARK: - TAP ON CLOSE SCREEN BUTTON ACTION
    @objc func didTapOnCloseVCButton(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    //MARK: - TAP ON SORT BY BUTTON ACTION
    @objc func didTapOnSortByButton(_ sender:UIButton) {
        sortbyFunction()
    }
    
    //MARK: - TAP ON FILTER BUTTON ACTION
    @objc func didTapOnFiltersButton(_ sender:UIButton) {
        filterFunction()
    }
    
    //MARK: - TAP ON RESETALL BUTTON ACTION
    @objc func didTapResetAllButton(_ sender:UIButton) {
        if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
            resetSortBy(cell: cell1)
        }
        if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
            resetSortBy(cell: cell2)
        }
        
        if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
            resetSortBy(cell: cell3)
        }
        if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
            resetSortBy(cell: cell4)
        }
        
        if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
            resetSortBy(cell: cell5)
        }
    }
    
    //MARK: - SHOW MORE AIRLINES LIST BUTTON ACTION
    override func showMoreButtonAction(cell: AirlinesFilterTVCell) {
        cell.airlinesNameArrayCount = airlinesNAMEArray.count
        // cell.showMoreBtn.isHidden = true
        cell.airlinesTV.reloadData()
        commonTableView.reloadData()
    }
    
    var departureTimefilterStrimg = String()
    var arrivalTimefilterStrimg = String()
    
    //MARK: - didTapOnSortByFiltersCell
    override func didTapOnSortByFiltersCell(cell: DepartureTimeCVCell) {
        switch cell.filterTitle {
        case "Departure Time":
            departureTimefilterStrimg = cell.titlelbl.text ?? ""
            break
            
        case "Arrival Time":
            arrivalTimefilterStrimg = cell.titlelbl.text ?? ""
            break
        default:
            break
        }
    }
    
    
    //MARK: - didTapOnLowToHeighBtnAction
    override func didTapOnLowToHeighBtnAction(cell: SortByPriceTVCell) {
        
        if cell.titlelbl.text == "PRICE" {
            sortBy = .PriceLow
            
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Departure Time" {
            sortBy = .DepartureLow
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Arrival Time" {
            sortBy = .ArrivalLow
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Duration" {
            sortBy = .DurationLow
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
            
        }else {
            sortBy = .airlineaz
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
        }
        
        
    }
    
    
    //MARK: - didTapOnHeighToLowBtnAction
    override func didTapOnHeighToLowBtnAction(cell: SortByPriceTVCell) {
        
        if cell.titlelbl.text == "PRICE" {
            sortBy = .PriceHigh
            
            
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Departure Time" {
            sortBy = .DepartureHigh
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Arrival Time" {
            sortBy = .ArrivalHigh
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
        }else if cell.titlelbl.text == "Duration" {
            sortBy = .DurationHigh
            
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            
            if let cell5 = commonTableView.cellForRow(at: IndexPath(item: 4, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell5)
            }
            
        }else {
            sortBy = .airlineza
            if let cell1 = commonTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell1)
            }
            if let cell2 = commonTableView.cellForRow(at: IndexPath(item: 1, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell2)
            }
            
            if let cell3 = commonTableView.cellForRow(at: IndexPath(item: 2, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell3)
            }
            if let cell4 = commonTableView.cellForRow(at: IndexPath(item: 3, section: 0)) as? SortByPriceTVCell {
                resetSortBy(cell: cell4)
            }
            
        }
        
        
    }
    
    
    
    
    func resetSortBy(cell:SortByPriceTVCell) {
        cell.lowlbl.textColor = .AppLabelColor
        cell.lowView.backgroundColor = .WhiteColor
        cell.heighlbl.textColor = .AppLabelColor
        cell.heightView.backgroundColor = .WhiteColor
    }
    
    
    var airlinesFilterArray = [String]()
    var depFromFilterArray = [String]()
    var ArrivingatFilterArray = [String]()
    
    override func didSelectAirlines(cell: AirlinesNameTVCell) {
        switch cell.filtertitle {
        case "Airlines":
            airlinesFilterArray.append(cell.titlelbl.text ?? "")
            print(airlinesFilterArray.joined(separator: "---"))
            break
            
        case "Departure from":
            depFromFilterArray.append(cell.titlelbl.text ?? "")
            print(depFromFilterArray.joined(separator: "---"))
            break
            
        case "Arriving at":
            ArrivingatFilterArray.append(cell.titlelbl.text ?? "")
            print(ArrivingatFilterArray.joined(separator: "---"))
            break
            
            
        default:
            break
        }
    }
    
    override func didDeselectAirlines(cell: AirlinesNameTVCell) {
        switch cell.filtertitle {
        case "Airlines":
            if let index = airlinesFilterArray.firstIndex(of: cell.titlelbl.text ?? "") {
                airlinesFilterArray.remove(at: index)
            }
            print(airlinesFilterArray.joined(separator: "---"))
            break
            
            
        case "Departure from":
            if let index = depFromFilterArray.firstIndex(of: cell.titlelbl.text ?? "") {
                depFromFilterArray.remove(at: index)
            }
            print(depFromFilterArray.joined(separator: "---"))
            break
            
        case "Arriving at":
            ArrivingatFilterArray.append(cell.titlelbl.text ?? "")
            if let index = ArrivingatFilterArray.firstIndex(of: cell.titlelbl.text ?? "") {
                ArrivingatFilterArray.remove(at: index)
            }
            print(ArrivingatFilterArray.joined(separator: "---"))
            break
            
            
        default:
            break
        }
    }
    
    
    override func didTapOnShowSliderBtn(cell: PriceFilterTVCell) {
        
        
        print("Selected minimum value: \(cell.minValue1)")
        print("Selected maximum value: \(cell.maxValue1)")
        
        minpricerangefilter = cell.minValue1
        maxpricerangefilter = cell.maxValue1
    }
    
    
    //MARK: - APPLY BTN ACTION
    override func btnAction(cell: ButtonTVCell) {
        
        if key == "flights" {
            if filterbtnTap == "sortby" {
                delegate?.filtersSortByApplied(sortBy: sortBy)
            }else {
                
                if minpricerangefilter.isZero == true && maxpricerangefilter.isZero == true{
                    let pricesFloat = prices.compactMap { Float($0) }
                    minpricerangefilter = Double(pricesFloat.min() ?? 0.0)
                    maxpricerangefilter = Double(pricesFloat.max() ?? 0.0)
                }
                
                
                delegate?.filterByApplied(airlinesArray: airlinesFilterArray,
                                          depfromarray: depFromFilterArray,
                                          minpricerange: minpricerangefilter,
                                          maxpricerange: maxpricerangefilter,
                                          ArrivingatArray: ArrivingatFilterArray,
                                          departureTimefilterStrimg: departureTimefilterStrimg,
                                          arrivalTimefilterStrimg: arrivalTimefilterStrimg)
            }
        }else {
            if minpricerangefilter.isZero == true && maxpricerangefilter.isZero == true{
                let pricesFloat = prices.compactMap { Float($0) }
                minpricerangefilter = Double(pricesFloat.min() ?? 0.0)
                maxpricerangefilter = Double(pricesFloat.max() ?? 0.0)
            }
            hoteldelegate?.filterByApplied( minpricerange: minpricerangefilter,
                                            maxpricerange: maxpricerangefilter,
                                            filterStarValue: self.filterStarValue)
        }
        
        callapibool = false
        dismiss(animated: true)
    }
    
}
