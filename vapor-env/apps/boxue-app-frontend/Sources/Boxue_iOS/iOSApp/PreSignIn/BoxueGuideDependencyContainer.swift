//
//  BoxueGuideDependencyContainer.swift
//  Boxue_iOS
//
//  Created by Mars on 2018/10/17.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation
import BoxueDataKit

public class BoxueGuideDependencyContainer {
  /// - Properties
  /// From parent container
  let sharedMainViewModel: MainViewModel
  let sharedUserSessionRepository: UserSessionRepository
  
  /// Long lived dependencies
  let sharedGuideViewModel: GuideViewModel
  
  init(appDependencyContainer: BoxueAppDependencyContainer) {
    func makeGuideViewModel() -> GuideViewModel {
      return GuideViewModel()
    }
    
    self.sharedMainViewModel = appDependencyContainer.sharedMainViewModel
    self.sharedUserSessionRepository = appDependencyContainer.sharedUserSessionRepository
    self.sharedGuideViewModel = makeGuideViewModel()
  }
  
  public func makeGuideViewController() -> GuideViewController {
    return GuideViewController(viewModel: sharedGuideViewModel,
                               welcomeViewController: makeWelcomeController(),
                               signInViewController: makeSignInViewController(),
                               signUpViewController: makeSignUpViewController(),
                               contactUsViewController: makeContactUsViewController(),
                               resetPasswordViewController: makeResetPasswordViewController(),
                               requestNotificationViewController: makeRequestNotificationViewController())
  }
  
  public func makeWelcomeController() -> WelcomeViewController {
    return WelcomeViewController(welcomeViewModelFactory: self)
  }
  
  public func makeSignInViewController() -> SignInViewController {
    return SignInViewController(signInViewModelFactory: self)
  }
  
  public func makeSignUpViewController() -> SignUpViewController {
    return SignUpViewController()
  }
  
  public func makeContactUsViewController() -> ContactUsViewController {
    return ContactUsViewController(factory: self)
  }
  
  public func makeResetPasswordViewController() -> ResetPasswordViewController {
    return ResetPasswordViewController(factory: self)
  }
  
  public func makeRequestNotificationViewController() -> RequestNotificationViewController {
    return RequestNotificationViewController(factory: self)
  }
}

extension BoxueGuideDependencyContainer: WelcomeViewModelFactory {
  public func makeWelcomeViewModel() -> WelcomeViewModel {
    return WelcomeViewModel(browseResponder: sharedMainViewModel,
                            navigateToSignIn: sharedGuideViewModel,
                            navigateToRequestNotification: sharedGuideViewModel)
  }
}

extension BoxueGuideDependencyContainer: SignInViewModelFactory {
  public func makeSignInViewModel() -> SignInViewModel {
    return SignInViewModel(userSessionRepository: sharedUserSessionRepository,
                           browseResponder: sharedMainViewModel,
                           navigateToRequestNotification: sharedGuideViewModel,
                           navigateToResetPassword: sharedGuideViewModel,
                           navigateToContactUs: sharedGuideViewModel)
  }
}

extension BoxueGuideDependencyContainer: ResetPasswordViewModelFactory {
  public func makeResetPasswordViewModel() -> ResetPasswordViewModel {
    return ResetPasswordViewModel(userSessionRepository: sharedUserSessionRepository)
  }
}

extension BoxueGuideDependencyContainer: ContactUsViewModelFactory {
  public func makeContactUsViewModel() -> ContactUsViewModel {
    return ContactUsViewModel()
  }
}

extension BoxueGuideDependencyContainer: NotificationViewModelFactory {
  public func makeNotificationViewModel() -> NotificationViewModel {
    return NotificationViewModel(browseResponder: sharedMainViewModel)
  }
}
