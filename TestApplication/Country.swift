//
//  Country.swift
//  TestApplication
//
//  Created by Игорь М. on 06.07.17.
//  Copyright © 2017 com.igormagurean. All rights reserved.
//

import Foundation
import SwiftyJSON
import TRON

class Country: JSONDecodable {
  
  var id: String?
  var name: String?
  var isSelected: String?
  
  required init(json: JSON) throws {
    self.id = json["id"].stringValue
    self.name = json["name"].stringValue
    self.isSelected = "0"
  }
  
  init(id: String, name: String, isSelected: String){
    self.id = id
    self.name = name
    self.isSelected = isSelected
  }
  
}
