//
//  CountriesDatasource.swift
//  TestApplication
//
//  Created by Игорь М. on 06.07.17.
//  Copyright © 2017 com.igormagurean. All rights reserved.
//

import Foundation
import TRON
import SwiftyJSON


class CountriesDatasource: JSONDecodable {
  
  var countries: [Country]?
  
  required init(json: JSON) throws {
    
    var countriesArr = [Country]()
    
    let data = json["data"]
    let countriesJSON = data["countries"].array
    
    if let coutriesArray = countriesJSON {
      for country in coutriesArray {
        countriesArr.append(try Country(json: country))
      }
    }
    
    self.countries = countriesArr
    
  }
  
}


class JSONError: JSONDecodable {
  
  required init(json: JSON) throws {
    print(json)
  }
  
}
