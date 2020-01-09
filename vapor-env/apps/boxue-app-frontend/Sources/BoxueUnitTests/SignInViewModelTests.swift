//
//  BoxueSignInViewModelTests.swift
//  BoxueSignInViewModelTests
//
//  Created by Mars on 2018/12/31.
//  Copyright © 2018 Mars. All rights reserved.
//

import XCTest
import RxSwift
import RxTest
import PromiseKit
import RxBlocking

@testable import Boxue_iOS
@testable import BoxueDataKit

class SignInViewModelTests: CommonTests {
  /// - Typealias
  typealias Expected = [Recorded<Event<Bool>>]
  
  /// - Properties
  var viewModel: SignInViewModel!
  var guideVM: GuideViewModel!

  /// - Methods
  override func setUp() {
    super.setUp()
    
    viewModel = guideContainer.makeSignInViewModel()
    guideVM = guideContainer.sharedGuideViewModel
  }
  
  override func tearDown() {
    viewModel = nil
    
    super.tearDown()
  }

  /// - Tests
  func testEmailAndPasswordTextFieldStartsAtEnabled() throws {
    XCTAssertEqual(try viewModel.emailInputEnabled.toBlocking().first(), true)
    XCTAssertEqual(try viewModel.passwordInputEnabled.toBlocking().first(), true)
  }

  func testSignInButtonStartsAtEnabled() throws {
    XCTAssertEqual(try viewModel.signInButtonEnabled.toBlocking().first(), true)
  }
  
  func testSignInActivityIndicatorStartsAtHides() throws {
    XCTAssertEqual(try viewModel.signInActivityIndicatorAnimating.toBlocking().first(), false)
  }
  
  func testEmailTextFieldDisabledAfterSignInButtonPressed() {
    let expected: Expected = [
      .next(0, true),
      .next(0, false)
    ]
    
    t(source: viewModel.emailInputEnabled, expected: expected) {
      self.viewModel.signInButtonTapped.onNext(())
    }
  }
  
  func testPasswordTextFieldDisabledAfterSignInButtonPressed() {
    let expected: Expected = [
      .next(0, true),
      .next(0, false)
    ]
    
    t(source: viewModel.passwordInputEnabled, expected: expected) {
      self.viewModel.signInButtonTapped.onNext(())
    }
  }
  
  func testActivityIndicatorAnimatingdAfterSignInButtonPressed() {
    let expected: Expected = [
      .next(0, false),
      .next(0, true)
    ]
    
    t(source: viewModel.signInActivityIndicatorAnimating, expected: expected) {
      self.viewModel.signInButtonTapped.onNext(())
    }
  }
  
  func testGeneratingErrorMessageAfterSignInError() {
    t_c(source: viewModel.errorMessages, expected: 1) {
      self.viewModel.indicateSigningIn()
      let err = ErrorMessage(title: "Test", description: "Test description")
      self.viewModel.indicateSignInError(err)
    }
  }
  
  func testRestoreUIStateAfterErrorOccured() {
    let expected: Expected = [
      .next(0, true),
      .next(0, false),
      .next(0, true)
    ]
    
    let indicatorStatusExpected: Expected = [
      .next(0, false),
      .next(0, true),
      .next(0, false)
    ]
    
    func trigger() {
      self.viewModel.indicateSigningIn()
      let err = ErrorMessage(title: "Test", description: "Test description")
      self.viewModel.indicateSignInError(err)
    }
    
    t(source: viewModel.emailInputEnabled, expected: expected, process: trigger)
    t(source: viewModel.passwordInputEnabled, expected: expected, process: trigger)
    t(source: viewModel.signInButtonEnabled, expected: expected, process: trigger)
    t(source: viewModel.signInActivityIndicatorAnimating, expected: indicatorStatusExpected, process: trigger)
  }
  
  func testGetEmailAndPassword() {
    let email = "11@boxue.io"
    let password = "boxue1011"
    
    viewModel.emailInput.onNext(email)
    viewModel.passwordInput.onNext(password)
    
    let (e, p) = viewModel.getEmailAndPassword()
    
    XCTAssertEqual(e, email)
    XCTAssertEqual(p, password)
  }
  
  func testSignInSuccessfullyWhenPermissionNotDetermined() {
    let expected: [Recorded<Event<GuideNavigateAction>>] = [
      .next(0, .present(viewStatus: .welcome)),
      .next(0, .present(viewStatus: .requestNotification))
    ]
    
    t(source: guideVM.viewStatus, expected: expected, process: {
      self.viewModel.transmute(withPermissionNotDetermined: true)
    })
  }
  
  func testSignInSuccessfullyWhenPermissionDetermined() {
    let expected: [Recorded<Event<MainViewStatus>>] = [
      .next(0, .launching),
      .next(0, .browsing)
    ]
    
    t(source: mainViewModel.viewStatus, expected: expected, process: {
      self.viewModel.transmute(withPermissionNotDetermined: false)
    })
  }
}
