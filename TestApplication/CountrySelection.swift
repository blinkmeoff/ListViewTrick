//
//  CountrySelection.swift
//  TestApplication
//
//  Created by Игорь М. on 06.07.17.
//  Copyright © 2017 com.igormagurean. All rights reserved.
//

import Foundation
import CoreData


class CountrySelection: NSManagedObject {
  
  @NSManaged var id: String?
  @NSManaged var isSelected: String?
  
}
