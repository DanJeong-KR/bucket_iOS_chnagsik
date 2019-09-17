//
//  ContentTableViewCell.swift
//  iOSTest_ChangSikJeong
//
//  Created by Sicc on 17/09/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

class ContentTableViewCell: UITableViewCell {
  
  internal lazy var contentTextLabel: UILabel = {
    let lb = UILabel(frame: .zero)
    lb.numberOfLines = 5
    lb.lineBreakMode = .byTruncatingTail // ... 더보기
    lb.textColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
    lb.text = "...loading"
    lb.font = Global.regular
    self.addSubview(lb)
    return lb
  }()
  
  internal lazy var contentImageView: UIImageView = {
    let iv = UIImageView(frame: .zero)
    iv.contentMode = .scaleAspectFill
    addSubview(iv)
    return iv
  }()
  
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    fatalError(ErrorLog.coderInit)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    makeConstraint()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  private func makeConstraint() {
    contentTextLabel.layout.top(constant: 10).leading(constant: 10).trailing(constant: -10)
    
    contentImageView.layout.top(equalTo: contentTextLabel.bottomAnchor, constant: 10).leading().trailing().bottom().height(equalTo: self.contentImageView.widthAnchor)
  }
  
  internal func setContents(with data: Bucket) {
    self.contentTextLabel.text = data.description
    
    DispatchQueue.global().async { [weak self] in
      guard let `self` = self else { return logger(ErrorLog.retainCycle) }
      if let url = URL(string: data.imageUrl), let imageData = try? Data(contentsOf: url), let image = UIImage(data: imageData) {
        DispatchQueue.main.async {
          self.contentImageView.image = image
        }
      }else {
        logger(ErrorLog.unwrap)
      }
    }
  }
    
}
