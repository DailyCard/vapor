//
//  ResetPasswordViewModel.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/8/25.
//  Copyright © 2019 Mars. All rights reserved.
//

import Foundation
import RxSwift

public class ResetPasswordViewModel {
  let userSessionRepository: UserSessionRepository
  
  public init(userSessionRepository: UserSessionRepository) {
    self.userSessionRepository = userSessionRepository
    
    resetPasswordBtnTapped.asObservable().subscribe(onNext: {
      self.resetPassword()
    }).disposed(by: bag)
  }
  
  public let bag = DisposeBag()
  
  public let emailInput = BehaviorSubject<String>(value: "")
  public let emailInputEnabled = BehaviorSubject<Bool>(value: true)
  
  public let resetPasswordBtnTapped = PublishSubject<Void>()
  public let activityIndicatorAnimating = BehaviorSubject<Bool>(value: false)
  
  public lazy var resetPasswordBtnEnabled =
    Observable.combineLatest(emailInput.asObservable(), emailInputEnabled.asObservable()) {
      (e: String, es: Bool) -> Bool in
      return (e.count >= 6) && e.isValidEmail && es
    }.share()
  
  func indicateResettingPassword() {
    emailInputEnabled.onNext(false)
    activityIndicatorAnimating.onNext(true)
  }
  
  func getEmail() -> String {
    do {
      return try emailInput.value()
    }
    catch {
      fatalError("Failed reading email from behavior subjects.")
    }
  }
  
  private let isResetSuccessSubject = PublishSubject<Bool>()
  public var isResetSuccess: Observable<Bool> {
    return isResetSuccessSubject.asObservable()
  }
  
  func indicateResetPasswordError() {
    isResetSuccessSubject.onNext(false)
    emailInputEnabled.onNext(true)
    activityIndicatorAnimating.onNext(false)
  }
  
  func indicateResetPasswordSuccess() {
    isResetSuccessSubject.onNext(true)
    emailInput.onNext("")
    emailInputEnabled.onNext(true)
    activityIndicatorAnimating.onNext(false)
  }
  
  func resetPassword() {
    indicateResettingPassword()
    let email = getEmail()
    
    userSessionRepository.resetPassword(of: email)
      .done { _ in
        self.indicateResetPasswordSuccess()
      }
      .catch { _ in
        self.indicateResetPasswordError()
      }
  }
}
