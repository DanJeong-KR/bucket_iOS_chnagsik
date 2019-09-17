//
//  ButtonType.swift
//  WeatherApp_KakaoPay
//
//  Created by Sicc on 02/08/2019.
//  Copyright © 2019 chang sic jung. All rights reserved.
//

import UIKit

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

enum NotificationID {
  static let UserActionDidTap = NSNotification.Name("UserActionDidTap")
  static let FilterCancelButtonDidTap = NSNotification.Name(rawValue: "FilterCancelButtonDidTap")
}
