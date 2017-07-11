//
//  CountryCell.swift
//  TestApplication
//
//  Created by Игорь М. on 06.07.17.
//  Copyright © 2017 com.igormagurean. All rights reserved.
//

import UIKit


class CountryCell: UITableViewCell {
  
  
  var country: Country? {
    didSet{
      if let countryName = country?.name {
       countryNameLabel.text = countryName
        if let selected = country?.isSelected {
          if selected == "1" {
            isSelected = true
            checkMarkImageView.image = #imageLiteral(resourceName: "checkmark").withRenderingMode(.alwaysTemplate)
            checkMarkImageView.tintColor = UIColor(r: 161, g: 161, b: 161)
          } else {
            isSelected = false
            checkMarkImageView.image = #imageLiteral(resourceName: "checkmarkEmpty").withRenderingMode(.alwaysTemplate)
            checkMarkImageView.tintColor = UIColor(r: 161, g: 161, b: 161)
          }
        }
      }
    }
  }
  
  override func prepareForReuse() {
    checkMarkImageView.image = nil
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupViews()
  }
  
  override var isSelected: Bool {
    didSet {
      checkMarkImageView.image = isSelected ? #imageLiteral(resourceName: "checkmark").withRenderingMode(.alwaysOriginal) : #imageLiteral(resourceName: "checkmarkEmpty").withRenderingMode(.alwaysTemplate)
      checkMarkImageView.tintColor = UIColor(r: 161, g: 161, b: 161)
      contentView.backgroundColor = .white
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let checkMarkImageView: UIImageView = {
    let iv = UIImageView()
    
    iv.translatesAutoresizingMaskIntoConstraints = false
    iv.contentMode = .scaleAspectFit
    return iv
  }()
  
  let countryNameLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 16)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  func setupViews() {
    addSubview(countryNameLabel)
    addSubview(checkMarkImageView)
    
    countryNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    countryNameLabel.anchor(nil, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 22, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    
    checkMarkImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    checkMarkImageView.anchor(nil, left: nil, bottom: nil, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 20, widthConstant: 20, heightConstant: 20)
  }
  
}
