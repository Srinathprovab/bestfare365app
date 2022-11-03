//
//  CalenderVC.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit
import JTAppleCalendar


class CalenderVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarViewHolder: UIView!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var sundayLabel: UILabel!
    @IBOutlet weak var mondayLabel: UILabel!
    @IBOutlet weak var tuesdayLabel: UILabel!
    @IBOutlet weak var thursdayLabel: UILabel!
    @IBOutlet weak var wednesdayLabel: UILabel!
    @IBOutlet weak var fridayLabel: UILabel!
    @IBOutlet weak var saturdayLabel: UILabel!
    @IBOutlet weak var selectBtn: UIButton!
    @IBOutlet weak var selectBtnView: UIView!
    @IBOutlet weak var selectlbl: UILabel!
    @IBOutlet weak var holderViewTopHeight: NSLayoutConstraint!
    @IBOutlet weak var hview: UIView!
    @IBOutlet weak var leftImg: UIImageView!
    @IBOutlet weak var leftBtn: UIButton!
    @IBOutlet weak var rightImg: UIImageView!
    @IBOutlet weak var rightBtn: UIButton!
    @IBOutlet weak var calViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var depView: UIView!
    @IBOutlet weak var retView: UIView!
    @IBOutlet weak var deplbl: UILabel!
    @IBOutlet weak var depimg: UIImageView!
    @IBOutlet weak var depDatelbl: UILabel!
    @IBOutlet weak var retlbl: UILabel!
    @IBOutlet weak var retimg: UIImageView!
    @IBOutlet weak var retDatelbl: UILabel!
    @IBOutlet weak var lineView: UIView!
    
    
    
    
    
    static var newInstance: CalenderVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CalenderVC
        return vc
    }
    
    var titleStr: String?
    var selectedfirstDate : Date?
    var selectedlastDate : Date?
    let df = DateFormatter()
    var startDate = Date().dateByAddingMonths(months: -12).startOfMonth
    var endDate = Date().dateByAddingMonths(months: 12).endOfMonth
    var selectedDays: Date?
    let grayView = UIView()
    var btnDoneActionBool = Bool()
    var calstartDate = String()
    var calendDate = String()
    var celltag = Int()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.celltag = Int(defaults.string(forKey: UserDefaultsKeys.cellTag) ?? "0") ?? 0
        
        if screenHeight > 835 {
            navHeight.constant = 140
        }else {
            navHeight.constant = 130
        }
        
        
        if let journyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            switch journyType {
            case "oneway":
                depDatelbl.text = defaults.string(forKey: UserDefaultsKeys.calDepDate)
                break
            case "circle":
                depDatelbl.text = defaults.string(forKey: UserDefaultsKeys.rcalDepDate)
                retDatelbl.text = defaults.string(forKey: UserDefaultsKeys.rcalRetDate)
                break
            case "multicity":
                
                break
            default:
                break
            }
        }
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        updateUI()
        setupCalView()
    }
    
    func setupUI() {
        // nav.titlelbl.text = "Calendar"
        //  nav.backBtn.addTarget(self, action: #selector(backbtnAction(_:)), for: .touchUpInside)
        selectBtn.setTitle("", for: .normal)
        selectBtn.isUserInteractionEnabled = false
        setupViews(v: selectBtnView, radius: 4, color: .BtnUnselectedColor)
        setupLabels(lbl: selectlbl, text: "Done", textcolor: .WhiteColor, font: .sigvarbold(size: 20))
        
        setupLabels(lbl: nav.titlelbl, text: "Choose a date", textcolor: .LabelTitleColor, font: .ProximaNovaBold(size: 20))
        nav.titlelbl.textAlignment = .center
        nav.backImg.image = UIImage(named: "leftarrow")?.withRenderingMode(.alwaysOriginal)
        nav.backBtn.addTarget(self, action: #selector(dismisVC(_:)), for: .touchUpInside)
        nav.contentView.backgroundColor = .WhiteColor
        depView.backgroundColor = .ViewLightBlueColor
        retView.backgroundColor = .ViewLightBlueColor
        lineView.backgroundColor = .LabelTitleColor
        setupLabels(lbl: deplbl, text: "Depart Date", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 16))
        setupLabels(lbl: retlbl, text: "Return Date", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 16))
        setupLabels(lbl: depDatelbl, text: "", textcolor: .LabelTitleColor, font: .SigvarRegular(size: 18))
        setupLabels(lbl: retDatelbl, text: "", textcolor: .LabelTitleColor, font: .SigvarRegular(size: 18))
        depimg.image = UIImage(named: "caldate")?.withRenderingMode(.alwaysOriginal)
        retimg.image = UIImage(named: "caldate")?.withRenderingMode(.alwaysOriginal)
        
        
    }
    
    @objc func dismisVC(_ sender:UIButton) {
        self.dismiss(animated: true)
    }
    
    @objc func backbtnAction(_ sender:UIButton) {
        self.dismiss(animated: true)
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.5
        v.layer.borderColor = UIColor.BorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func updateUI() {
        
        self.view.backgroundColor = .WhiteColor
        self.holderView.backgroundColor = .clear
        self.hview.backgroundColor = .WhiteColor
        leftImg.image = UIImage(named: "leftarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.CalSelectedColor)
        rightImg.image = UIImage(named: "rightarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.CalSelectedColor)
        holderView.backgroundColor = .white
        setupLabels(lbl: monthLabel, text: "", textcolor: .LabelTitleColor, font: .ProximaNovaRegular(size: 18))
        setupLabels(lbl: sundayLabel, text: "SU", textcolor: .LabelTitleColor, font: .InterRegular(size: 14))
        setupLabels(lbl: mondayLabel, text: "MO", textcolor: .LabelTitleColor, font: .InterRegular(size: 14))
        setupLabels(lbl: tuesdayLabel, text: "TU", textcolor: .LabelTitleColor, font: .InterRegular(size: 14))
        setupLabels(lbl: wednesdayLabel, text: "WE", textcolor: .LabelTitleColor, font: .InterRegular(size: 14))
        setupLabels(lbl: thursdayLabel, text: "TH", textcolor: .LabelTitleColor, font: .InterRegular(size: 14))
        setupLabels(lbl: fridayLabel, text: "FR", textcolor: .LabelTitleColor, font: .InterRegular(size: 14))
        setupLabels(lbl: saturdayLabel, text: "SA", textcolor: .LabelTitleColor, font: .InterRegular(size: 14))
        
    }
    
    func setupCalView() {
        
        
        calendarViewHolder.backgroundColor = .clear
        
        // Do any additional setup after loading the view.
        calendarView.scrollDirection  = .horizontal
        calendarView.scrollingMode = .stopAtEachSection
        calendarView.showsHorizontalScrollIndicator = false
        
        calendarView.scrollToDate(Date(),animateScroll: false)
        
        calendarView.register(UINib(nibName: "calendarCVCell", bundle: nil), forCellWithReuseIdentifier: "calendarCVCell")
        //        calendarView.allowsSelection = true
        
        
        if let journeyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
            if journeyType == "oneway" {
                calendarView.allowsMultipleSelection = false
                retView.isHidden = true
            }else if journeyType == "circle" {
                retView.isHidden = false
                calendarView.allowsMultipleSelection = true
            }else {
                calendarView.allowsMultipleSelection = false
            }
        }
        calendarView.isRangeSelectionUsed = true
        
        calendarView.ibCalendarDelegate = self
        calendarView.ibCalendarDataSource = self
        calendarView.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        calendarView.minimumLineSpacing = 5
        calendarView.minimumInteritemSpacing = 5
        
        
        calendarView.visibleDates { (visibleDates) in
            self.setupMonthLabel(date: visibleDates.monthDates.first?.date ?? Date())
        }
        
        let panGensture = UILongPressGestureRecognizer(target: self, action: #selector(didStartRangeSelecting(gesture:)))
        panGensture.minimumPressDuration = 0.5
        calendarView.addGestureRecognizer(panGensture)
        
    }
    
    
    @objc func didStartRangeSelecting(gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: gesture.view!)
        let rangeSelectedDates = calendarView.selectedDates
        
        guard let cellState = calendarView.cellStatus(at: point) else { return }
        
        if !rangeSelectedDates.contains(cellState.date) {
            let dateRange = calendarView.generateDateRange(from: rangeSelectedDates.first ?? cellState.date, to: cellState.date)
            calendarView.selectDates(dateRange, keepSelectionIfMultiSelectionAllowed: true)
        }
    }
    
    func setupMonthLabel(date: Date) {
        monthLabel.text = date.monthYearName
    }
    
    
    func handleConfiguration(cell: JTAppleCell?, cellState: CellState) {
        guard let cell = cell as? calendarCVCell else { return }
        handleCellColor(cell: cell, cellState: cellState)
        handleCellSelected(cell: cell, cellState: cellState)
        
        if calendarView.selectedDates.count == 0 {
            
        }else if calendarView.selectedDates.count == 1 {
            
            calstartDate = "\(cellState.date.customDateStringFormat("dd-MM-YYYY"))"
            calendDate = "\(cellState.date.customDateStringFormat("dd-MM-YYYY"))"
            
        }else {
            
            
            calstartDate = calendarView.selectedDates.first?.customDateStringFormat("dd-MM-YYYY") ?? ""
            calendDate = calendarView.selectedDates.last?.customDateStringFormat("dd-MM-YYYY") ?? ""
            
            
        }
    }
    
    
    func handleCellColor(cell: calendarCVCell, cellState: CellState) {
        if cellState.dateBelongsTo == .thisMonth {
            cell.label.textColor = UIColor.black
        } else {
            cell.label.textColor = UIColor.lightGray
        }
    }
    
    func handleCellSelected(cell: calendarCVCell, cellState: CellState) {
        cell.selectedView.isHidden = !cellState.isSelected
        
        
        switch cellState.selectedPosition() {
        case .left:
            cell.selectedView.layer.cornerRadius = 0
            cell.selectedView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMinXMinYCorner]
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.CalSelectedColor
            cell.label.textColor = UIColor.white
            break
        case .middle:
            cell.selectedView.layer.cornerRadius = 0
            cell.selectedView.layer.maskedCorners = []
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.CalMultiSelectedColor
            cell.label.textColor = UIColor.LabelTitleColor
            break
        case .right:
            cell.selectedView.layer.cornerRadius = 0
            cell.selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.CalSelectedColor
            cell.label.textColor = UIColor.white
            break
        case .full:
            cell.selectedView.layer.cornerRadius = 0
            cell.selectedView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
            cell.selectedView.isHidden = false
            cell.selectedView.backgroundColor = UIColor.CalSelectedColor
            cell.label.textColor = UIColor.white
            break
            
        default:
            break
            
        }
    }
    
    
    
    @IBAction func leftButtonClick(_ sender: Any) {
        calendarView.scrollToSegment(.previous)
    }
    
    @IBAction func rightButtonClick(_ sender: Any) {
        calendarView.scrollToSegment(.next)
    }
    
    
    @IBAction func selectDateBtnAction(_ sender: Any) {
        print(defaults.string(forKey: UserDefaultsKeys.calDepDate))
        goToHomeVC()
    }
    
    func goToHomeVC() {
        // NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
        
        guard let vc = HomeVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: false)
    }
}



