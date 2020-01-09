//
//  GuideViewModel.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/17.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation
import RxSwift

public typealias GuideNavigateAction = NavigationAction<GuideViewStatus>

public class GuideViewModel
  :NavigateToSignIn,
  NavigateToSignUp,
  NavigateToContactUs,
  NavigateToResetPassword,
  NavigateToRequestNotification {
  
  public var viewStatus: Observable<GuideNavigateAction> {
    return viewBehavior.asObservable()
  }
  
  private let viewBehavior = BehaviorSubject<GuideNavigateAction>(
    value: .present(viewStatus: .welcome))
  
  public init() {}
  
  public func navigateToSignIn() {
    viewBehavior.onNext(.present(viewStatus: .signIn))
  }
  
  public func navigateToSignUp() {
    viewBehavior.onNext(.present(viewStatus: .signUp))
  }
  
  public func navigateToContactUs() {
    viewBehavior.onNext(.present(viewStatus: .contactUs))
  }
  
  public func navigateToResetPassword() {
    viewBehavior.onNext(.present(viewStatus: .resetPassword))
  }
  
  public func navigateToRequestNotification() {
    viewBehavior.onNext(.present(viewStatus: .requestNotification))
  }
  
  public func presented(guideViewStatus: GuideViewStatus) {
    viewBehavior.onNext(.presented(viewStatus: guideViewStatus))
  }
}

