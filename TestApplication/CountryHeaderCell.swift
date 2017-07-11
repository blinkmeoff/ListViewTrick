//
//  CountryHeaderCell.swift
//  TestApplication
//
//  Created by Игорь М. on 06.07.17.
//  Copyright © 2017 com.igormagurean. All rights reserved.
//

import UIKit


class CountryHeaderCell: UITableViewCell {
  
  var section: Section? {
    didSet {
      countrySectionLabel.text = section?.sectionName
    }
  }
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    setupViews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  let countrySectionLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.boldSystemFont(ofSize: 17)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  func setupViews() {
    backgroundColor = UIColor(r: 161, g: 161, b: 161)
    addSubview(countrySectionLabel)
    
    countrySectionLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    countrySectionLabel.anchor(nil, left: leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 12, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
  }
  
}
