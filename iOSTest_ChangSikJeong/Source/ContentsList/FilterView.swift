//
//  FilterView.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 17/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class FilterView: UIView {
  
  private lazy var filterCollectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    
    let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
    cv.register(cell: FilterCollectionCell.self)
    cv.dataSource = self
    cv.delegate = self
    cv.showsHorizontalScrollIndicator = false
    cv.isScrollEnabled = false
    cv.backgroundColor = .white
    addSubview(cv)
    
    return cv
  }()
  
  internal var filterData: [String] = ["test1", "test2", "test3"]

  override init(frame: CGRect) {
    super.init(frame: frame)
    makeConstraints()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError(ErrorLog.coderInit)
  }
  
  private func makeConstraints() {
    filterCollectionView.layout.equalToSuperView()
  }
}

extension FilterView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return filterData.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeue(FilterCollectionCell.self, indexPath)
    cell.testlabel.text = "test"
    return cell
  }
  
  
}

extension FilterView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 80, height: self.frame.height)
  }
}


