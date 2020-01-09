//
//  FirstLaunchTests.swift
//  BoxueSignInViewModelTests
//
//  Created by Mars on 2019/1/7.
//  Copyright © 2019 Mars. All rights reserved.
//

import XCTest
import RxTest
import RxSwift

@testable import Boxue_iOS
@testable import BoxueDataKit

class LaunchViewModelTests: CommonTests {
  /// - Typealias
  typealias Expected = [Recorded<Event<MainViewStatus>>]
  
  /// - Properties
  var launchViewModel: LaunchViewModel!
  
  /// - Methods
  override func setUp() {
    super.setUp()
    launchViewModel = appContainer.makeLaunchViewModel()
  }
  override func tearDown() {
    launchViewModel = nil
    super.tearDown()
  }
  
  /// - Tests
  func testFirstLaunching() {
    let expected: Expected = [
      .next(0, .launching),
      .next(0, .guiding)
    ]
    
    t(source: mainViewModel.viewStatus, expected: expected) {
      self.launchViewModel.isFirstLaunch = true
      self.launchViewModel.goToNextScreen()
    }
  }
  
  func testLaunchedBefore() {
    let expected: Expected = [
      .next(0, .launching),
      .next(0, .browsing)
    ]
    
    t(source: mainViewModel.viewStatus, expected: expected) {
      self.launchViewModel.isFirstLaunch = false
      self.launchViewModel.goToNextScreen()
    }
  }
}
