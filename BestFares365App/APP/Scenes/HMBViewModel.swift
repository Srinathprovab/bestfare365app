//
//  HMBViewModel.swift
//  BestFares365App
//
//  Created by FCI on 27/03/23.
//

import Foundation



protocol HMBViewModelDelegate : BaseViewModelProtocol {
    func hotelDetails(response : HMBModel)
    func hotelmobileprebookingDetails(response : HotelMobilePreBookingModel)
    func hotelmobileprocessbookingDetails(response : HotelMobilePreBookingModel)
}

class HMBViewModel {
    
    var view: HMBViewModelDelegate!
    init(_ view: HMBViewModelDelegate) {
        self.view = view
    }
    
    
    
    //MARK: - CALL_HOTEL_MOBILE_BOOKING_API
    func CALL_HOTEL_MOBILE_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "hotel/\(ApiEndpoints.hmobile_booking)", parameters: parms, resultType: HMBModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    //MARK: - CALL_HOTEL_MOBILE_PRE_BOOKING_API
    func CALL_HOTEL_MOBILE_PRE_BOOKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "hotel/\(ApiEndpoints.hmobileprebooking)", parameters: parms, resultType: HotelMobilePreBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelmobileprebookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    //MARK: - CALL_HOTEL_MOBILE_PROCESS_BOOKING_API
    func CALL_HOTEL_MOBILE_PROCESS_BOOKING_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: url, parameters: parms, resultType: HotelMobilePreBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelmobileprocessbookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
