//
//  SignInViewModel.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/12/23.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation
import UserNotifications
import RxSwift

public class SignInViewModel {
  
  let userSessionRepository: UserSessionRepository
  let browseResponder: BrowseResponder
  
  let navigateToRequestNotification: NavigateToRequestNotification
  let navigateToResetPassword: NavigateToResetPassword
  let navigateToContactUs: NavigateToContactUs
  
  public init(userSessionRepository: UserSessionRepository,
              browseResponder: BrowseResponder,
              navigateToRequestNotification: NavigateToRequestNotification,
              navigateToResetPassword: NavigateToResetPassword,
              navigateToContactUs: NavigateToContactUs) {
    self.userSessionRepository = userSessionRepository
    self.browseResponder = browseResponder
    self.navigateToRequestNotification = navigateToRequestNotification
    self.navigateToResetPassword = navigateToResetPassword
    self.navigateToContactUs = navigateToContactUs
    
    signInButtonTapped.asObservable().subscribe(onNext: {
      [weak self] in
      guard let `self` = self else { return }
      self.signIn()
    }).disposed(by: bag)
    
    resetPasswordButtonTapped.asObservable().subscribe(onNext: {
      [weak self] in
      guard let `self` = self else { return }
      self.navigateToResetPassword.navigateToResetPassword()
    }).disposed(by: bag)
    
    contactUsButtonTapped.asObservable().subscribe(onNext: {
      [weak self] in
      guard let `self` = self else { return }
      self.navigateToContactUs.navigateToContactUs()
    }).disposed(by: bag)
  }
  
  public let emailInput = BehaviorSubject<String>(value: "")
  public let emailInputEnabled = BehaviorSubject<Bool>(value: true)
  
  public let passwordInput = BehaviorSubject<String>(value: "")
  public let passwordInputEnabled = BehaviorSubject<Bool>(value: true)
  
  public lazy var signInButtonEnabled =
    Observable.combineLatest(
      emailInput.asObservable(),
      emailInputEnabled.asObservable(),
      passwordInput.asObservable(),
      passwordInputEnabled.asObservable()) {
      (e: String, es: Bool, p: String, ps: Bool) -> Bool in
      return (e.count >= 6 && e.isValidEmail && !p.isEmpty && es && ps)
    }.share()
  
  public let signInActivityIndicatorAnimating = BehaviorSubject<Bool>(value: false)
  
  public let signInButtonTapped = PublishSubject<Void>()
  public let resetPasswordButtonTapped = PublishSubject<Void>()
  public let contactUsButtonTapped = PublishSubject<Void>()
  
  public let err = ErrorMessage(title: .signInErrorTitle, description: .signInErrorDesc)
  private let errorMessagesSubject = PublishSubject<ErrorMessage>()
  public var errorMessages: Observable<ErrorMessage> {
    return errorMessagesSubject.asObservable()
  }
  
  public let bag = DisposeBag()
  
  func indicateSigningIn() {
    emailInputEnabled.onNext(false)
    passwordInputEnabled.onNext(false)
    signInActivityIndicatorAnimating.onNext(true)
  }
  
  /// Actually, we do not use the `error` parameter here. But the `catch` clause of
  /// the Promise library requires such a prototype for error handling.
  func indicateSignInError(_ error: Error) {
    errorMessagesSubject.onNext(err)
    emailInputEnabled.onNext(true)
    passwordInputEnabled.onNext(true)
    signInActivityIndicatorAnimating.onNext(false)
  }
  
  func getEmailAndPassword() -> (String, Secret) {
    do {
      let email = try emailInput.value()
      let password = try passwordInput.value()
      
      return (email, password)
    }
    catch {
      fatalError("Failed reading email and password from behavior subjects.")
    }
  }
  
  func navigateToNotification() {
    self.navigateToRequestNotification.navigateToRequestNotification()
  }
  
  func navigateToBrowse() {
    self.browseResponder.browse()
  }
  
  @objc public func signIn() {
    indicateSigningIn()
    let (email, password) = getEmailAndPassword()
    
    userSessionRepository.signIn(email: email, password: password)
      .then { _ /*userSession*/ in
        // If we reached here, the user has signed in and
        // the session data was saved to disk successfully.
        // So actually, we do not need the user session here.
        // Just redirect to the correct UI.
        UNUserNotificationCenter.current().isNotificationPermissionNotDetermined()
      }
      .done {
        self.transmute(withPermissionNotDetermined: $0)
      }
      .catch(indicateSignInError)
  }
  
  func transmute(withPermissionNotDetermined: Bool) {
    withPermissionNotDetermined ? navigateToNotification() : navigateToBrowse()
  }
}

extension String {
  static let signInErrorTitle = localized(of: "SIGN_IN_ERROR_TITLE")
  static let signInErrorDesc = localized(of: "SIGN_IN_ERROR_DESC")
}
