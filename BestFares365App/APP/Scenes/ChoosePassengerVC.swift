//
//  ChoosePassengerVC.swift
//  BestFares365App
//
//  Created by FCI on 28/10/22.
//

import UIKit

class ChoosePassengerVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    static var newInstance: ChoosePassengerVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ChoosePassengerVC
        return vc
    }
    var tablerow = [TableRow]()
    var count = 1
    var keyString = String()
    var adultsCount = 1
    var childCount = 0
    var seatinfantsCount = 0
    var lapinfantsCount = 0
    var roomCountArray = [Int]()
    var passengertypeArray = [String]()
    
    
    
    //MARK:- VIEW LOADING FUNCTION
    override func viewWillAppear(_ animated: Bool) {
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.tabselect){
            if selectedTab == "Flight" {
                if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if journeyType == "oneway" {
                        
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "0") ?? 0
                        seatinfantsCount = Int(defaults.string(forKey: UserDefaultsKeys.seatinfants) ?? "0") ?? 0
                        lapinfantsCount = Int(defaults.string(forKey: UserDefaultsKeys.lapinfants) ?? "0") ?? 0
                        
                    }else if journeyType == "circle"{
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "0") ?? 0
                        seatinfantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rseatinfants) ?? "0") ?? 0
                        lapinfantsCount = Int(defaults.string(forKey: UserDefaultsKeys.rlapinfants) ?? "0") ?? 0
                        
                    }else {
                        adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "1") ?? 0
                        childCount = Int(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "0") ?? 0
                        seatinfantsCount = Int(defaults.string(forKey: UserDefaultsKeys.mseatinfants) ?? "0") ?? 0
                        lapinfantsCount = Int(defaults.string(forKey: UserDefaultsKeys.mlapinfants) ?? "0") ?? 0
                        
                    }
                }
                
            }else {
                adultsCount = Int(defaults.string(forKey: UserDefaultsKeys.hadultCount) ?? "1") ?? 1
                childCount = Int(defaults.string(forKey: UserDefaultsKeys.hchildCount) ?? "0") ?? 0
                
            }
        }
    }
    
    
    //MARK:- VIEW LOADING FUNCTION
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        
    }
    
    //MARK:- SETUP UI
    func setupUI() {
        setupLabels(lbl: nav.titlelbl, text: "Choose a passenger", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 20))
        nav.titlelbl.textAlignment = .center
        nav.backImg.image = UIImage(named: "leftarrow")?.withRenderingMode(.alwaysOriginal)
        nav.backBtn.addTarget(self, action: #selector(dismisVC(_:)), for: .touchUpInside)
        nav.contentView.backgroundColor = .WhiteColor
        
        //MARK:- REGISTER TABLE VIEW CALLS
        commonTableView.registerTVCells(["ButtonTVCell","AddAdultsTVCell","EmptyTVCell","SelectCabinClassTVCell","LabelTVCell"])
        setupTVCells()
    }
    
    
    //MARK:- DISMISS VIEW
    @objc func dismisVC(_ sender:UIButton) {
        self.dismiss(animated: true)
    }
    
    
    //MARK:- SETUP LABELS
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    
    //MARK:- APPEND TABLE VIEW CELLS
    func setupTVCells() {
        tablerow.removeAll()
        
        tablerow.append((TableRow(title:"Add Number Of Travellers",cellType: .LabelTVCell)))
        tablerow.append((TableRow(title:"Adults",subTitle: "+12 yrs",text: String(adultsCount),cellType: .AddAdultsTVCell)))
        tablerow.append((TableRow(title:"Children",subTitle: "+2-12 yrs",text: String(childCount),cellType: .AddAdultsTVCell)))
        tablerow.append((TableRow(title:"Seat Infants ",subTitle: "Under 2",text: String(seatinfantsCount),cellType: .AddAdultsTVCell)))
        tablerow.append((TableRow(title:"Lap Infants ",subTitle: "Under 2",text: String(lapinfantsCount),cellType: .AddAdultsTVCell)))
        tablerow.append((TableRow(title:"Cabin Class",cellType: .SelectCabinClassTVCell)))
        tablerow.append((TableRow(height:50,cellType: .EmptyTVCell)))
        tablerow.append((TableRow(title:"Done",bgColor: .ButtonColor,cellType: .ButtonTVCell)))
        tablerow.append((TableRow(height:50,cellType: .EmptyTVCell)))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    //MARK:- TAP ON INCREMENT BUTTON ACTION
    override func didTapOnIncrementBtn(cell: AddAdultsTVCell) {
        
        if (seatinfantsCount) > 8  || (lapinfantsCount) > 8{
            showToast(message: "Infants Count not mor than 9 ")
            showAlertOnWindow(title: "", message: "Infants Count not mor than 9", titles: ["OK"], completionHanlder: nil)
        }else if (adultsCount + childCount) > 8 {
            showToast(message: "adultsCount not mor than 9 ")
            showAlertOnWindow(title: "", message: "Adults Count Not More Than 9", titles: ["OK"], completionHanlder: nil)
        }else  {
            if cell.count >= 0 {
                cell.count += 1
                cell.countlbl.text = "\(cell.count)"
            }
            
            if cell.titlelbl.text == "Adults" {
                adultsCount = cell.count
            }else if cell.titlelbl.text == "Children"{
                childCount = cell.count
            }else if cell.titlelbl.text == "Seat Infants "{
                seatinfantsCount = cell.count
            }else {
                lapinfantsCount = cell.count
            }
            
        }
        
        print("Total Count === \(adultsCount + childCount + seatinfantsCount)")
        defaults.set((adultsCount + childCount + seatinfantsCount), forKey: UserDefaultsKeys.totalTravellerCount)
        
    }
    
    
    //MARK:- TAP ON DECREMENT BUTTON ACTION
    override func didTapOnDecrementBtn(cell: AddAdultsTVCell) {
        
        if cell.count > 0 {
            cell.count -= 1
            // cell.countlbl.text = "\(cell.count)"
        }
        print(cell.count)
        
        if cell.titlelbl.text == "Adults" {
            adultsCount = cell.count
            // deleteRecords(title: "Adult", index: cell.count)
        }else if cell.titlelbl.text == "Children"{
            childCount = cell.count
            // deleteRecords(title: "Children", index: cell.count)
        }else if cell.titlelbl.text == "Seat Infants "{
            seatinfantsCount = cell.count
            // deleteRecords(title: "Children", index: cell.count)
        }else {
            lapinfantsCount = cell.count
            // deleteRecords(title: "Infantas", index: cell.count)
        }
        
        
        if (adultsCount + childCount) > 8 {
            showToast(message: "adultsCount not mor than 9 ")
            showAlertOnWindow(title: "", message: "Adults Count Not More Than 9", titles: ["OK"], completionHanlder: nil)
        }else {
            cell.countlbl.text = "\(cell.count)"
            
        }
        
        
        print("Total Count === \(adultsCount + childCount + seatinfantsCount + lapinfantsCount)")
        defaults.set((adultsCount + childCount + seatinfantsCount + lapinfantsCount), forKey: UserDefaultsKeys.totalTravellerCount)
        
    }
    
    
    
    
    func gotoHomeVC() {
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.adultCount) ?? "") Adults | \(defaults.string(forKey: UserDefaultsKeys.childCount) ?? "") Children | \(defaults.string(forKey: UserDefaultsKeys.seatinfants) ?? "") Infants | \(defaults.string(forKey: UserDefaultsKeys.selectClass) ?? "")"
                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.travellerDetails)
            }else if journeyType == "circle" {
                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.radultCount) ?? "") Adults | \(defaults.string(forKey: UserDefaultsKeys.rchildCount) ?? "") Children | \(defaults.string(forKey: UserDefaultsKeys.rseatinfants) ?? "") Infants | \(defaults.string(forKey: UserDefaultsKeys.rDepclass) ?? ""),\(defaults.string(forKey: UserDefaultsKeys.rRetclass) ?? "")"
                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.rtravellerDetails)
            }else{
                let totaltraverlers = "\(defaults.string(forKey: UserDefaultsKeys.madultCount) ?? "") Adults | \(defaults.string(forKey: UserDefaultsKeys.mchildCount) ?? "") Children | \(defaults.string(forKey: UserDefaultsKeys.mseatinfants) ?? "") Infants | \(defaults.string(forKey: UserDefaultsKeys.mselectClass) ?? "")"
                defaults.set(totaltraverlers, forKey: UserDefaultsKeys.mtravellerDetails)
            }
        }
        
        
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: false)
    }
    
    
    //MARK:- DONE BUTTON ACTION
    override func btnAction(cell: ButtonTVCell) {
        print("button tap ...")
        print("adultsCount \(adultsCount)")
        print("childCount \(childCount)")
        print("seatinfantsCount \(seatinfantsCount)")
        
        if cell.titlelbl.text == "Done" {
            if let selectedTab = defaults.string(forKey: UserDefaultsKeys.tabselect){
                if selectedTab == "Flight" {
                    
                    if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                        if journeyType == "oneway" {
                            defaults.set(adultsCount, forKey: UserDefaultsKeys.adultCount)
                            defaults.set(childCount, forKey: UserDefaultsKeys.childCount)
                            defaults.set(seatinfantsCount, forKey: UserDefaultsKeys.seatinfants)
                            defaults.set(lapinfantsCount, forKey: UserDefaultsKeys.lapinfants)
                            
                            
                        }else if journeyType == "circle" {
                            defaults.set(adultsCount, forKey: UserDefaultsKeys.radultCount)
                            defaults.set(childCount, forKey: UserDefaultsKeys.rchildCount)
                            defaults.set(seatinfantsCount, forKey: UserDefaultsKeys.rseatinfants)
                            defaults.set(lapinfantsCount, forKey: UserDefaultsKeys.rlapinfants)
                            
                        }else {
                            defaults.set(adultsCount, forKey: UserDefaultsKeys.madultCount)
                            defaults.set(childCount, forKey: UserDefaultsKeys.mchildCount)
                            defaults.set(seatinfantsCount, forKey: UserDefaultsKeys.mseatinfants)
                            defaults.set(lapinfantsCount, forKey: UserDefaultsKeys.mlapinfants)
                            
                        }
                    }
                    
                    
                    gotoHomeVC()
                }else {
                    defaults.set(adultsCount, forKey: UserDefaultsKeys.hadultCount)
                    defaults.set(childCount, forKey: UserDefaultsKeys.hchildCount)
                    
                    NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
                    dismiss(animated: false)
                }
            }
        }else {
            print("Add Room ......")
            count += 1
            roomCountArray.append(count)
            //  setupSearchHotelsEconomyTVCells()
        }
        
        
        //        if adultsCount > 0 {
        //            passengertypeArray.append("Adult")
        //        }
        //        if childCount > 0 {
        //            passengertypeArray.append("Child")
        //        }
        //        if infantsCount > 0 {
        //            passengertypeArray.append("Infanta")
        //        }
        //
        //        passengertypeArray = passengertypeArray.unique()
        //        if adultsCount == 0 {
        //            if let index = passengertypeArray.firstIndex(of: "Adult") {
        //                passengertypeArray.remove(at: index)
        //            }
        //        }
        //        if childCount == 0 {
        //            if let index = passengertypeArray.firstIndex(of: "Child") {
        //                passengertypeArray.remove(at: index)
        //            }
        //        }
        //
        //        if infantsCount == 0 {
        //            if let index = passengertypeArray.firstIndex(of: "Infanta") {
        //                passengertypeArray.remove(at: index)
        //            }
        //        }
        //        defaults.set(passengertypeArray.joined(separator: ","), forKey: UserDefaultsKeys.passengertype)
        
    }
    
    
}
