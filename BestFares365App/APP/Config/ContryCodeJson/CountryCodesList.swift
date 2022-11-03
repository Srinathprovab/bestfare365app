//
//  CountryCodesList.swift
//  AlghanimTravelApp
//
//  Created by FCI on 21/09/22.
//

import Foundation



struct Country {
  let name: String
  let code: String
}

final class CountryHelper {
  class func allCountries() -> [Country] {
    var countries = [Country]()

    for code in Locale.isoRegionCodes as [String] {
      if let name = Locale.autoupdatingCurrent.localizedString(forRegionCode: code) {
        countries.append(Country(name: name, code: code))
      }
    }

    return countries
  }
}