extension CalenderVC: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        
        handleConfiguration(cell: cell, cellState: cellState)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarCVCell", for: indexPath) as! calendarCVCell
        cell.label.text = cellState.text
        // cell.holderView.backgroundColor = HexColor("#ECF3FD")
        handleConfiguration(cell: cell, cellState: cellState)
        //        self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        
        if cellState.dateBelongsTo == .thisMonth {
            cell.isHidden = false
        } else {
            cell.isHidden = true
        }
        
        if date <= Date(){
            //  leftImg.image = UIImage(named: "leftarrow")?.withRenderingMode(.alwaysOriginal).withTintColor(.BorderColor)
            cell.label.textColor = HexColor("#555555", alpha: 0.4)
        }else {
            cell.label.textColor = .LabelTitleColor
        }
        
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupMonthLabel(date: visibleDates.monthDates.first!.date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleConfiguration(cell: cell, cellState: cellState)
        print(cellState.date.customDateStringFormat())
        print("start date  : \(calstartDate)")
        print("End date  : \(calendDate)")
        
        
        if let selectedTab = defaults.string(forKey: UserDefaultsKeys.tabselect) {
            if selectedTab == "Flight" {
                
                if let selectedJourneyType = defaults.string(forKey: UserDefaultsKeys.journeyType) {
                    if selectedJourneyType == "oneway" {
                        defaults.set(calstartDate, forKey: UserDefaultsKeys.calDepDate)
                        depDatelbl.text = calstartDate
                    }else if selectedJourneyType == "circle" {
                        
                        depDatelbl.text = calstartDate
                        retDatelbl.text = calendDate
                        defaults.set(calstartDate, forKey: UserDefaultsKeys.rcalDepDate)
                        defaults.set(calendDate, forKey: UserDefaultsKeys.rcalRetDate)
                        
                        print("calstartDate\(calstartDate)")
                        print("calendDate\(calendDate)")
                        
                    }else {
                        print("mcalDepDate\(calstartDate)")
                        
                        defaults.set(calstartDate, forKey: UserDefaultsKeys.mcalDate)
                        calDate[self.celltag] = calstartDate
                        depatureDatesArray[self.celltag] = calstartDate
                    }
                }
                
                
            }else {
                defaults.set(calstartDate, forKey: UserDefaultsKeys.checkin)
                defaults.set(calendDate, forKey: UserDefaultsKeys.checkout)
            }
        }
        
        
        
        if selectedfirstDate != nil {
            if date < selectedfirstDate! {
                calendarView.selectDates(from: date, to: selectedfirstDate!,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
                selectedlastDate = calendarView.selectedDates.last
                selectedfirstDate = calendarView.selectedDates.first
                
            } else {
                selectedlastDate = calendarView.selectedDates.last
                calendarView.selectDates(from: selectedfirstDate!, to: date,  triggerSelectionDelegate: false, keepSelectionIfMultiSelectionAllowed: true)
            }
        } else {
            selectedfirstDate = calendarView.selectedDates.first
            selectedlastDate = nil
            handleConfiguration(cell: cell, cellState: cellState)
        }
        
        
        
        selectBtn.isUserInteractionEnabled = true
        setupViews(v: selectBtnView, radius: 4, color: .ButtonColor)
        
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleConfiguration(cell: cell, cellState: cellState)
        
        if selectedfirstDate != nil{
            if date > (selectedfirstDate!){
                calendarView.deselectDates(from: selectedfirstDate!, to: date, triggerSelectionDelegate: false)
                selectedfirstDate = calendarView.selectedDates.first
            } else if selectedlastDate == nil || date == selectedlastDate {
                selectedfirstDate = nil
                selectedlastDate = nil
                handleConfiguration(cell: cell, cellState: cellState)
                
            }else {
                handleConfiguration(cell: cell, cellState: cellState)
            }
        }
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        print("configureCalendar")
        let parameter = ConfigurationParameters(startDate: self.startDate,
                                                endDate: self.endDate,
                                                numberOfRows: 6,
                                                generateInDates: .forAllMonths,
                                                generateOutDates: .tillEndOfGrid,
                                                firstDayOfWeek: .monday,
                                                hasStrictBoundaries:true)
        return parameter
    }
    
    func calendar(_ calendar: JTAppleCalendarView, shouldSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) -> Bool {
        return date >= Date()
    }
    
}


func convertDateFormat(inputDate: String,f1:String,f2:String) -> String {
    
    let olDateFormatter = DateFormatter()
    olDateFormatter.dateFormat = f1
    
    guard let oldDate = olDateFormatter.date(from: inputDate) else { return "" }
    
    let convertDateFormatter = DateFormatter()
    convertDateFormatter.dateFormat = f2
    
    return convertDateFormatter.string(from: oldDate)
}
