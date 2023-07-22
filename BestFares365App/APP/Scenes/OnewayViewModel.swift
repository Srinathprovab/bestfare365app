//
//  OnewayViewModel.swift
//  BestFares365App
//
//  Created by FCI on 03/11/22.
//

import Foundation
import Alamofire


protocol OnewayViewModelDelegate : BaseViewModelProtocol {
    func getOneWayFlightList(response : OneWayModel)
    func getRoundTripFlightList(response : OneWayModel)
    func getMulticityFlightList(response : OneWayModel)


}

class OnewayViewModel {
    
    var view: OnewayViewModelDelegate!
    init(_ view: OnewayViewModelDelegate) {
        self.view = view
    }
    
    
    func CallGetOneWayFlightListAPI(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "general/\(ApiEndpoints.mobilepreflightsearch)" , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: OneWayModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.getOneWayFlightList(response: response)
                } else {
                    
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    func CallRoundTripApi(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "general/\(ApiEndpoints.mobilepreflightsearch)" , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: OneWayModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.getRoundTripFlightList(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    func CallMultiCitySearchFlightList(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "general/\(ApiEndpoints.mobilepreflightsearch)" , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: OneWayModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.getMulticityFlightList(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
}
