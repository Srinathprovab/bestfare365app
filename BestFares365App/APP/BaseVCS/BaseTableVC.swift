//
//  BaseTableVC.swift
//  Clique
//
//  Created by Codebele-03 on 03/06/21.
//

import UIKit

class BaseTableVC: UIViewController, ButtonTVCellDelegate, TravellersViewTVCellDelegate, DepartDateViewTVCellDelegate, FromViewTVCellDelegate, AddAdultsTVCellDelegate, FlightResultTVCellDelegate, AirlinesFilterTVCellDelegate, FareRulesTVCellDelegate, TDetailsLoginTVCellDelegate, ExtraBaggagesTVCellDelegate, PassengerDetailsTVCellDelegate, ContactDetailsTVCellDelegate, MulticityTVCellDelegate, RoundTripTVCellDelegate, MenuBGTVCellDelegate, LoignOrSignupBtnsTVCellDelegate, TextfieldTVCellDelegate, SignUpWithTVCellDelegate, SelectGenderTVCellDelegate, DropDownTVCellDelegate, RoomsButtonsTVCellDelegate, CharityTVCellDelegate, SeatSelectionTVCellDelegate, AddTravellerTVCellDelegate, DepartureTimeTVCellDelegate, AddAdultTravellerTVCellDelegate, AddChildTravellerTVCellDelegate, AddInfantaTravellerTVCellDelegate, AddRoomsGuestsTVCellDelegate, RoomTVCellDelegate, SortByPriceTVCellDelegate, PriceFilterTVCellDelegate, StarRatingsFilterTVCellDelegate {
   
    
    
    @IBOutlet weak var commonScrollView: UITableView!
    @IBOutlet weak var commonTableView: UITableView!
    @IBOutlet weak var commonTVTopConstraint: NSLayoutConstraint!
    
    
    var commonTVData = [TableRow]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.modalPresentationCapturesStatusBarAppearance = true
        self.navigationController?.navigationBar.isHidden = true
        configureTableView()
        //        self.automaticallyAdjustsScrollViewInsets = false
        
