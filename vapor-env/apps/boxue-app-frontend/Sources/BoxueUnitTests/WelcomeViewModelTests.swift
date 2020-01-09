//
//  WelcomeViewModelTests.swift
//  BoxueUnitTests
//
//  Created by Mars on 2019/1/24.
//  Copyright © 2019 Mars. All rights reserved.
//

import XCTest
import RxSwift
import RxTest

import PromiseKit

@testable import Boxue_iOS
@testable import BoxueDataKit

class WelcomeViewModelTests: CommonTests {
  /// - Properties
  var welcomeVM: WelcomeViewModel!
  var guideVM: GuideViewModel!
  
  /// - Methods
  override func setUp() {
    super.setUp()
    
    welcomeVM = guideContainer.makeWelcomeViewModel()
    guideVM = guideContainer.sharedGuideViewModel
  }

  override func tearDown() {
    welcomeVM = nil
    guideVM = nil
    
    super.tearDown()
  }

  /// - Tests
  func testRequestProvisionalNotificationAndGoToBrowse() {
    let expected: [Recorded<Event<MainViewStatus>>] = [
      .next(0, .launching),
      .next(0, .browsing)
    ]
    
    t(source: mainViewModel.viewStatus, expected: expected, process: welcomeVM.requestNotification)
    t_c(source: welcomeVM.requestProvisionalNotification, expected: 1, process: welcomeVM.requestNotification)
  }
  
  func testGoToBrowseDirectly() {
    let expected: [Recorded<Event<MainViewStatus>>] = [
      .next(0, .launching),
      .next(0, .browsing)
    ]
    
    t(source: mainViewModel.viewStatus, expected: expected, process: welcomeVM.browseDirectly)
  }
  
  func testShowSignInView() {
    let expected: [Recorded<Event<GuideNavigateAction>>] = [
      .next(0, .present(viewStatus: .welcome)),
      .next(0, .present(viewStatus: .signIn))
    ]
    
    t(source: guideVM.viewStatus, expected: expected, process: welcomeVM.showSignInView)
  }
  
  func testBrowseNowButtonTappedWhenPermissionNotDetermined() {
    let expected: [Recorded<Event<MainViewStatus>>] = [
      .next(0, .launching),
      .next(0, .browsing)
    ]
    
    t(source: mainViewModel.viewStatus, expected: expected, process: {
      self.welcomeVM.transmute(withPermissionNotDetermined: true)
    })
    
    t_c(source: welcomeVM.requestProvisionalNotification, expected: 1, process: {
      self.welcomeVM.transmute(withPermissionNotDetermined: true)
    })
  }
  
  func testBrowseNowButtonTappedWhenPermissionDetermined() {
    let expected: [Recorded<Event<MainViewStatus>>] = [
      .next(0, .launching),
      .next(0, .browsing)
    ]
    
    t(source: mainViewModel.viewStatus, expected: expected, process: {
      self.welcomeVM.transmute(withPermissionNotDetermined: false)
    })
  }
}
