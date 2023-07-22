//
//  HotelSearchResultVC.swift
//  BestFares365App
//
//  Created by FCI on 07/11/22.
//

import UIKit

class HotelSearchResultVC: BaseTableVC, UITextFieldDelegate {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var tfHolderView: UIView!
    @IBOutlet weak var searchHotelTF: UITextField!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var noOfStopsCV: UICollectionView!
    
    
    static var newInstance: HotelSearchResultVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelSearchResultVC
        return vc
    }
    var tableRow = [TableRow]()
    var filterdHotelList = [Raw_hotel_list]()
    var isSearchBool = false
    var searchText = String()
    var noofstopsArray = ["Non Stop","1 Stop","1+ stop"]
    var freecancellation = ["Refundable","Non Refundable"]
    let refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        setupResreshControl()
    }
    
    
    //MARK: - SETUP PULL TO REFRESH CONTROLL
    func setupResreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        commonTableView.addSubview(refreshControl)
    }
    
    
    //MARK: Pull to refresh
    @objc func refresh(_ sender: AnyObject) {
//        if hotelList.count != 0 {
//            commonTableView.scrollToRow(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
//        }
        
        isSearchBool = false
        setupTableViewCells()
    }
    
    
    //MARK: - SETUP INITIAL SCREEN UI
    func setupUI() {
        if screenHeight < 835 {
            navHeight.constant = 140
        }else {
            navHeight.constant = 160
        }
        
        
        holderView.backgroundColor = .WhiteColor
        nav.datelbl.isHidden = false
        nav.editView.isHidden = false
        setuplabels(lbl: nav.titlelbl, text: "\(defaults.string(forKey: UserDefaultsKeys.hotelCity) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20), align: .center)
        setuplabels(lbl: nav.datelbl, text: "\(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "", f1: "dd-MM-yyy", f2: "dd MMM")) - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM")) - \(defaults.string(forKey: UserDefaultsKeys.selectPersons) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 18), align: .center)
        nav.backImg.image = UIImage(named: "leftarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        nav.backBtn.addTarget(self, action: #selector(dismisVC(_:)), for: .touchUpInside)
        nav.editBtn.addTarget(self, action: #selector(modifyHotelSearch(_:)), for: .touchUpInside)
        
        tfHolderView.backgroundColor = .WhiteColor
        tfHolderView.addCornerRadiusWithShadow(color: .lightGray.withAlphaComponent(0.5), borderColor: .clear, cornerRadius: 6)
        
        searchHotelTF.placeholder = "Hotel Name"
        searchHotelTF.textColor = .AppLabelColor
        searchHotelTF.font = UIFont.SigvarRegular(size: 14)
        searchHotelTF.delegate = self
        searchHotelTF.backgroundColor = .clear
        searchHotelTF.setLeftPaddingPoints(20)
        searchHotelTF.font = UIFont.sigvarbold(size: 18)
        searchHotelTF.addTarget(self, action: #selector(editingText(textField:)), for: .editingChanged)
        searchImg.image = UIImage(systemName: "magnifyingglass")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
        
        filterBtn.setTitle("", for: .normal)
        holderView.addCornerRadiusWithShadow(color: .AppLabelColor.withAlphaComponent(0.16), borderColor: .BorderColor, cornerRadius: 5)
        setuplabels(lbl: titlelbl, text: "Free Cancellation", textcolor: .AppLabelColor, font: .SigvarRegular(size: 14), align: .left)
        
        setupCV()
        
        
        //MARK:  REGISTER TABLE VIEW CELLS
        commonTableView.registerTVCells(["HotelResultTVCell",
                                         "EmptyTVCell",
                                         "BottomFilterTVCell"])
        setupTableViewCells()
        
    }
    
    
    func setupCV() {
        
        let nib = UINib(nibName: "SelectClassCVCell", bundle: nil)
        noOfStopsCV.register(nib, forCellWithReuseIdentifier: "cell")
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
    
    @objc func editingText(textField:UITextField) {
        searchText = textField.text ?? ""
        
        if searchText == "" {
            isSearchBool = false
            filterContentForSearchText(searchText)
        }else {
            isSearchBool = true
            filterContentForSearchText(searchText)
            
        }
    }
    
    func filterContentForSearchText(_ searchText: String) {
        print("Filterin with:", searchText)
        filterdHotelList.removeAll()
        
        filterdHotelList = hotelList.filter { thing in
            return "\(thing.name?.lowercased() ?? "")".contains(searchText.lowercased())
        }
        
        DispatchQueue.main.async {
            self.setupTableViewCells()
        }
    }
    
    //MARK: - go to modify Hotel Search
    @objc func modifyHotelSearch(_ sender: UIButton) {
        guard let vc = ModifyHotelSearchVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    
    //MARK: - DISMISS SCREEN
    @objc func dismisVC(_ sender:UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name("clearDefaults"), object: nil)
        self.dismiss(animated: true)
    }
    
    
    //MARK: - SETUP TABLE VIEW CELLS
    func setupTableViewCells() {
        refreshControl.endRefreshing()
        
        
        if isSearchBool == true {
            if filterdHotelList.count == 0 {
                tableRow.removeAll()
                TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
                commonTVData = tableRow
                commonTableView.reloadData()
            }else {
                TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
                appendHotelListTVCells(list: filterdHotelList)
            }
            
            
        }else {
            
            if hotelList.count == 0 {
                tableRow.removeAll()
                TableViewHelper.EmptyMessage(message: "No Data Found", tableview: commonTableView, vc: self)
                commonTVData = tableRow
                commonTableView.reloadData()
            }else {
                TableViewHelper.EmptyMessage(message: "", tableview: commonTableView, vc: self)
                appendHotelListTVCells(list: hotelList)
            }
        }
        
    }
    
    func gotoHotelBookNowVC() {
        guard let vc = HotelBookNowVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        callapibool = true
        present(vc, animated: true)
    }
    
    
    
    
    //MARK: - FILTER RELATED STUFF
    
    @IBAction func didTapOnFilterBtnAction(_ sender: Any) {
        guard let vc = FilterVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.key = "hotel"
        vc.hoteldelegate = self
        present(vc, animated: true)
    }
    
    
    
    func filterByFeeCancellation(str:String) {
        isSearchBool = true
        filterdHotelList.removeAll()
        
        filterdHotelList = hotelList.filter { thing in
            return "\(thing.rate_class?.lowercased() ?? "")".elementsEqual(str.lowercased())
        }
        
        DispatchQueue.main.async {
            self.setupTableViewCells()
        }
    }
    
    
}



extension HotelSearchResultVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? HotelResultTVCell {
           
            hbooking_source = hotelList[indexPath.row].booking_source ?? ""
            hotel_id = cell.hotelCode
            hotelImgSelected = cell.selectedHotelImg
            
            haddress = cell.hoteladdress
            hprice = cell.hotelPrice
            
            gotoHotelBookNowVC()
        }
    }
    
    
}



