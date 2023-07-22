//
//  SearchHotelViewModel.swift
//  BestFares365App
//
//  Created by FCI on 14/03/23.
//

import Foundation



protocol SearchHotelViewModelDelegate : BaseViewModelProtocol {
    func hotelSearchdetails(response : HotelSearchModel)
}

class SearchHotelViewModel {
    
    var view: SearchHotelViewModelDelegate!
    init(_ view: SearchHotelViewModelDelegate) {
        self.view = view
    }
    
    
    
    
    func CALL_HOTEL_SEARCH_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "general/\(ApiEndpoints.mobileprehotelsearch)",urlParams: (parms as! Dictionary<String, String>) , parameters: parms, resultType: HotelSearchModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.hotelSearchdetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
   
    
}
