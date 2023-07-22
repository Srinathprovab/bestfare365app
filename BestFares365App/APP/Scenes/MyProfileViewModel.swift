//
//  MyProfileViewModel.swift
//  BestFares365App
//
//  Created by FCI on 31/01/23.
//

import Foundation



protocol MyProfileViewModelDelegate : BaseViewModelProtocol {
    func profileDetails(response : MyProfileModel)
    
}

class MyProfileViewModel {
    
    var view: MyProfileViewModelDelegate!
    init(_ view: MyProfileViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_GET_PROFILE_DETAILS_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "user/\(ApiEndpoints.mobileprofile)" , parameters: parms, resultType: MyProfileModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.profileDetails(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
}
