//
//  CurrencyListViewModel.swift
//  BestFares365App
//
//  Created by FCI on 10/03/23.
//

import Foundation



protocol CurrencyListViewModelDelegate : BaseViewModelProtocol {
    func currencyList(response : [CurrencyListModel])
}

class CurrencyListViewModel {
    
    var view: CurrencyListViewModelDelegate!
    init(_ view: CurrencyListViewModelDelegate) {
        self.view = view
    }
    
    
    
    
    func CALL_GET_CURRENCY_LIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        ServiceManager.postOrPutApiCall(endPoint: "general/\(ApiEndpoints.getCurrencyList)" , parameters: parms, resultType: [CurrencyListModel].self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.currencyList(response: response)
                } else {
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
   
    
}
