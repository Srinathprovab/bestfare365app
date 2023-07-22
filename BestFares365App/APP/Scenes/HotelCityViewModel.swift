//
//  HotelCityViewModel.swift
//  BestFares365App
//
//  Created by FCI on 14/03/23.
//

import Foundation




protocol HotelCityViewModelDelegte : BaseViewModelProtocol {
    func hotelCityList(response : [HotelCityModel])
}

class HotelCityViewModel {
    
    var view: HotelCityViewModelDelegte!
    init(_ view: HotelCityViewModelDelegte) {
        self.view = view
    }
    
    
    
    
    func CALL_HOTEL_CITY_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
     //   self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "hotel/\(ApiEndpoints.gethotelcitylist)",urlParams: (parms as! Dictionary<String, String>) , parameters: parms, resultType: [HotelCityModel].self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
             //   self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelCityList(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
   
    
}
