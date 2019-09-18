//
//  FilterCollectionCell.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 17/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class FilterCollectionCell: UICollectionViewCell {
  
  lazy var label: UILabel = {
    let lb = UILabel(frame: .zero)
    lb.text = "...로딩중"
    lb.textColor = .white
    lb.font = Global.heavy
    lb.layer.cornerRadius = 15
    lb.clipsToBounds = true
    lb.backgroundColor = Global.mainColor
    lb.isUserInteractionEnabled = true
    addSubview(lb)
    return lb
  }()
  
  lazy var cancelButton: UIButton = {
    let bt = UIButton(type: .custom)
    bt.setTitle("✗", for: .normal)
    bt.backgroundColor = .white
    bt.layer.cornerRadius = 10
    bt.clipsToBounds = true
    bt.setTitleColor(Global.mainColor, for: .normal)
    bt.addTarget(self, action: #selector(cancelButtonDidTap(_:)), for: .touchUpInside)
    label.addSubview(bt)
    return bt
  }()
  
  // MARK: - Initializers
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError(ErrorLog.coderInit)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    makeConstraints()
  }
  
  // MARK: - Layout Methods
  private func makeConstraints() {
    label.layout.top(constant: 10).bottom(constant: -10).leading(constant: 5).trailing()
    cancelButton.layout.trailing(constant: -5).centerY().height(constant: 20).width(constant: 20)
  }
  
  @objc private func cancelButtonDidTap(_ sender: Any) {
    let sortingData = DataManager.shared.sortingData
    var text = self.label.text!
    (1...2).forEach { (_) in
      text.removeFirst()
    }
    
    if sortingData["정렬"]!.contains(text) {
      DataManager.shared.filterData["정렬"] = "0"
    }else if sortingData["공간"]!.contains(text) {
      DataManager.shared.filterData["공간"] = "0"
    }else {
      DataManager.shared.filterData["주거형태"] = "0"
    }
    DataManager.shared.noti.post(name: NotificationID.FilterCancelButtonDidTap, object: nil)
  }
  
  internal func setFilterCell(with text: String) {
    self.label.text = "  " + text
  }
}
