//
//  FirstLaunch.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/1/6.
//  Copyright © 2019 Mars. All rights reserved.
//

import Foundation
import UserNotifications

final public class Flag {
  /// - Singletons
  #if TEST
  public static let isFirstLaunch = true
  #else
  public static let isFirstLaunch = Flag(for: "io.boxue.Launch.wasLaunchedBefore").wasNotSet
  #endif
  
  /// - Typealias
  public typealias Getter = () -> Bool
  public typealias Setter = (Bool) -> Void
  
  /// - Attributes
  var wasSet: Bool
  public var wasNotSet: Bool {
    return !wasSet
  }
  
  /// - Initializers
  public init(getter: Getter, setter: Setter) {
    self.wasSet = getter()
    
    if !wasSet {
      setter(true)
    }
  }
  
  convenience init(
    userDefaults: UserDefaults = UserDefaults.standard, for key: String) {
    self.init(getter: {
      userDefaults.bool(forKey: key)
    }, setter: {
      userDefaults.set($0, forKey: key)
    })
  }
}
