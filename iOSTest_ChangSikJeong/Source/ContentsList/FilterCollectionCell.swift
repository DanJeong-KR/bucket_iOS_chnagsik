//
//  FilterCollectionCell.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 17/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class FilterCollectionCell: UICollectionViewCell {
  
  lazy var testlabel: UILabel = {
    let lb = UILabel(frame: .zero)
    lb.text = "test"
    addSubview(lb)
    return lb
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
    testlabel.layout.equalToSuperView()
  }
}
