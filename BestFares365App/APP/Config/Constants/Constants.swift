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
var deviceId = String()
var callapibool = Bool()
var showflightDetailskey = Bool()

//MARK:- SCREEN WIDTH
public var screenWidth: CGFloat {
    return UIScreen.main.bounds.size.width
}

//MARK:- SCREEN HEIGHT
public var screenHeight: CGFloat {
    return UIScreen.main.bounds.size.height
}

//MARK: - COREDATE SAVE PASSENGER DETAILS
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext
var details  = [NSFetchRequestResult]()


//Booking Details
var checkOptionCountArray = [String]()
var phoneCodeArray = [Phone_code]()
var passenger_dobArray = [String]()
var passenger_typeArray = [String]()
var lead_passengerArray = [String]()
var genderArray = [String]()
var passenger_nationalityArray = [String]()
var name_titleArray = [String]()
var first_nameArray = [String]()
var last_nameArray = [String]()
var passenger_passport_numberArray = [String]()
var passenger_passport_issuing_countryArray = [String]()
var passenger_passport_expiry_dayArray = [String]()
var passenger_passport_expiry_monthAraay = [String]()
var passenger_passport_expiry_yearArray = [String]()
 
var arrayOf_SelectedCellsInfanta = [IndexPath]()
var arrayOf_SelectedCellsAdult = [IndexPath]()
var arrayOf_SelectedCellsChild = [IndexPath]()
var totalNoOfTravellers = String()

//MARK: - PROFILE DETAILS ARRAY
var profileDetailsArray: MyProfileModel?
var passengerA = [Passenger]()


//MARK: - Flight Details screen
var flight_details1: [[FDFlight_details]]?


var edit_title2 = String()
var edit_title1 = String()
var edit_passenger_type = String()
var edit_lead_passenger = String()
var edit_fname = String()
var edit_lname = String()
var edit_gender = String()
var edit_dob = String()
var edit_nationalitycode = String()
var edit_passportno = String()
var edit_passenger_passport_expiry_date = String()
var edit_passenger_passport_expiry_day = String()
var edit_passenger_passport_expiry_month = String()
var edit_passenger_passport_expiry_year = String()
var edit_issuingCountrycode = String()
var edit_issuingCountryname = String()
var edit_nationalityname = String()




//FILTERS
var cityCodesArray = [String]()
var operatorNameArray = [String]()
var durationArray = [String]()
var dipAirportNameArray = [String]()
var layoverAirportNameArray = [String]()
var destinationAirportNameArray = [String]()
var totalPriceArray = [String]()
var noofStopsFilterIndex = 10

//ONEWAY
var oneWayFlights = [[Flights]]()
var airlinesArray = [String]()
var airlinesImgArray = [String]()
var priceArray = [String]()
var flightcellIndex = Int()
var searchid = String()
var sessionid = String()
var selectedResult = String()
var bookingsource = String()
var flight_details: [[FDFlight_details]]?

//ONEWAY FILTER
var airlinesNAMEArray = [String]()
var connectingFlifhtsArray = [String]()
var arrivingFlightsArray = [String]()
var airlinesLogoArray = [String]()
var departureFromArray = [String]()



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

var mfromCityNameArray = ["City","City"]
var mfromCityShortNameArray = ["Select","Select"]
var mtoCityNameArray = ["City","City"]
var mtoCityShortNameArray = ["Select","Select"]

var BaseFare = String()
var TotalTax = String()
var TotalFare = String()
var currency = String()
var fcurrency = String()
var fcurrencySymbol = String()

var adt = String()
var child = String()
var infnta = String()
var adtTax = String()
var childTax = String()
var infntaTax = String()
var adtPassCount = Int()
var cHPassCount = Int()
var iNFPassCount = Int()


//Filters
var prices = [String]()
var airlineNamesArray = [String]()
var arrivingAtArray = [String]()
var connectingInArray = [String]()
var uniquePrices: [String] = []
var uniqueAirlines: [String] = []
var uniqueAirlineImages: [String] = []
var airlinesNames: [String] = []
var airlinesImages: [String] = []
var airlinesCodes: [String] = []
var connectingFlights: [String] = []


//Hotel
var hotelList = [Raw_hotel_list]()
var hbooking_source = String()
var hotel_id = String()
var hsearch_id = String()
var imageArr = [Image_arr]()
var formatAmeArray = [Hotel_static_facilities_arr]()
var medium_image_baseUrl = String()
var small_image_baseUrl = String()
var hotelImgSelected = String()
var roomCountArray = [Int]()
var adultsCountArray = [Int]()
var childCountArray = [Int]()
var rateKeyArray = [String]()