extension HotelSearchResultVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return freecancellation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SelectClassCVCell {
            
            cell.titlelbl.text = freecancellation[indexPath.row]
            cell.titlelbl.font = .SigvarRegular(size: 14)
            
            //            if indexPath.row == noofStopsFilterIndex {
            //                collectionView.selectItem(at: IndexPath(item: noofStopsFilterIndex, section: 0), animated: true, scrollPosition: .left)
            //                cell.selected()
            //            }
            
            
            commonCell = cell
        }
        return commonCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectClassCVCell {
            noofStopsFilterIndex = indexPath.row
            
            if cell.titlelbl.text == "Refundable" {
                filterByFeeCancellation(str: "NOR")
            }else {
                filterByFeeCancellation(str: "NRF")
            }
            cell.selected()
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? SelectClassCVCell {
            cell.unselected()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = freecancellation[indexPath.item]
        label.sizeToFit()
        return CGSize(width: label.frame.width + 10, height: 40)
        
        
    }
    
}



extension HotelSearchResultVC: AppliedHotelFilters{
    
   
    
    //MARK: - FILTERS
    func filterByApplied(minpricerange: Double, maxpricerange: Double, filterStarValue: String) {
        print(" ++++++ minpricerange  ++++++ \n\(minpricerange)")
        print(" ++++++ maxpricerange  ++++++ \n\(maxpricerange)")
        print(" ++++++ filterStarValue  ++++++ \n\(filterStarValue)")
        
        let filteredList = hotelList.filter { item in
            let isPriceInRange = (item.price ?? 0.0) >= minpricerange && (item.price ?? 0.0) <= maxpricerange
            let isStarMatched = filterStarValue.isEmpty || String(item.star_rating ?? 0) == filterStarValue
            
            
            return isPriceInRange && isStarMatched
        }
        
        appendHotelListTVCells(list: filteredList)
    }

    
    
    
    func appendHotelListTVCells(list:[Raw_hotel_list]) {
        tableRow.removeAll()
        
        list.forEach { i in
            tableRow.append(TableRow(title:i.rate_class,
                                     hotelName:i.name,
                                     hotelCode: "\(i.hotel_code ?? 0)",
                                     hotelAddress: i.address,hotelratings: "\(i.star_rating ?? 0)",
                                     hotelPrice: "\(i.currency ?? "")\(i.price?.rounded() ?? 0.0)",
                                     roomsLeft: "\(i.rmns_count ?? 0)",
                                     reviews: "",
                                     hotelImg: i.img,
                                     key:"result",
                                     cellType:.HotelResultTVCell))
        }
        
        commonTVData = tableRow
        commonTableView.reloadData()
        
    }
    
    
}
