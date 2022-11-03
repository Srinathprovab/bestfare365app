//
//  Constants.swift
//  DoorcastRebase
//
//  Created by U Dinesh Kumar Reddy on 04/05/22.
//

import Foundation
import UIKit
import CoreData


/*SETTING USER DEFAULTS*/
let defaults = UserDefaults.standard

let loginResponseDefaultKey = "LoginResponse"
let KPlatform = "Platform"
let KPlatformValue = "iOS"
let KContentType = "Content-Type"
let KContentTypeValue = "application/x-www-form-urlencoded"
let KAccept = "Accept"
let KAcceptValue = "application/json"
let KAuthorization = "Authorization"
//let KDEVICE_ID = "DEVICE_ID"
let KAccesstoken = "Accesstoken"
let KAccesstokenValue = ""
var key = ""
//let screenHeight = UIScreen.main.bounds.size.height
let selectedJourneyType1 = defaults.string(forKey: UserDefaultsKeys.journeyType)
let delaySeconds = 30.0
let somethingwentwrong = "Something Went Wrong"

//MARK:- SCREEN WIDTH
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}

//MARK:- SCREEN HEIGHT
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}


//MARK:- COREDATE SAVE PASSENGER DETAILS
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext

//FILTERS
var cityCodesArray = [String]()
var operatorNameArray = [String]()
var durationArray = [String]()
var dipAirportNameArray = [String]()
var layoverAirportNameArray = [String]()
var destinationAirportNameArray = [String]()
var totalPriceArray = [String]()

//ONEWAY
var oneWayFlights = [[Flights]]()
var airlinesArray = [String]()
var priceArray = [String]()
var flightcellIndex = Int()

//ROUND TRIP
var roundTripFlights = [[Flights]]()

//Multicity
var fromCityNameArray = ["City","City"]
var fromCityShortNameArray = ["Select","Select"]
var toCityNameArray = ["City","City"]
var toCityShortNameArray = ["Select","Select"]
var calDate = ["Select Date","Select Date"]
var calDateYearArray = ["Date","Date"]

var depatureDatesArray = ["",""]
var fromlocidArray = ["",""]
var tolocidArray = ["",""]
var fromCityArray = ["",""]
var toCityArray = ["",""]


var BASE_URL = "https://bestfares365.com/mobile_webservices/mobile/index.php/general/"
/* URL endpoints */
struct ApiEndpoints {
    
    static let mobilepreflightsearch = "mobile_pre_flight_search"
    static let getairportcodelist = "get_airport_code_list"
    static let getairlinelist = "get_airline_list"
    static let getCountrCode = "getCountrCode"
    
}

/*App messages*/
struct Message {
    static let internetConnectionError = "Please check your connection and try reconnecting to internet"
    static let sessionExpired = "Your session has been expired, please login again"
}


/*USER ENTERED DETAILS DEFAULTS*/

struct UserDefaultsKeys {
    
    static var tabselect = "tabselect"
    static var userLoggedIn = "userLoggedIn"
    static var userid = "userid"
    static var journeyType = "Journey_Type"
    static var flightCount = "flightCount"
    static var moduleTabSelectedIndex = "moduleTabSelectedIndex"
    static var paymentOption = "PaymentOption"
    static var totalTravellerCount = "totalTravellerCount"
    
