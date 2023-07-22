//
//  ResetPasswordViewModel.swift
//  BestFares365App
//
//  Created by FCI on 31/01/23.
//


import Foundation

protocol ResetPasswordViewModelDelegate : BaseViewModelProtocol {
    func resetpasswordSucessdetails(response : ResetPasswordModel)
    
}

class ResetPasswordViewModel {
    
    var view: ResetPasswordViewModelDelegate!
    init(_ view: ResetPasswordViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_RESET_PASSWORD_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.mobilechangepassword , parameters: parms, resultType: ResetPasswordModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.resetpasswordSucessdetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
}