        // Do any additional setup after loading the view.
    }
    
    
    func configureTableView() {
        if commonTableView != nil {
            makeDefaultConfigurationForTable(tableView: commonTableView)
        } else {
            print("commonTableView is nil")
        }
    }
    
    func makeDefaultConfigurationForTable(tableView: UITableView) {
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
        
        tableView.backgroundColor = UIColor.clear
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = UIScrollView.ContentInsetAdjustmentBehavior.never
        } else {
            // Fallback on earlier versions
        }
    }
    
    func serviceCall_Completed_ForNoDataLabel(noDataMessage: String? = nil, data: [Any]? = nil, centerVal:CGFloat? = nil, color: UIColor = HexColor("#182541")) {
        dealWithNoDataLabel(message: noDataMessage, data: data, centerVal: centerVal ?? 2.0, color: color)
    }
    
    func dealWithNoDataLabel(message: String?, data: [Any]?, centerVal: CGFloat = 2.0, color: UIColor = HexColor("#182541")) {
        if commonTableView == nil { return; }
        
        commonTableView.viewWithTag(100)?.removeFromSuperview()
        
        if let message = message, let data = data {
            if data.count == 0 {
                let tableSize = commonTableView.frame.size
                
                let label = UILabel(frame: CGRect(x: 15, y: 15, width: tableSize.width, height: 60))
                label.center = CGPoint(x: (tableSize.width/2), y: (tableSize.height/centerVal))
                label.tag = 100
                label.numberOfLines = 0
                
                label.textAlignment = NSTextAlignment.center
                //                label.font = UIFont.CircularStdMedium(size: 14)
                label.textColor = color
                label.text = message
                
                commonTableView.addSubview(label)
            }
        }
        
    }
    
    
    //Delegate Methods
    func btnAction(cell: ButtonTVCell) {}
    func didTapOnAddTravellersBtnAction(cell: TravellersViewTVCell) {}
    func selectFromCityBtnAction(cell: FromViewTVCell) {}
    func selectToCityBtnAction(cell: FromViewTVCell) {}
    func didTapOndepartDateBtn(cell: DepartDateViewTVCell) {}
    func didTapOnreturnDateBtn(cell: DepartDateViewTVCell) {}
    func didTapOnIncrementBtn(cell: AddAdultsTVCell) {}
    func didTapOnDecrementBtn(cell: AddAdultsTVCell) {}
    func didTapOnShowFlightDetails(cell: FlightResultTVCell) {}
    func didTapOnBookNowBtnAction(cell:FlightResultTVCell){}
    func showMoreButtonAction(cell: AirlinesFilterTVCell) {}
    func didTapOnMoreButton(cell: FareRulesTVCell) {}
    func didTapOnLoginBtn(cell: TDetailsLoginTVCell) {}
    func didTapOnSelectPassengerBtn(cell: ExtraBaggagesTVCell) {}
    func didTapOnAddPassangerBtnAction(cell: PassengerDetailsTVCell) {}
    func didTapOnEditPassengerBtn(cell:PassengerDetailsTVCell){}
    func editingChanged(tf: UITextField) {}
    func donedatePicker(cell: TextfieldTVCell) {}
    func cancelDatePicker(cell: TextfieldTVCell) {}
    func didTapoNCountryCodeBtn(cell: ContactDetailsTVCell) {}
    func didTapOnFromCityBtn(cell: MulticityTVCell) {}
    func didTapOnToCityBtn(cell: MulticityTVCell) {}
    func didTapOnDateBtn(cell: MulticityTVCell) {}
    func didTapOnShowFlightDetails(cell: RoundTripTVCell) {}
    func didTapOnBookNowBtnAction(cell:RoundTripTVCell){}
    func didTapOnLoginBtn(cell: MenuBGTVCell) {}
    func didTapOnEditProfileBtn(cell: MenuBGTVCell) {}
    func didTapOnLoginBtn(cell: LoignOrSignupBtnsTVCell) {}
    func didTapOnSignUpBtn(cell: LoignOrSignupBtnsTVCell) {}
    func didTapOnForGetPassword(cell: TextfieldTVCell) {}
    func editingTextField(tf: UITextField) {}
    func didTapOnShowPasswordBtn(cell: TextfieldTVCell) {}
    func didTapOnGoogleBtn(cell: SignUpWithTVCell) {}
    func didSelectMaleRadioBtn(cell: SelectGenderTVCell) {}
    func didSelectOnFemaleBtn(cell: SelectGenderTVCell) {}
    func didTapOnSaveBtn(cell: SelectGenderTVCell) {}
    func didTapOnDropDownBtn(cell: DropDownTVCell) {}
    func didTapSelectHotelOrCity(cell: TravellersViewTVCell) {}
    func didTapOnCheckinBtn(cell:DepartDateViewTVCell){}
    func didTapOnCheckoutBtn(cell:DepartDateViewTVCell){}
    func didTapOnNoOfNightsBtn(cell:DepartDateViewTVCell){}
    func didTapOnNoOfPersonsBtn(cell:DepartDateViewTVCell){}
    func didTapOnHotelDetailsBtn(cell: RoomsButtonsTVCell) {}
    func didTapOnRoomBtn(cell: RoomsButtonsTVCell) {}
    func didTapOnAminitiesBtn(cell: RoomsButtonsTVCell) {}
    func addCharityBtnAction(cell: CharityTVCell) {}
    func didTapOnMoreInformationBtnAction(cell: CharityTVCell) {}
    func didTapOnChooseYourSeatBtn(cell: SeatSelectionTVCell) {}
    
    func didTapOnAddAdultBtn(cell: AddTravellerTVCell) {}
    func didTapOnAddChildBtn(cell: AddTravellerTVCell) {}
    func didTapOnAddInfantaBtn(cell: AddTravellerTVCell) {}
    func didTapOnEditTraveller(cell: AddAdultsOrGuestTVCell) {}
    func didTapOndeleteTravellerBtnAction(cell: AddAdultsOrGuestTVCell) {}
    func didTapOnSortByFiltersCell(cell: DepartureTimeCVCell) {}
    func doneDobdatePicker(cell: TextfieldTVCell) {}
    func didTapOnIssuingCountryDropDownBtn(cell: DropDownTVCell) {}
    func selectedTitle(cell: TextfieldTVCell) {}
    func didSelectOnOthersBtn(cell: SelectGenderTVCell) {}
    func didTapOnAddAdultBtn(cell: AddAdultTravellerTVCell) {}
    func didTapOnSelectAdultTraveller(Cell: AddAdultsOrGuestTVCell) {}
    func didTapOnAddChildBtn(cell: AddChildTravellerTVCell) {}
    func didTapOnAddInfantaBtn(cell: AddInfantaTravellerTVCell) {}
    func closeBtnAction(cell: AddRoomsGuestsTVCell) {}
    func adultsIncrementButtonAction(cell: AddRoomsGuestsTVCell) {}
    func adultsDecrementBtnAction(cell: AddRoomsGuestsTVCell) {}
    func childrenIncrementButtonAction(cell: AddRoomsGuestsTVCell) {}
    func childrenDecrementBtnAction(cell: AddRoomsGuestsTVCell) {}
    func didTapOnAddRoomBtnAction(cell: ButtonTVCell) {}
    func didTapOnCancellationPolicyBtn(cell: RoomTVCell) {}
    func didTapOnLowToHeighBtnAction(cell: SortByPriceTVCell) {}
    func didTapOnHeighToLowBtnAction(cell: SortByPriceTVCell) {}
    func didSelectAirlines(cell: AirlinesNameTVCell) {}
    func didDeselectAirlines(cell: AirlinesNameTVCell) {}
    func didTapOnShowSliderBtn(cell: PriceFilterTVCell) {}
    func didTapOnStarRatingBtnAction(cell: StarRatingsFilterTVCell) {}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

