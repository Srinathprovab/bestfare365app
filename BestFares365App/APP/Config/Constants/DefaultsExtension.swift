//
//  DefaultsExtension.swift
//  AlghanimTravelApp
//
//  Created by MA673 on 16/09/22.
//

import Foundation



class Load {
    class func dictionary(key:String) -> NSDictionary! {
        return UserDefaults.standard.object(forKey: key) as? NSDictionary
    }
}

class Save {
    class func dictionary(key:String, _ value:NSDictionary) {
        UserDefaults.standard.set(value, forKey: key)
    }
}

class Remove {
    class func object(key:String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
