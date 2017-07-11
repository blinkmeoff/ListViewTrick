//
//  Section.swift
//  TestApplication
//
//  Created by Игорь М. on 06.07.17.
//  Copyright © 2017 com.igormagurean. All rights reserved.
//

import Foundation


class Section {
  
  var sectionName: String?
  var countries: [Country]?
  
  init(sectionName: String, countries: [Country]) {
    self.sectionName = sectionName
    self.countries = countries
  }
  
  
  init() {
    
  }
}
