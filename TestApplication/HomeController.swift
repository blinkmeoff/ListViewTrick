//
//  ViewController.swift
//  TestApplication
//
//  Created by Игорь М. on 06.07.17.
//  Copyright © 2017 com.igormagurean. All rights reserved.
//

import UIKit
import CoreData

class HomeController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  var countries: [Country]?
  let cellId = "cellId"
  let headerId = "headerId"
  var sectionsArray: [Section]?
  var selectedCountriesData: [CountrySelection]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    loadSelectedCountries()
    setupNavigationBar()
    showLoadingIndicator()
    fetchCountries()
  }
  
  func loadSelectedCountries() {
    guard let appDelegate =
      UIApplication.shared.delegate as? AppDelegate else {
        return
    }
    
    let managedContext = appDelegate.persistentContainer.viewContext
    
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CountrySelection")
    
    do {
      let selectedCountries = try managedContext.fetch(fetchRequest) as? [CountrySelection]
      
      if let arr = selectedCountries {
        selectedCountriesData = arr
      }
      
    } catch let error as NSError {
      print("Could not fetch. \(error), \(error.userInfo)")
    }
    
  }
  
  func setupNavigationBar() {
    title = "ListViewTrick"
    navigationController?.navigationBar.tintColor = .white
  }
  
  let activityIndicatorView: UIActivityIndicatorView = {
    let aiv = UIActivityIndicatorView()
    aiv.activityIndicatorViewStyle = .whiteLarge
    aiv.color = .gray
    aiv.translatesAutoresizingMaskIntoConstraints = false
    aiv.hidesWhenStopped = true
    return aiv
  }()
  
  lazy var tableView: UITableView = {
    let tb = UITableView(frame: .zero, style: .plain)
    tb.delegate = self
    tb.dataSource = self
    tb.allowsMultipleSelection = true
    return tb
  }()
  
  func showLoadingIndicator() {
    activityIndicatorView.startAnimating()
    view.addSubview(activityIndicatorView)
    
    activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    activityIndicatorView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    activityIndicatorView.heightAnchor.constraint(equalToConstant: 50).isActive = true
  }
  
  func fetchCountries() {
    ApiService.sharedInstance.fetchCountries { (result) in
      self.countries = result.countries
      self.setupSectionsArray()
      self.selectCells()
      self.setupTableView()
    }
  }
  
  func selectCells() {
    if let sectionArr = sectionsArray {
      
      for value in sectionArr {
        
        if let countriesArr = value.countries {
          
          for country in countriesArr {
            
            if let selectedCountriesArr = selectedCountriesData {
              for selectedCountry in selectedCountriesArr {
                if country.id == selectedCountry.id {
                  country.isSelected = "1"
                }
              }
            }
          }
        }
      }      
    }
  }
  
  func setupSectionsArray() {
    var currentLater = ""
    var sectionsArr = [Section]()
    
    if let countiesArr = self.countries {
      for value in countiesArr {
        
        var section = Section()
        
        if let name = value.name {
          let index = name.index(name.startIndex, offsetBy: 1)
          let firstLetter = name.substring(to: index)
          
          if currentLater != firstLetter {
            section.sectionName = firstLetter
            section.countries = []
            currentLater = firstLetter
            sectionsArr.append(section)
          } else {
            section = sectionsArr.last!
            
        }
          section.countries?.append(value)
        }
      }
    }
    self.sectionsArray = sectionsArr
  }

  
  func setupTableView() {
    activityIndicatorView.stopAnimating()
    tableView.register(CountryCell.self, forCellReuseIdentifier: cellId)
    tableView.register(CountryHeaderCell.self, forCellReuseIdentifier: headerId)
    view.addSubview(tableView)
    
    tableView.anchor(view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, topConstant: 64, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    
  }

  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
  
  //MARK: TableView Delegate, Datasource
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionsArray?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return sectionsArray?[section].countries?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerCell = tableView.dequeueReusableCell(withIdentifier: headerId) as! CountryHeaderCell
    
    headerCell.section = sectionsArray?[section]
    
    return headerCell
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 30
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CountryCell
    
    cell.country = sectionsArray?[indexPath.section].countries?[indexPath.item]
    
    if cell.country?.isSelected == "1" {
      tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    } else {
      tableView.deselectRow(at: indexPath, animated: false)
      cell.isSelected = false
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 44
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! CountryCell
    cell.contentView.backgroundColor = .white
    cell.checkMarkImageView.image = #imageLiteral(resourceName: "checkmark")
    
    if let id = cell.country?.id {
      self.saveCheckedCountry(id: id)
    }
  }
  
  fileprivate func saveCheckedCountry(id: String) {
    let delegate = UIApplication.shared.delegate as? AppDelegate
    
    if let context = delegate?.persistentContainer.viewContext {
      let selectedCountry = NSEntityDescription.insertNewObject(forEntityName: "CountrySelection", into: context) as! CountrySelection

      selectedCountry.id = id
      selectedCountry.isSelected = "1"
      
      do {
        try context.save()
      } catch let err {
        print(err)
      }
      
    }
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath) as! CountryCell
    cell.contentView.backgroundColor = .white
    cell.checkMarkImageView.image = #imageLiteral(resourceName: "checkmarkEmpty").withRenderingMode(.alwaysTemplate)
    cell.checkMarkImageView.tintColor = UIColor(r: 161, g: 161, b: 161)
    if let id = cell.country?.id {
      self.deleteCheckedCountry(id: id)
    }
  }
  
  
  fileprivate func deleteCheckedCountry(id: String) {
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
          return
      }
      
      let managedContext = appDelegate.persistentContainer.viewContext
      
      let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "CountrySelection")
      
      do {
        let selectedCountriesArray = try managedContext.fetch(fetchRequest) as? [CountrySelection]
        
        if let array = selectedCountriesArray {
          for value in array {
            if value.id == id {
              managedContext.delete(value)
            }
          }
        }
        
      } catch let error as NSError {
        print("Could not fetch. \(error), \(error.userInfo)")
      }
      
  }
}