    //filters
    static var noofStops = "NoofStops"
    static var refundableFares = "RefundableFares"
    static var airportsFilter = "AirportsFilter"
    static var airlinesFilter = "AirlinesFilter"
    static var selectedAirport = "SelectedAirport"
    static var sortByFilter = "SortByFilter"
    static var filterIndex = "FilterIndex"
    
    
    //ONE WAY
    static var fromCity = "fromCity"
    static var toCity = "toCity"
    static var calDepDate = "calDepDate"
    static var calRetDate = "calRetDate"
    static var adultCount = "Adult_Count"
    static var childCount = "Child_Count"
    static var hadultCount = "HAdult_Count"
    static var hchildCount = "HChild_Count"
    static var seatinfants  = "seatinfants"
    static var lapinfants  = "lapinfants"
    static var selectClass = "select_class"
    static var rselectClass = "rselect_class"
    static var fromlocid = "from_loc_id"
    static var tolocid = "to_loc_id"
    static var oselectAirline = "oselectAirline"
    static var cselectAirline = "ocselectAirline"
    static var acount = "acount"
    static var ccount = "ccount"
    static var icount = "icount"
    static var fromairportCode = "fromairportCode"
    static var toairportCode = "toairportCode"
    
    
    //ROUND TRIP
    static var rlocationcity = "rlocation_city"
    static var rfromCity = "rfromCity"
    static var rtoCity = "rtoCity"
    static var rcalDepDate = "rcalDepDate"
    static var rcalRetDate = "rcalRetDate"
    static var radultCount = "rAdult_Count"
    static var rchildCount = "rChild_Count"
    static var rhadultCount = "rHAdult_Count"
    static var rhchildCount = "rHChild_Count"
    static var rseatinfants  = "rseatinfants"
    static var rlapinfants  = "rlapinfants"
    static var rDepclass = "RDepclass"
    static var rRetclass = "rRetclass"
    static var rfromlocid = "rfrom_loc_id"
    static var rtolocid = "rto_loc_id"
    static var rselectAirline = "rselectAirline"
    static var rcselectAirline = "rcselectAirline"
    static var rfromairportCode = "rfromairportCode"
    static var rtoairportCode = "rtoairportCode"
    
    
    //MULTICITY TRIP
    static var mlocationcity = "mlocation_city"
    static var mfromCity = "mfromCity"
    static var mtoCity = "mtoCity"
    static var mcalDepDate = "mcalDepDate"
    static var mcalRetDate = "mcalRetDate"
    static var madultCount = "mAdult_Count"
    static var mchildCount = "mChild_Count"
    static var mhadultCount = "mHAdult_Count"
    static var mhchildCount = "mHChild_Count"
    static var mseatinfants  = "mseatinfants"
    static var mlapinfants  = "mlapinfants"
    static var mselectClass = "mselect_class"
    static var mfromlocid = "mfrom_loc_id"
    static var mtolocid = "mto_loc_id"
    static var mselectAirline = "mselectAirline"
    static var mcselectAirline = "mcselectAirline"
    static var travellerDetails = "traveller_Details"
    static var rtravellerDetails = "rtraveller_Details"
    static var mtravellerDetails = "mtraveller_Details"
    static var mfromairportCode = "mfromairportCode"
    static var mfromCityValue = "mfromCityValue"
    static var mtoCityValue = "mtoCityValue"
    
    static var mtoairportCode = "mtoairportCode"
    static var mcalDate = "mcalDate"
    static var mcalyear = "mcalyear"
    static var cellTag = "cellTag"
    
    //Hotel
    static var htotaltravellercount = "htotaltravellercount"
    static var htravellerDetails = "htraveller_Details"
    static var roomType = "Room_Type"
    static var select = "select"
    static var checkin = "check_in"
    static var checkout = "check _out"
    static var addTarvellerDetails = "addTarvellerDetails"
    static var hpassengertype = "hpassenger_type"
    static var hchildage1 = "hchildage1"
    static var hchildage2 = "hchildage2"
    
    //Fare details
    static var totalPrice = "totalPrice"
    static var basePrice = "basePrice"
    static var taxes = "taxes"
    static var APICurrencyType = "APICurrencyType"
    
    //Hotel Module
    static var countryOfResidence = "CountryofResidence"
    static var landmarkOrCity = "LandmarkOrCity"
    static var checkInDate = "checkInDate"
    
    
}


struct sessionMgrDefaults {
    
    //   static var userLoggedIn = "username"
    static var globalAT = "mobile_no"
    static var Base_url = "accesstoken"
    static var loggedInStatus = "loggedInStatus"
    static var userid = "userid"
    static var email = "email"
    static var mobile = "mobile"
    static var username = "username"
    static var userimg = "userimg"
    static var fname = "fname"
    static var lname = "lname"
    static var dob = "dob"
    
}



/*LOCAL JSON FILES*/
struct LocalJsonFiles {
    
}
