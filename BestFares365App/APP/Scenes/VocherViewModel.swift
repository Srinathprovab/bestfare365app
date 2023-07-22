//
//  VocherViewModel.swift
//  BestFares365App
//
//  Created by FCI on 18/05/23.
//

import Foundation


protocol VocherViewModelDelegate : BaseViewModelProtocol {
    func vocherDetails(response : VocherModel)
}

class VocherViewModel {
    
    var view: VocherViewModelDelegate!
    init(_ view: VocherViewModelDelegate) {
        self.view = view
    }
    
    
    
    
    func CALL_GET_VOCHER_DETAILS_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        BASE_URL = ""
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: url, parameters: parms, resultType: VocherModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.vocherDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
}
