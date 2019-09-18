//
//  ButtonType.swift
//  WeatherApp_KakaoPay
//
//  Created by Sicc on 02/08/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

// 버튼을 직관적으로 구별하기 위해 버튼의 이름을 id로 사용함
enum ButtonID: Int {
  case sortingButton
  case spaceButton
  case residenceButton
  
  var id: Int {
    return self.rawValue
  }
}

extension UIControl {
  var id: Int {
    get {
      return self.tag
    } set {
      self.tag = newValue
    }
  }
}

// Noti Name 오타방지
enum NotificationID {
  static let UserActionDidTap = NSNotification.Name("UserActionDidTap")
  static let FilterCancelButtonDidTap = NSNotification.Name(rawValue: "FilterCancelButtonDidTap")
}
