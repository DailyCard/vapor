//
//  UNUserNotificationCenter+Promise.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/1/19.
//  Copyright © 2019 Mars. All rights reserved.
//

import Foundation
import PromiseKit
import UserNotifications

extension UNUserNotificationCenter {
  func getNotificationSettings() -> Guarantee<UNNotificationSettings> {
    return Guarantee<UNNotificationSettings> {
      getNotificationSettings(completionHandler: $0)
    }
  }
  
  public func isNotificationPermissionNotDetermined() -> Guarantee<Bool> {
    return firstly {
      getNotificationSettings()
    }
    .then { settings in
      switch settings.authorizationStatus {
        case .notDetermined:
         return Guarantee.value(true)
      default:
        return Guarantee.value(false)
      }
    }
  }
  
  public func isNotificationPermissionAuthorized() -> Guarantee<Bool> {
    return firstly {
      getNotificationSettings()
    }
    .then { settings in
      switch settings.authorizationStatus {
      case .authorized, .provisional:
        return Guarantee.value(true)
      default:
        return Guarantee.value(false)
      }
    }
  }
  
  public func isNotificationPermissionDenied() -> Guarantee<Bool> {
    return firstly {
      getNotificationSettings()
    }
    .then { settings in
      switch settings.authorizationStatus {
      case .denied:
        return Guarantee.value(true)
      default:
        return Guarantee.value(false)
      }
    }
  }
  
  public func requestAuthorization(options: UNAuthorizationOptions) -> Promise<Bool> {
    return Promise<Bool> { resolver in
      requestAuthorization(options: options, completionHandler: resolver.resolve)
    }
  }
}
