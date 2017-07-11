//
//  ApiService.swift
//  TestApplication
//
//  Created by Игорь М. on 06.07.17.
//  Copyright © 2017 com.igormagurean. All rights reserved.
//

import Foundation
import TRON


class ApiService: NSObject {
  
  
  static let sharedInstance = ApiService()
  
  let tron = TRON(baseURL: "http://trade.spotoption.com")
  
  func fetchCountries(completion: @escaping (CountriesDatasource) -> ()) {

    let request: APIRequest<CountriesDatasource, JSONError> = tron.request("/platformAjax/getJsonFile/CountryData/en/CountryData.json")
    
    request.method = .get
    request.headerBuilder = HeaderBuilder(defaultHeaders: ["Content-Type": "application/json"])
    
    request.perform(withSuccess: { (result) in
      completion(result)
    }) { (error) in
      print(error)
    }
  }
  
}
