//
//  LoginViewModel.swift
//  BestFares365App
//
//  Created by FCI on 07/11/22.  ResetPasswordViewModel
//

import Foundation

protocol LoginViewModelDelegate : BaseViewModelProtocol {
    func registerDetails(response : RegisterModel)
    func loginDetails(response : LoginModel)
}

class LoginViewModel {
    
    var view: LoginViewModelDelegate!
    init(_ view: LoginViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_USER_LOGIN_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "auth/\(ApiEndpoints.mobilelogin)" , parameters: parms, resultType: LoginModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.loginDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CALL_REGISTER_USER_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "auth/\(ApiEndpoints.mobileregisteronlightbox)" , parameters: parms, resultType: RegisterModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.registerDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
