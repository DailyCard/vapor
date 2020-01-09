//
//  NotificationViewModel.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/1/19.
//  Copyright © 2019 Mars. All rights reserved.
//

import Foundation

import RxSwift
import PromiseKit

public class NotificationViewModel {
  /// - Properties
  let browseResponder: BrowseResponder
  
  let systemDisabledPermissionSubject = PublishSubject<Void>()
  public var systemDisabledPermission: Observable<Void> {
    return systemDisabledPermissionSubject.asObservable()
  }
  
  /// - Initializer
  public init(
    browseResponder: BrowseResponder) {
    self.browseResponder = browseResponder
  }
  
  /// - Methods
  public func enableNotificationTapped() {
    navigateToBrowse()
  }
  
  public func disableNotificationTapped() {
    navigateToBrowse()
  }
  
  public func notDeterminedTapped() {
    navigateToBrowse()
  }
  
  public func disableNotificationBySystem() {
    systemDisabledPermissionSubject.onNext(())
  }
  
  /// - Helpers
  func navigateToBrowse() {
    browseResponder.browse()
  }
}
