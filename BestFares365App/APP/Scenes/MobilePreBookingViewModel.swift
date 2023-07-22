//
//  MobilePreBookingModel.swift
//  BestFares365App
//
//  Created by FCI on 15/02/23.
//

import Foundation




protocol MobilePreBookingViewModelDelegate : BaseViewModelProtocol {
    func getMobileBookingDetails(response : MobilePreBookingModel)
    func getMobilePreBookingDetails(response : SecureBookingModel)
    func secureBookingSucess(response : SecureBookingModel)
    
}

class MobilePreBookingViewModel {
    
    var view: MobilePreBookingViewModelDelegate!
    init(_ view: MobilePreBookingViewModelDelegate) {
        self.view = view
    }
    
    
    
    
    func CALL_MOBILE_BOKKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "flight/\(ApiEndpoints.mobilebooking)" , parameters: parms, resultType: MobilePreBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.getMobileBookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_MOBILE_PREBOKKING_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "flight/\(ApiEndpoints.mobileprebooking)" , parameters: parms, resultType: SecureBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
  //              self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.getMobilePreBookingDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    func CALL_SECURE_BOOKING_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: url, parameters: parms, resultType: SecureBookingModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
//                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.secureBookingSucess(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
}
