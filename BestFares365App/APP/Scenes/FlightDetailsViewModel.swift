//
//  FlightDetailsViewModel.swift
//  BestFares365App
//
//  Created by FCI on 04/11/22.
//

import Foundation
import Alamofire


protocol FlightDetailsViewModelDelegate : BaseViewModelProtocol {
    func getFlightDetails(response : FlightDetailsModel)
}

class FlightDetailsViewModel {
    
    var view: FlightDetailsViewModelDelegate!
    init(_ view: FlightDetailsViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_FLIGHTDETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "general/\(ApiEndpoints.getflightDetails)" , parameters: parms, resultType: FlightDetailsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.getFlightDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
