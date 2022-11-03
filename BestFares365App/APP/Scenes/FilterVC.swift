//
//  FilterVC.swift
//  BestFares365App
//
//  Created by FCI on 29/10/22.
//

import UIKit

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
    
    var price = ["Low to high","High to low"]
    static var newInstance: FilterVC? {
        let storyboard = UIStoryboard(name: Storyboard.Filter.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? FilterVC
        return vc
    }
    var tablerow = [TableRow]()
    
    
    //MARK:- LOADING FUNCTIONS
    override func viewWillAppear(_ animated: Bool) {
        //MARK:- RUN ONLY ONCE TO SET UP
        if !UserDefaults.standard.bool(forKey: "FilterExecuteOnce") {
            defaults.set("0", forKey: UserDefaultsKeys.filterIndex)
            UserDefaults.standard.set(true, forKey: "FilterExecuteOnce")
        }
        
        if let filterIndex = defaults.string(forKey: UserDefaultsKeys.filterIndex) {
            if filterIndex == "0" {
                sortbyFunction()
            }else {
                filterFunction()
            }
        }
    }
    
    //MARK:- LOADING FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    //MARK:- SETUP UI
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        sortbyView.addCornerRadiusWithShadow(color: HexColor("#DADADA"), borderColor: HexColor("#DADADA"), cornerRadius: 23.5)
        filterView.addCornerRadiusWithShadow(color: HexColor("#DADADA"), borderColor: HexColor("#DADADA"), cornerRadius: 23.5)
        resetView.addCornerRadiusWithShadow(color: .clear, borderColor: .clear, cornerRadius: 5)
        resetView.backgroundColor = HexColor("#009FE3")
        setupLabels(lbl: sortbylbl, text: "Sort by", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 16))
        setupLabels(lbl: filterlbl, text: "Filters", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 16))
        setupLabels(lbl: resetlbl, text: "Reset all", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 16))
        sortbyimg.image = UIImage(named: "sort")?.withRenderingMode(.alwaysOriginal)
        filterimg.image = UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal).withTintColor(.LabelTitleColor)
        sortbyBtn.addTarget(self, action: #selector(didTapOnSortByButton(_:)), for: .touchUpInside)
        filterBtn.addTarget(self, action: #selector(didTapOnFiltersButton(_:)), for: .touchUpInside)
        resetBtn.addTarget(self, action: #selector(didTapResetAllButton(_:)), for: .touchUpInside)
        closeBtn.addTarget(self, action: #selector(didTapOnCloseVCButton(_:)), for: .touchUpInside)
        
        //MARK:- REGISTER TABLE VIEW
        commonTableView.registerTVCells(["SelectCabinClassTVCell","EmptyTVCell","ButtonTVCell","PriceFilterTVCell","AirlinesFilterTVCell","DepartureTimeTVCell"])
        
    }
    
    
    
    //MARK:- APPEND SORTBY FILTER TABLE VIEW CELLS
    func setupSortByTableViewCells() {
        tablerow.removeAll()

        tablerow.append(TableRow(title:"PRICE",key: "sort",moreData: ["Low to high","High to low"],cellType:.DepartureTimeTVCell))
        tablerow.append(TableRow(title:"Departure Time",key: "sort",moreData: ["Earlist  flight","Latest flight"],cellType:.DepartureTimeTVCell))
        tablerow.append(TableRow(title:"Arrival Time",key: "sort",moreData: ["Earlist  flight","Latest flight"],cellType:.DepartureTimeTVCell))
        tablerow.append(TableRow(title:"Duration",key: "sort",moreData: ["Shortest flight"],cellType:.DepartureTimeTVCell))
        
        
        tablerow.append((TableRow(height:30,cellType: .EmptyTVCell)))
        tablerow.append((TableRow(title:"Apply",bgColor: .ButtonColor,cellType: .ButtonTVCell)))
        tablerow.append((TableRow(height:50,cellType: .EmptyTVCell)))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK:- APPEND SORTBY FILTER TABLE VIEW CELLS
    func setupFiltersTableViewCells() {
        tablerow.removeAll()
        tablerow.append(TableRow(title:"Price",subTitle: "A$473 - A$1588",cellType:.PriceFilterTVCell))
        tablerow.append(TableRow(title:"Loyover",subTitle: "0 h - 15 h",cellType:.PriceFilterTVCell))
        tablerow.append(TableRow(title:"Airlines",moreData: ["Indigo airlines","Indigo airlines","Indigo airlines","Indigo airlines","Indigo airlines","Indigo airlines"],cellType:.AirlinesFilterTVCell))
        
        
        tablerow.append(TableRow(title:"Departure Time",data: ["Morning","Afternoon"," Evening","Night"],moreData: ["12:00 - 06:00 AM","06:00 - 12:00 PM","12:00 - 06:00 PM","06:00 - 12:00 AM"],cellType:.DepartureTimeTVCell))
        
        tablerow.append(TableRow(title:"Arrival Time",data: ["Morning","Afternoon"," Evening","Night"],moreData: ["12:00 - 06:00 AM","06:00 - 12:00 PM","12:00 - 06:00 PM","06:00 - 12:00 AM"],cellType:.DepartureTimeTVCell))
        
        
        tablerow.append(TableRow(title:"Arriving at",key:"arriving",moreData: ["DXD","KWI ","XNB"],cellType:.AirlinesFilterTVCell))
        tablerow.append(TableRow(title:"Connecting in",key:"connecting",moreData: ["DXD","KWI ","XNB"],cellType:.AirlinesFilterTVCell))
        
        
        
        
        
        tablerow.append((TableRow(height:30,cellType: .EmptyTVCell)))
        tablerow.append((TableRow(title:"Apply",bgColor: .ButtonColor,cellType: .ButtonTVCell)))
        tablerow.append((TableRow(height:50,cellType: .EmptyTVCell)))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    //MARK:- SETUP UI LABELS
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
        lbl.numberOfLines = 0
    }
    
    
    func sortbyFunction(){
        sortbyView.backgroundColor = .ButtonColor
        filterView.backgroundColor = .BtnUnselectedColor
        sortbylbl.textColor = .WhiteColor
        filterlbl.textColor = .LabelTitleColor
        sortbyimg.image = UIImage(named: "sort")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        filterimg.image = UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal).withTintColor(.LabelTitleColor)
        defaults.set("0", forKey: UserDefaultsKeys.filterIndex)
        setupSortByTableViewCells()
    }
    
    func filterFunction(){
        sortbyView.backgroundColor = .BtnUnselectedColor
        filterView.backgroundColor = .ButtonColor
        sortbylbl.textColor = .LabelTitleColor
        filterlbl.textColor = .WhiteColor
        sortbyimg.image = UIImage(named: "sort")?.withRenderingMode(.alwaysOriginal).withTintColor(.LabelTitleColor)
        filterimg.image = UIImage(named: "filter")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        defaults.set("1", forKey: UserDefaultsKeys.filterIndex)
        setupFiltersTableViewCells()
    }
    
    
    //MARK:- TAP ON CLOSE SCREEN BUTTON ACTION
    @objc func didTapOnCloseVCButton(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    //MARK:- TAP ON SORT BY BUTTON ACTION
    @objc func didTapOnSortByButton(_ sender:UIButton) {
        sortbyFunction()
    }
    
    //MARK:- TAP ON FILTER BUTTON ACTION
    @objc func didTapOnFiltersButton(_ sender:UIButton) {
        filterFunction()
    }
    
    //MARK:- TAP ON RESETALL BUTTON ACTION
    @objc func didTapResetAllButton(_ sender:UIButton) {
        print("didTapResetAllButton")
    }
    
    //MARK:- SHOW MORE AIRLINES LIST BUTTON ACTION
    override func showMoreButtonAction(cell: AirlinesFilterTVCell) {
        print("showMoreButtonAction")
    }
    
    
    //MARK:- APPLY BTN ACTION
    override func btnAction(cell: ButtonTVCell) {
        print("btnAction")
    }
    
}
