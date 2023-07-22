//
//  UIModels.swift
//  shifuApp
//
//  Created by Codebele on 12/09/19.
//  Copyright © 2019 Codebele. All rights reserved.
//

import Foundation
import UIKit


enum VCName {
    
}

enum socialSignUpType {
    case twitter
    case facebook
    case gmail
}

enum TVCellType {
    
    case ButtonTVCell
    case EmptyTVCell
    
    
    //MARK: - LOGIN
    case MenuBGTVCell
    case LoignOrSignupBtnsTVCell
    case TextfieldTVCell
    case UnderLineTVCell
    case SignUpWithTVCell
    case MenuTVCell
    case SelectLanguageTVCell
    case SelectGenderTVCell
    case DropDownTVCell
    
    //MARK: - Flights
    case FromViewTVCell
    case DepartDateViewTVCell
    case TravellersViewTVCell
    case AddAdultsTVCell
    case SelectCabinClassTVCell
    case LabelTVCell
    case CharityTVCell
    
    
    //MARK: - FLIGHTS
    case FlightResultTVCell
    case PriceFilterTVCell
    case AirlinesFilterTVCell
    case DepartureTimeTVCell
    case FareRulesTVCell
    case BaggageTVCell
    case FlightDetailTVCell
    case TDetailsLoginTVCell
    case CheckinBaggageTVCell
    case ExtraBaggagesTVCell
    case PassengerDetailsTVCell
    case ContactDetailsTVCell
    case FareSummaryTVCell
    case MulticityTVCell
    case RoundTripTVCell
    case BookingConfirmedTVCell
    case BookedTravelDetailsTVCell
    case FDTVCell
    case SeatSelectionTVCell
    case AddTravellerTVCell
    case AboutUsLabelTVCell
    case AddAdultTravellerTVCell
    case AddChildTravellerTVCell
    case AddInfantaTravellerTVCell
    case OnboardFacTVcell
    case SortByPriceTVCell
    case CommonBookingItinearyTVCell
    
    //MARK: - Hotel
    case HotelResultTVCell
    case HotelImagesTVCell
    case RoomsButtonsTVCell
    case TravelDetailsTVCell
    case AddRoomsGuestsTVCell
    case HotelDetailsDescTVCell
    case AmenitiesTVCell
    case RoomTVCell
    case StarRatingsFilterTVCell
    
    
}

enum CVCellType {
    
    
}

enum BorderSeq {
    case roundTop
    case first
    case middle
    case lastbutOne
    case last
    case twosides
    case none
}


class TableRow {
    
    var title: String?
    var subTitle: String?
    
    var text: String?
    var headerText: String?
    var buttonTitle: String?
    var key :String?
    var data:Any?
    var errormsg:String?
    var key1: String?
    var itemType: CVCellType?
    var isSecure:Bool = false
    var isSelected:Bool = false
    //    var source: SNClassName? = nil
    var needsBorder: Bool? = nil
    var needDoneButton: Bool? = nil
    var canGotoNextPage: Bool? = nil
    var signInType:socialSignUpType?
    var image: String?
    var height: CGFloat?
    var isError: Bool? = nil
    var imageSize: String? = nil
    var percentValue: Float?
    
    
    var isOptional:Bool = true
    var moreData : Any?
    var noInput :Bool = false
    var tempText:String?
    var characterLimit: Int?
    var characterLimit2: Int?
    var borderSeq:BorderSeq?
    var keyboardDistance:CGFloat?
    var errorMessage: String?
    var hasHyperLink: Bool?
    var disabled: Bool?
    var disableLeftPortion: Bool?
    var isEditable: Bool?
    var lineSpace: CGFloat?
    var tempInfo: Any? // Used to catch image while generating preview image for video
    var bgColor: UIColor?
    var separatorColor: UIColor?
    var titleColor: UIColor?
    var titleFont: UIFont?
    var cellbordercolor:CGColor?
    var fontSize: CGFloat? //Used to give custom height for empty cell
    
    var questionType: String?
    var questionBase: String?
    var TotalQuestions: String?
    var questionNumber: String?
    var questionHeading: String?
    var questionDescription: String?
    var shareImg: String?
    var shareLink: String?
    var cellType: TVCellType?
    var userCatdetails: Any?
    var data1: Any?
    var data2: Any?
    
    var fromTime: String?
    var toTime: String?
    var fromCity: String?
    var toCity: String?
    var noosStops: String?
    var airlineslogo :String?
    var airlinesname: String?
    var airlinesCode: String?
    var seatsLeft: String?
    var baggage: String?
    var price:String?
    var travelTime:String?
    
    
    var hotelName: String?
    var hotelCode: String?
    var hotelAddress: String?
    var hotelratings: String?
    var roomsLeft: String?
    var hotelPrice :String?
    var reviews: String?
    var hotelImg: String?
    
    
    
    
    
    init() {}
    
