//
//  HotelBookNowVC.swift
//  BestFares365App
//
//  Created by FCI on 07/11/22.
//

import UIKit

class HotelBookNowVC: BaseTableVC, HotelDetailDelegate {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    @IBOutlet weak var hotelNamelbl: UILabel!
    @IBOutlet weak var locImg: UIImageView!
    @IBOutlet weak var loclbl: UILabel!
    @IBOutlet weak var bookNowBtnView: UIView!
    @IBOutlet weak var bookNowBtnlbl: UILabel!
    @IBOutlet weak var bookNowBtn: UIButton!
    
    
    static var newInstance: HotelBookNowVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotel.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? HotelBookNowVC
        return vc
    }
    var tableRow = [TableRow]()
    var vm:HotelDetailsViewModel?
    var payload = [String:Any]()
    var rooms = [[Rooms]]()
    var hotelDesc = String()
    
   

    
    //MARK: - LOADING FUNCTIONS
    override func viewWillAppear(_ animated: Bool) {
        if callapibool == true {
            holderView.isHidden = true
            callGetHotelDetailsAPI()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        vm = HotelDetailsViewModel(self)
    }
    
    
    
    //MARK: - GET HOTEL DETAILS API CALL
    func callGetHotelDetailsAPI() {
        payload["booking_source"] = hbooking_source
        payload["search_id"] = hsearch_id
        payload["hotel_id"] = hotel_id
        vm?.CALL_GET_HOTEL_DETAILS_API(dictParam: payload)
    }
    
    
    
    func hotelDetails(response: HotelDetailsModel) {
        
        holderView.isHidden = false
        hotel_details = response.hotel_details
        hsearchid = response.params?.search_id ?? ""
        htoken = response.hotel_details?.token ?? ""
        hbookingsource = response.params?.booking_source ?? ""
        
        imageArr = response.hotel_details?.image_arr ?? []
        rooms = response.hotel_details?.rooms ?? [[]]
        hotelDesc = response.hotel_details?.description ?? ""
        formatAmeArray = response.hotel_details?.hotel_static_facilities_arr ?? []
        
        hotelNamelbl.isHidden = false
        loclbl.isHidden = false
        hotelNamelbl.text = response.hotel_details?.hotel_name ?? ""
        loclbl.text = response.hotel_details?.address ?? ""
        haddress = response.hotel_details?.address ?? ""
        hcurrency = response.hotel_details?.currency ?? ""
        
        small_image_baseUrl = response.hotel_details?.small_image_baseUrl ?? ""
        medium_image_baseUrl = response.hotel_details?.medium_image_baseUrl ?? ""
        
        DispatchQueue.main.async {
            self.setupRoomTableViewCells()
        }
    }
    
    
    //MARK: - SETUP INITIAL SCREEN UI
    func setupUI() {
        
        commonTableView.backgroundColor = .WhiteColor
        holderView.backgroundColor = .WhiteColor
        nav.datelbl.isHidden = false
        
        nav.backImg.image = UIImage(named: "leftarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)
        nav.backBtn.addTarget(self, action: #selector(dismisVC(_:)), for: .touchUpInside)
        if screenHeight < 835 {
            navHeight.constant = 140
        }else {
            navHeight.constant = 160
        }
        setuplabels(lbl: nav.titlelbl, text: "\(defaults.string(forKey: UserDefaultsKeys.hotelCity) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 20), align: .center)
        setuplabels(lbl: nav.datelbl, text: "\(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkin) ?? "", f1: "dd-MM-yyy", f2: "dd MMM")) - \(convertDateFormat(inputDate: defaults.string(forKey: UserDefaultsKeys.checkout) ?? "", f1: "dd-MM-yyyy", f2: "dd MMM")) - \(defaults.string(forKey: UserDefaultsKeys.selectPersons) ?? "")", textcolor: .WhiteColor, font: .ProximaNovaRegular(size: 18), align: .center)
        
        
        locImg.image = UIImage(named: "loc")?.withRenderingMode(.alwaysOriginal)
        setuplabels(lbl: hotelNamelbl, text: "", textcolor: .AppLabelColor, font: .ProximaNovaBold(size: 20), align: .left)
        setuplabels(lbl: loclbl, text: "", textcolor: HexColor("#009EE3"), font: .SigvarRegular(size: 12), align: .left)
        
        bookNowBtnView.backgroundColor = .ButtonColor
        bookNowBtn.setTitle("", for: .normal)
        setuplabels(lbl: bookNowBtnlbl, text: "Book Now", textcolor: .WhiteColor, font: .ProximaNovaBold(size: 18), align: .center)
        hotelNamelbl.isHidden = true
        loclbl.isHidden = true
        bookNowBtnView.alpha = 0.4
        bookNowBtn.isUserInteractionEnabled = false
        
        
        //MARK: REGISTER TABLE VIEW CELLS
        commonTableView.registerTVCells(["HotelResultTVCell",
                                         "BottomFilterTVCell",
                                         "HotelImagesTVCell",
                                         "HotelDetailsDescTVCell",
                                         "AmenitiesTVCell",
                                         "RoomTVCell",
                                         "RoomsButtonsTVCell"])
        
        
    }
    
    
    //MARK: - DISMISS SCREEN
    @objc func dismisVC(_ sender:UIButton) {
        callapibool = false
        self.dismiss(animated: true)
    }
    
    
    
    
    
    //MARK: - SETUP ROOM TAB VIEW CELLS
    func setupRoomTableViewCells() {
        tableRow.removeAll()
        
        tableRow.append(TableRow(cellType:.HotelImagesTVCell))
        tableRow.append(TableRow(key:"room",cellType:.RoomsButtonsTVCell))
        
        rooms.forEach { i in
            i.forEach { j in
                tableRow.append(TableRow(title:j.name,subTitle: "\(j.adults ?? 0) Adults \(j.children ?? 0) Children",text: "\(hcurrency)\(j.net?.rounded() ?? 0.0)",headerText: j.rateKey,buttonTitle: "Only \(j.rooms ?? 0) Rooms",cellType:.RoomTVCell))
            }
        }
        
        commonTVData = tableRow
        commonTableView.reloadData()
    }
    
    
    //MARK: - SETUP HOTEL DETAILS TAB VIEW CELLS
    func setupHotelDetailsTableViewCells() {
        tableRow.removeAll()
        
        tableRow.append(TableRow(cellType:.HotelImagesTVCell))
        tableRow.append(TableRow(key:"details",cellType:.RoomsButtonsTVCell))
        tableRow.append(TableRow(title:hotelDesc.htmlToString,cellType:.HotelDetailsDescTVCell))
        
        commonTVData = tableRow
        commonTableView.reloadData()
    }
    
    
    
    //MARK: - SETUP HOTEL DETAILS TAB VIEW CELLS
    func setupAmenitesTableViewCells() {
        tableRow.removeAll()
        
        tableRow.append(TableRow(cellType:.HotelImagesTVCell))
        tableRow.append(TableRow(key:"ameni",cellType:.RoomsButtonsTVCell))
        tableRow.append(TableRow(cellType:.AmenitiesTVCell))
        
        commonTVData = tableRow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnHotelDetailsBtn(cell:RoomsButtonsTVCell){
        setupHotelDetailsTableViewCells()
        
    }
    
    override func didTapOnRoomBtn(cell:RoomsButtonsTVCell){
        setupRoomTableViewCells()
    }
    
    override func didTapOnAminitiesBtn(cell:RoomsButtonsTVCell){
        setupAmenitesTableViewCells()
    }
    
    
    @IBAction func didTapOnBookNowBtnAction(_ sender: Any) {
        guard let vc = HotelContinuePaymentVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        callapibool = true
        present(vc, animated: true)
    }
    
    override func didTapOnCancellationPolicyBtn(cell: RoomTVCell) {
        guard let vc = PopupVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.isFromVc = "hotel"
        present(vc, animated: true)
        
    }
    
}



extension HotelBookNowVC {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RoomTVCell {
            self.bookNowBtnView.alpha = 1
            self.bookNowBtn.isUserInteractionEnabled = true
            cell.selected1()
            rateKeyArray.removeAll()
            rateKeyArray.append(cell.rateKey)
        }
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RoomTVCell {
            cell.unselected()
        }
    }
    
    
}
