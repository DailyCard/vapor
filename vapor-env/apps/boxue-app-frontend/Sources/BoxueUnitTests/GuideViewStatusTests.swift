//
//  GuideViewStatusTests.swift
//  BoxueUnitTests
//
//  Created by Mars on 2019/1/27.
//  Copyright © 2019 Mars. All rights reserved.
//

import XCTest

@testable import BoxueDataKit

class GuideViewStatusTests: CommonTests {
  /// - Methods
  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.tearDown()
  }

  /// - Tests
  func testHideStatusBarOnWelcomeAndRequestNotificationUI() {
    XCTAssertEqual(GuideViewStatus.welcome.hideNavigationBar(), true)
    XCTAssertEqual(GuideViewStatus.requestNotification.hideNavigationBar(), true)
  }
  
  func testDisplayStatusBar() {
    XCTAssertEqual(GuideViewStatus.signIn.hideNavigationBar(), false)
    XCTAssertEqual(GuideViewStatus.signUp.hideNavigationBar(), false)
    XCTAssertEqual(GuideViewStatus.contactUs.hideNavigationBar(), false)
    XCTAssertEqual(GuideViewStatus.resetPassword.hideNavigationBar(), false)
  }
}