    init(title: String? = nil, subTitle: String? = nil,fromTime: String? = nil ,
         toTime: String? = nil,
         fromCity: String? = nil ,
         toCity: String? = nil ,
         noosStops: String? = nil ,
         airlineslogo: String? = nil ,
         airlinesname: String? = nil ,
         airlinesCode: String? = nil,
         seatsLeft: String? = nil ,
         baggage: String? = nil ,
         price: String? = nil ,
         travelTime: String? = nil ,
         
         hotelName: String? = nil,
         hotelCode: String? = nil ,
         hotelAddress: String? = nil ,
         hotelratings: String? = nil ,
         hotelPrice:String? = nil,
         roomsLeft: String? = nil ,
         reviews: String? = nil ,
         hotelImg: String? = nil,
         
         
         
         key: String? = nil, text: String? = nil, headerText: String? = nil, buttonTitle: String? = nil, keyboardType: UIKeyboardType = .default, data: Any? = nil, errormsg: String? = nil, key1: String? = nil, signInType: socialSignUpType? = nil , itemType: CVCellType? = nil, isSecure: Bool = false, isSelected: Bool = false,  needsBorder: Bool? = nil, needDoneButton: Bool? = nil, canGotoNextPage: Bool? = nil, image: String? = nil, imageSize: String? = nil, height: CGFloat? = nil, isOptional: Bool = true, moreData: Any? = nil, noInput: Bool = false, tempText: String? = nil, characterLimit: Int? = nil,characterLimit2: Int? = nil, hasHyperLink: Bool? = nil, disabled: Bool? = nil, disableLeftPortion: Bool? = nil, isEditable: Bool? = nil, lineSpace: CGFloat? = nil, shouldDoDualFieldValidations: Bool? = nil, cellUIUpdateCallback: ((_ cell: Any) -> Void)? = nil, cellActions: ((_ cell: Any, _ actionType: String, _ moreData: Any) -> Void)? = nil, autoCapitalization: UITextAutocapitalizationType? = nil, fontSize: CGFloat? = nil, borderSeq: BorderSeq? = nil, keyboardDistance: CGFloat? = nil, itemSize: CGSize? = nil,
         isError: Bool? = nil,tempInfo: Any? = nil, bgColor: UIColor? = nil,separatorColor: UIColor? = nil,titleColor: UIColor? = nil, titleFont: UIFont? = nil,questionType: String? = nil,TotalQuestions: String? = nil,questionNumber: String? = nil,questionHeading: String? = nil,questionDescription: String? = nil,cellType: TVCellType? = nil, percentValue: Float? = nil,cellbordercolor:CGColor? = nil, userCatdetails: Any? = nil,data1: Any? = nil,data2: Any? = nil, shareLink: String? = nil,shareImg: String? = nil,questionBase: String? = nil ) {
        
        self.title = title
        self.bgColor = bgColor
        self.subTitle = subTitle
        
        
        self.fromTime = fromTime
        self.toTime = toTime
        self.fromCity = fromCity
        self.toCity = toCity
        self.noosStops = noosStops
        self.airlinesname = airlinesname
        self.airlineslogo = airlineslogo
        self.airlinesCode = airlinesCode
        self.seatsLeft = seatsLeft
        self.baggage = baggage
        self.price = price
        self.travelTime = travelTime
        
        self.hotelName = hotelName
        self.hotelCode = hotelCode
        self.hotelAddress = hotelAddress
        self.hotelratings = hotelratings
        self.roomsLeft = roomsLeft
        self.reviews = reviews
        self.hotelImg = hotelImg
        self.hotelPrice = hotelPrice
        
        self.key = key
        self.text = text
        self.headerText = headerText
        self.buttonTitle = buttonTitle
        self.data = data
        self.errormsg = errormsg
        self.key1 = key1
        self.signInType = signInType
        self.itemType = itemType
        self.isSecure = isSecure
        self.isSelected = isSelected
        //        self.source = source
        self.needsBorder = needsBorder
        self.needDoneButton = needDoneButton
        self.canGotoNextPage = canGotoNextPage
        self.image = image
        self.height = height
        self.imageSize = imageSize
        self.tempInfo = tempInfo
        self.isOptional = isOptional
        self.percentValue = percentValue
        self.moreData = moreData
        self.noInput = noInput
        self.tempText = tempText
        self.characterLimit = characterLimit
        self.hasHyperLink = hasHyperLink
        self.disabled = disabled
        self.disableLeftPortion = disableLeftPortion
        
        self.isEditable = isEditable
        self.lineSpace = lineSpace
        self.fontSize = fontSize
        self.borderSeq = borderSeq
        self.keyboardDistance = keyboardDistance
        self.isError = isError
        self.separatorColor = separatorColor
        self.titleColor = titleColor
        self.titleFont = titleFont
        
        self.questionType = questionType
        self.TotalQuestions = TotalQuestions
        self.questionNumber = questionNumber
        self.questionHeading = questionHeading
        self.questionDescription = questionDescription
        self.characterLimit2 = characterLimit2
        self.cellType = cellType //keep celltype at the last
        self.cellbordercolor = cellbordercolor
        self.userCatdetails = userCatdetails
        self.questionBase = questionBase
        self.shareImg = shareImg
        self.shareLink = shareLink
        
        self.data1 = data1
        self.data2 = data2
        
        
        
    }
    
}
