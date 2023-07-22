//
//  HotelDetailsViewModel.swift
//  BestFares365App
//
//  Created by FCI on 16/03/23.
//

import Foundation


protocol HotelDetailDelegate : BaseViewModelProtocol {
    func hotelDetails(response : HotelDetailsModel)
}

class HotelDetailsViewModel {
    
    var view: HotelDetailDelegate!
    init(_ view: HotelDetailDelegate) {
        self.view = view
    }
    
    
    
    
    func CALL_GET_HOTEL_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "hotel/\(ApiEndpoints.mobilehoteldetails)",urlParams: (parms as! Dictionary<String, String>) , parameters: parms, resultType: HotelDetailsModel.self, p:dictParam) { sucess, result, errorMessage in
            
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
    
    
    
    
}
