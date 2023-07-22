//
//  AboutUsViewModel.swift
//  BestFares365App
//
//  Created by FCI on 10/03/23.
//

import Foundation




protocol AboutUsViewModelDelegate : BaseViewModelProtocol {
    func aboutusDetails(response : AboutUsModel)
    
}

class AboutUsViewModel {
    
    var view: AboutUsViewModelDelegate!
    init(_ view: AboutUsViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_ABOUT_US_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: url, parameters: parms, resultType: AboutUsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.aboutusDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
}