var hotel_details : Hotel_details?
var htoken = String()
var hsearchid = String()
var hbookingsource = String()
var haddress = String()
var hprice = String()
var hcurrency = String()

var adtArray = [String]()
var chArray = [String]()
var vocherdata : VocherData?
var hoteldetails:HMBTokenData?


var BASE_URL = "https://bestfares365.com/mobile_webservices1/mobile/index.php/"
var BASE_URL1 = "https://bestfares365.com/mobile_webservices1/mobile/index.php/"
/* URL endpoints */
struct ApiEndpoints {
    
    static let mobilepreflightsearch = "mobile_pre_flight_search"
    static let getairportcodelist = "get_airport_code_list"
    static let getairlinelist = "get_airline_list"
    static let getCountrCode = "getCountrCode"
    static let getflightDetails = "getflightDetails"
    static let mobileregisteronlightbox = "mobile_register_on_light_box"
    static let mobilelogin = "mobile_login"
    static let mobilechangepassword = "mobile_change_password"
    static let mobileforgotpassword = "mobile_forgot_password"
    static let mobileprofile = "mobile_profile"
    static let mobileeditprofile = "mobile_edit_profile"
    static let mobilebooking = "mobile_booking"
    static let mobileprebooking = "mobile_pre_booking"
    static let getCurrencyList = "getCurrencyList"
    static let gethotelcitylist = "get_hotel_city_list"
    static let mobileprehotelsearch = "mobile_pre_hotel_search"
    static let mobilehoteldetails = "mobile_hotel_details"
    static let hmobile_booking = "mobile_booking"
    static let hmobileprebooking = "mobile_pre_booking"
    static let hmobileprocessbooking = "mobile_process_booking"

    
    
}

/*App messages*/
struct Message {
    static let internetConnectionError = "Please check your connection and try reconnecting to internet"
    static let sessionExpired = "Your session has been expired, please login again"
}


/*USER ENTERED DETAILS DEFAULTS*/

struct UserDefaultsKeys {
    
    static var tabselect = "tabselect"
    static var loggedInStatus = "loggedInStatus"
    static var userid = "userid"
    static var journeyType = "Journey_Type"
    static var flightCount = "flightCount"
    static var moduleTabSelectedIndex = "moduleTabSelectedIndex"
    static var paymentOption = "PaymentOption"
    static var totalTravellerCount = "totalTravellerCount"
    static var selectedCurrency = "selected_currency"
    static var currencysymbol = "currency_symbol"
    
    static var searchid = "search_id"
    static var token = "token"
    static var tokenkey = "token_key"
    static var bookingsource = "booking_source"
    static var sessionid = "session_id"
    static var selectedResult = "selectedResult"
    
    
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
    static var selectClassIndex = "selectClassIndex"
    
    static var rselectClass = "rselect_class"
    static var rselectClassIndex = "rselectClassIndex"
    
    static var fromlocid = "from_loc_id"
    static var tolocid = "to_loc_id"
    static var oselectAirline = "oselectAirline"
    static var cselectAirline = "ocselectAirline"
    static var acount = "acount"
    static var ccount = "ccount"
    static var icount = "icount"
    static var fromairportCode = "fromairportCode"
    static var toairportCode = "toairportCode"
    static var fromairport_city = "Fromairport_city"
    static var toairport_city = "Toairport_city"
    
    
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
    static var rfromairport_city = "rFromairport_city"
    static var rtoairport_city = "rToairport_city"
    
    
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
    static var mselectClassIndex = "mselectClassIndex"
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
    static var mfromairport_city = "mFromairport_city"
    static var mtoairport_city = "mToairport_city"
    
    //Hotel
    
    static var hotelCity = "hotelCity"
    static var hoteldestinationCode = "hotel_destination_code"
    
    static var hotelSelect = "hotelSelect"
    static var checkin = "check_in"
    static var checkout = "check _out"
    static var nights = "Nights"
    static var persons = "Persons"
    static var roomcount = "room_count"
    static var hoteladultscount = "hotel_adults_count"
    static var hotelchildcount = "hotel_child_count"
    static var itinerarySelectedIndex = "ItinerarySelectedIndex"
    static var selectPersons = "selectPersons"
    
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
