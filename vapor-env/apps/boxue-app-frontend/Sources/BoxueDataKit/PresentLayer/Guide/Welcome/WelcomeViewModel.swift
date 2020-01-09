//
//  WelcomeViewModel.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/11/24.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation
import UserNotifications

import RxSwift
import PromiseKit

public class WelcomeViewModel {
  /// - Properties
  lazy var isNotificationPermissionNotDetermined = UNUserNotificationCenter.current()
      .isNotificationPermissionNotDetermined()
  
  let browseResponder: BrowseResponder
  public let navigateToSignIn: NavigateToSignIn
  public let navigateToRequestNotification: NavigateToRequestNotification
  
  // Only used after iOS 12
  let requestProvisionalNotificationSubject = PublishSubject<Void>()
  public var requestProvisionalNotification: Observable<Void> {
    return requestProvisionalNotificationSubject.asObservable()
  }
  
  /// - Methods
  public init(browseResponder: BrowseResponder,
              navigateToSignIn: NavigateToSignIn,
              navigateToRequestNotification: NavigateToRequestNotification) {
    self.browseResponder = browseResponder
    self.navigateToSignIn = navigateToSignIn
    self.navigateToRequestNotification = navigateToRequestNotification
  }
  
  @objc public func showSignInView() {
    navigateToSignIn.navigateToSignIn()
  }
  
  @objc public func browseNowButtonTapped() {
    firstly {
      UNUserNotificationCenter
        .current()
        .isNotificationPermissionNotDetermined()
    }
    .done {
      self.transmute(withPermissionNotDetermined: $0)
    }
  }
  
  func transmute(withPermissionNotDetermined: Bool) {
    withPermissionNotDetermined ? requestNotification() : browseDirectly()
  }
  
  func requestNotification() {
    // If people choosed "Browse now", they might just wanna look around.
    // So do not interfere them by a popup. The provisional permission can make
    // our notifications in the notification center by default.
    requestProvisionalNotificationSubject.onNext(())
    browseResponder.browse()
  }
  
  func browseDirectly() {
    self.browseResponder.browse()
  }
}
