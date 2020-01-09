//
//  MainViewStatus.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/4.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation

public enum MainViewStatus {
  case launching
  case guiding
  case browsing
}

extension MainViewStatus: Equatable {
  public static func ==(lhs: MainViewStatus, rhs: MainViewStatus) -> Bool {
    switch (lhs, rhs) {
    case (.launching, .launching):
      return true
    case (.guiding, .guiding):
      return true
    case (.browsing, .browsing):
      return true
    default:
      return false
    }
  }
}
