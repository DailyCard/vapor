//
//  MainViewModelTests.swift
//  BoxueUnitTests
//
//  Created by Mars on 2019/2/23.
//  Copyright © 2019 Mars. All rights reserved.
//

import XCTest
import RxTest
import RxSwift

@testable import Boxue_iOS
@testable import BoxueDataKit

class MainViewModelTests: CommonTests {
  /// - Typealias
  typealias Expected = [Recorded<Event<MainViewStatus>>]
  
  /// - Methods
  override func setUp() {
    super.setUp()
  }

  override func tearDown() {
    super.setUp()
  }

  /// - Tests
  func testGuidingStatus() {
    let expected: Expected = [
      .next(0, .launching),
      .next(0, .guiding)
    ]
    
    t(source: mainViewModel.viewStatus, expected: expected) {
      self.mainViewModel.guide()
    }
  }
  
  func testBrowseStatus() {
    let expected: Expected = [
      .next(0, .launching),
      .next(0, .browsing)
    ]
    
    t(source: mainViewModel.viewStatus, expected: expected) {
      self.mainViewModel.browse()
    }
  }
}
