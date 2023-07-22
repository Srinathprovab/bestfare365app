//
//  BookingConfirmedVC.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class BookingConfirmedVC: BaseTableVC, VocherViewModelDelegate {
    
    
    @IBOutlet weak var navBar: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    var bookingRefrence = String()
    var bookingsource = String()
    var bookingStatus = String()
    var vocherurl = String()
    var viewmodel:VocherViewModel?
    var tablerow = [TableRow]()
    
    static var newInstance: BookingConfirmedVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? BookingConfirmedVC
        return vc
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async {[self] in
            viewmodel?.CALL_GET_VOCHER_DETAILS_API(dictParam: [:], url: vocherurl )
        }
    }
    
    func vocherDetails(response: VocherModel) {
        vocherdata = response.data
        vocherdata?.booking_details?.forEach({ i in
            bookingRefrence = i.app_reference ?? ""
            bookingsource = i.booking_source ?? ""
            bookingStatus = i.status ?? ""
        })
        
        DispatchQueue.main.async {
            self.setupTV()
        }
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = VocherViewModel(self)
    }
    
    
    func setupUI() {
        navBar.titlelbl.text = "Booking Confirmed"
        navBar.backBtn.addTarget(self, action: #selector(didTapOnBackButton(_:)), for: .touchUpInside)
        if screenHeight < 835 {
            navHeight.constant = 120
        }else {
            navHeight.constant = 160
        }
        commonTableView.registerTVCells(["BookingConfirmedTVCell",
                                         "CommonBookingItinearyTVCell",
                                         "EmptyTVCell",
                                         "LabelTVCell",
                                         "ButtonTVCell",
                                         "SearchFlightResultTVCell",
                                         "BookedTravelDetailsTVCell",
                                         "FlightResultTVCell"])
        
    }
    
    
    func setupTV() {
        
        tablerow.removeAll()
        tablerow.append(TableRow(title:"Booking Confirmed",
                                 cellType:.BookingConfirmedTVCell))
        tablerow.append(TableRow(title:"Flight details",
                                 cellType:.LabelTVCell))
        tablerow.append(TableRow(moreData:vocherdata?.itinearyDet,
                                 cellType:.CommonBookingItinearyTVCell))
        tablerow.append(TableRow(height:15,
                                 cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Traveller Details",
                                 cellType:.LabelTVCell))
        tablerow.append(TableRow(moreData:vocherdata?.booking_details?.first?.customer_details,
                                 cellType:.BookedTravelDetailsTVCell))
        
        tablerow.append(TableRow(height:35,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Thank you for booking with bab safar Your attraction voucher has been shared on the confirmed email.",
                                 key: "booked",
                                 cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Download E - Ticket",
                                 key:"booked",
                                 bgColor: .ButtonColor,
                                 cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:60,
                                 cellType:.EmptyTVCell))
        
        
        
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    @objc func didTapOnBackButton(_ sender:UIButton) {
        BASE_URL = "https://bestfares365.com/mobile_webservices1/mobile/index.php/"
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.keyStr = "ViewController"
        vc.defaultsclearKey = "clear"
        present(vc, animated: true)
    }
    
    override func btnAction(cell: ButtonTVCell) {
        let vocherpdf = "https://bestfares365.com/mobile_webservices1/mobile/index.php/voucher/mobileflightamadeus/\(bookingRefrence)/\(bookingsource)/\(bookingStatus)/show_pdf"
        
        DispatchQueue.main.async {
            if let url = URL(string: vocherpdf) {
                self.downloadFile(url: vocherpdf)
            }
        }
        
        showToast(message: "Download Sucessfull")
        DispatchQueue.main.async {
            self.gotoAboutUsVC(title: "Vocher Details", url: vocherpdf)
        }
        
    }
    
    
    
    
    func gotoAboutUsVC(title:String,url:String) {
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.urlString = url
        vc.titleStr = title
        vc.key = "voucher"
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    func downloadFile(url:String){
        let url = url
        let fileName = "Voucher_\(Date())"
        
        savePdf(urlString: url, fileName: fileName)
        
    }
    
    func savePdf(urlString:String, fileName:String) {
        DispatchQueue.main.async {
            let url = URL(string: urlString)
            let pdfData = try? Data.init(contentsOf: url!)
            let resourceDocPath = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            let pdfNameFromUrl = "BestFare-\(fileName).pdf"
            let actualPath = resourceDocPath.appendingPathComponent(pdfNameFromUrl)
            do {
                try pdfData?.write(to: actualPath, options: .atomic)
                
                self.showToast(message: "pdf successfully saved!")
                //file is downloaded in app data container, I can find file from x code > devices > MyApp > download Container >This container has the file
            } catch {
                print("Pdf could not be saved")
            }
        }
    }
    
    
    
}
