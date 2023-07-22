//
//  ChangePasswordViewModel.swift
//  BestFares365App
//
//  Created by FCI on 31/01/23.
//

import Foundation

protocol ChangePasswordViewModelDelegate : BaseViewModelProtocol {
    func changePasswordsucess(response : RegisterModel)
    
}

class ChangePasswordViewModel {
    
    var view: ChangePasswordViewModelDelegate!
    init(_ view: ChangePasswordViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_FORGET_PASSWORD_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "auth/\(ApiEndpoints.mobileforgotpassword)",urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: RegisterModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.changePasswordsucess(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
}
