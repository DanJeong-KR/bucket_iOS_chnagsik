//
//  SortingView.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 16/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class SortingView: UIView {
  
  internal lazy var orderButton: UIButton = {
    let bt = UIButton(type: .custom)
    bt.setTitle("  정렬 ▾  ", for: .normal)
    bt.setTitleColor(.darkGray, for: .normal)
    bt.titleLabel?.font = Global.bold
    bt.backgroundColor = #colorLiteral(red: 0.9607107043, green: 0.9608257413, blue: 0.9606716037, alpha: 1)
    bt.layer.cornerRadius = 5
    bt.id = ButtonID.sortingButton.id
    self.addSubview(bt)
    return bt
  }()
  
  internal lazy var spaceButton: UIButton = {
    let bt = UIButton(type: .custom)
    bt.setTitle("  공간 ▾  ", for: .normal)
    bt.setTitleColor(.darkGray, for: .normal)
    bt.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    bt.backgroundColor = #colorLiteral(red: 0.9607107043, green: 0.9608257413, blue: 0.9606716037, alpha: 1)
    bt.layer.cornerRadius = 5
    bt.id = ButtonID.spaceButton.id
    self.addSubview(bt)
    return bt
  }()
  
  internal lazy var residenceButton: UIButton = {
    let bt = UIButton(type: .custom)
    bt.setTitle("  주거형태 ▾  ", for: .normal)
    bt.setTitleColor(.darkGray, for: .normal)
    bt.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
    bt.backgroundColor = #colorLiteral(red: 0.9607107043, green: 0.9608257413, blue: 0.9606716037, alpha: 1)
    bt.layer.cornerRadius = 5
    bt.id = ButtonID.residenceButton.id
    self.addSubview(bt)
    return bt
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    makeConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError(ErrorLog.coderInit)
  }
  
  private func makeConstraints() {
    orderButton.layout.top(constant: 5).leading(constant: 10).bottom(constant: -5)
    spaceButton.layout.top(constant: 5).leading(equalTo: orderButton.trailingAnchor ,constant: 5).bottom(constant: -5)
    residenceButton.layout.top(constant: 5).leading(equalTo: spaceButton.trailingAnchor, constant: 5).bottom(constant: -5)
  }

}
