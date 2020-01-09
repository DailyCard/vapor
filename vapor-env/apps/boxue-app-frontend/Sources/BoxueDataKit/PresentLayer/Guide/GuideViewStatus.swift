//
//  GuideViewStatus.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/17.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation

public enum GuideViewStatus {
  case welcome
  case signIn
  case signUp
  case contactUs
  case resetPassword
  case requestNotification
  
  public func hideNavigationBar() -> Bool {
    switch self {
    case .welcome, .requestNotification:
        return true
    default:
        return false
    }
  }
}
