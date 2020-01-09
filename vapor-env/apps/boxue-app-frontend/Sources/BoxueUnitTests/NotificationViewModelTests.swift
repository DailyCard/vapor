//
//  NotificationViewModelTests.swift
//  BoxueUnitTests
//
//  Created by Mars on 2019/1/27.
//  Copyright © 2019 Mars. All rights reserved.
//

import XCTest

import RxSwift
import RxTest

@testable import Boxue_iOS
@testable import BoxueDataKit

class NotificationViewModelTests: CommonTests {
  /// - Typealias
  typealias Expected = [Recorded<Event<MainViewStatus>>]
  
  /// - Properties
  var notificationVM: NotificationViewModel!
  
  /// - Methods
  override func setUp() {
    super.setUp()
    notificationVM = guideContainer.makeNotificationViewModel()
  }
  override func tearDown() {
    notificationVM = nil
    super.tearDown()
  }
  
  /// - Tests
  func testEnableNotification() {
    let expected: Expected = [
      .next(0, .launching),
      .next(0, .browsing)
    ]
    
    t(source: mainViewModel.viewStatus, expected: expected) {
      self.notificationVM.enableNotificationTapped()
    }
  }
  
  func testDisableNotification() {
    let expected: Expected = [
      .next(0, .launching),
      .next(0, .browsing)
    ]
    
    t(source: mainViewModel.viewStatus, expected: expected) {
      self.notificationVM.disableNotificationTapped()
    }
  }
  
  func testRemindMeLater() {
    let expected: Expected = [
      .next(0, .launching),
      .next(0, .browsing)
    ]
    
    t(source: mainViewModel.viewStatus, expected: expected) {
      self.notificationVM.notDeterminedTapped()
    }
  }
  
  func testDisableNotificationBySystem() {
    t_c(source: notificationVM.systemDisabledPermission, expected: 1) {
      self.notificationVM.disableNotificationBySystem()
    }
  }
}
