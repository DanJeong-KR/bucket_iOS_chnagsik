//
//  ContentTableViewCell.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 17/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
  
  internal lazy var contentTextView: UITextView = {
    let tv = UITextView(frame: .zero)
    tv.backgroundColor = .green
    tv.text =
    """
    안녕
    하
    세
    요
    오오
    """
    self.contentView.addSubview(tv)
    return tv
  }()
  
  internal lazy var contentImageView: UIImageView = {
    let iv = UIImageView(frame: .zero)
    iv.backgroundColor = .yellow
    self.contentView.addSubview(iv)
    return iv
  }()
  
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError(ErrorLog.coderInit)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    makeConstraint()
  }
  
  private func makeConstraint() {
    contentTextView.layout.top(constant: 10).leading(constant: 10).trailing(constant: -10)
    contentTextView.setContentHuggingPriority(.defaultHigh, for: .vertical)
    
    contentImageView.layout.top(equalTo: contentTextView.bottomAnchor).leading().trailing().bottom()
  }
    
}