extension BaseTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = commonTVData[indexPath.row].height
        
        if let height = height {
            return height
        }
        
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
}
extension BaseTableVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == commonTableView {
            return commonTVData.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var commonCell: TableViewCell!
        
        var data: TableRow?
        var commonTV = UITableView()
        
        if tableView == commonTableView {
            data = commonTVData[indexPath.row]
            commonTV = commonTableView
        }
        
        
        if let cellType = data?.cellType {
            switch cellType {
                
                
            case .EmptyTVCell:
                let cell: EmptyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .ButtonTVCell:
                let cell: ButtonTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
                
                
                
                
                //MARK: - LOGIN
                
            case .MenuBGTVCell:
                let cell: MenuBGTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .LoignOrSignupBtnsTVCell:
                let cell: LoignOrSignupBtnsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .TextfieldTVCell:
                let cell: TextfieldTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .UnderLineTVCell:
                let cell: UnderLineTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .SignUpWithTVCell:
                let cell: SignUpWithTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .MenuTVCell:
                let cell: MenuTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .SelectLanguageTVCell:
                let cell: SelectLanguageTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .SelectGenderTVCell:
                let cell: SelectGenderTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .DropDownTVCell:
                let cell: DropDownTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
                //MARK: - Flights
            case .FromViewTVCell:
                let cell: FromViewTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .DepartDateViewTVCell:
                let cell: DepartDateViewTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .TravellersViewTVCell:
                let cell: TravellersViewTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .AddAdultsTVCell:
                let cell: AddAdultsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SelectCabinClassTVCell:
                let cell: SelectCabinClassTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .LabelTVCell:
                let cell: LabelTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .FlightResultTVCell:
                let cell: FlightResultTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .FareRulesTVCell:
                let cell: FareRulesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .BaggageTVCell:
                let cell: BaggageTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .FlightDetailTVCell:
                let cell: FlightDetailTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .TDetailsLoginTVCell:
                let cell: TDetailsLoginTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .CheckinBaggageTVCell:
                let cell: CheckinBaggageTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .ExtraBaggagesTVCell:
                let cell: ExtraBaggagesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .PassengerDetailsTVCell:
                let cell: PassengerDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .ContactDetailsTVCell:
                let cell: ContactDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .FareSummaryTVCell:
                let cell: FareSummaryTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .MulticityTVCell:
                let cell: MulticityTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
                
            case .RoundTripTVCell:
                let cell: RoundTripTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
                
            case .BookingConfirmedTVCell:
                let cell: BookingConfirmedTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .FDTVCell:
                let cell: FDTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .CharityTVCell:
                let cell: CharityTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .SeatSelectionTVCell:
                let cell: SeatSelectionTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
                
                
                //MARK: -  FILTERS
            case .PriceFilterTVCell:
                let cell: PriceFilterTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .AirlinesFilterTVCell:
                let cell: AirlinesFilterTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .DepartureTimeTVCell:
                let cell: DepartureTimeTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .BookedTravelDetailsTVCell:
                let cell: BookedTravelDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .AddTravellerTVCell:
                let cell: AddTravellerTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .AboutUsLabelTVCell:
                let cell: AboutUsLabelTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .AddAdultTravellerTVCell:
                let cell: AddAdultTravellerTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .AddChildTravellerTVCell:
                let cell: AddChildTravellerTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            case .AddInfantaTravellerTVCell:
                let cell: AddInfantaTravellerTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
            case .OnboardFacTVcell:
                let cell: OnboardFacTVcell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .SortByPriceTVCell:
                let cell: SortByPriceTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
                
                //MARK: -  Hotel --------->
            case .HotelResultTVCell:
                let cell: HotelResultTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .HotelImagesTVCell:
                let cell: HotelImagesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
                
            case .RoomsButtonsTVCell:
                let cell: RoomsButtonsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .TravelDetailsTVCell:
                let cell: TravelDetailsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .AddRoomsGuestsTVCell:
                let cell: AddRoomsGuestsTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .HotelDetailsDescTVCell:
                let cell: HotelDetailsDescTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .AmenitiesTVCell:
                let cell: AmenitiesTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .RoomTVCell:
                let cell: RoomTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
                
            case .CommonBookingItinearyTVCell:
                let cell: CommonBookingItinearyTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                commonCell = cell
                
                
            case .StarRatingsFilterTVCell:
                let cell: StarRatingsFilterTVCell = commonTV.dequeTVCell(indexPath: indexPath)
                cell.delegate = self
                commonCell = cell
                
            default:
                print("handle this case in getCurrentCellAt")
            }
        }
        
        commonCell.cellInfo = data
        commonCell.indexPath = indexPath
        commonCell.selectionStyle = .none
        
        return commonCell
    }
} 



extension UITableView {
    func registerTVCells(_ classNames: [String]) {
        for className in classNames {
            register(UINib(nibName: className, bundle: nil), forCellReuseIdentifier: className)
        }
    }
    
    func dequeTVCell<T: UITableViewCell>(indexPath: IndexPath, osVersion: String? = nil) -> T {
        let className = String(describing: T.self) + "\(osVersion ?? "")"
        guard let cell = dequeueReusableCell(withIdentifier: className, for: indexPath) as? T  else { fatalError("Couldn’t get cell with identifier \(className)") }
        return cell
    }
    
    func dequeTVCellForFooter<T: UITableViewCell>() -> T {
        let className = String(describing: T.self)
        guard let cell = dequeueReusableCell(withIdentifier: className) as? T  else { fatalError("Couldn’t get cell with identifier \(className)") }
        return cell
    }
    
    
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .AppLabelColor
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = .poppinsSemiBold(size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
    
}
