//
//  WelcomeViewController.swift
//  Boxue_iOS
//
//  Created by Mars on 2018/10/4.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit
import SwiftUI
import RxSwift
import BoxueUIKit
import BoxueDataKit

public class GuideViewController: NiblessNavigationController {
  let viewModel: GuideViewModel
  let bag = DisposeBag()
  
  let welcomeController: WelcomeViewController
  let signInViewController: SignInViewController
  let signUpViewController: SignUpViewController
  let contactUsViewController: ContactUsViewController
  let resetPasswordViewController: ResetPasswordViewController
  let requestNotificationViewController: RequestNotificationViewController
  
  init(viewModel: GuideViewModel,
       welcomeViewController: WelcomeViewController,
       signInViewController: SignInViewController,
       signUpViewController: SignUpViewController,
       contactUsViewController: ContactUsViewController,
       resetPasswordViewController: ResetPasswordViewController,
       requestNotificationViewController: RequestNotificationViewController) {
    self.viewModel = viewModel
    self.welcomeController = welcomeViewController
    self.signInViewController = signInViewController
    self.signUpViewController = signUpViewController
    self.contactUsViewController = contactUsViewController
    self.resetPasswordViewController = resetPasswordViewController
    self.requestNotificationViewController = requestNotificationViewController
    super.init()
    
    self.delegate = self
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    subscribe(to: viewModel.viewStatus)
  }
  
  func subscribe(to observable: Observable<GuideNavigateAction>) {
    observable.distinctUntilChanged()
      .subscribe(onNext: { [weak self] action in
        guard let `self` = self else { return }

        self.respond(to: action)
      })
      .disposed(by: bag)
  }
  
  func respond(to navigateAction: GuideNavigateAction) {
    switch navigateAction {
    case .present(let viewStatus):
      present(viewStatus)
    case .presented:
      break
    }
  }
  
  func present(_ viewStatus: GuideViewStatus) {
    switch viewStatus {
    case .welcome:
      presentWelcomeScreen()
    case .signIn:
      presentSignInScreen()
    case .signUp:
      presentSignUpScreen()
    case .contactUs:
      presentContactUsScreen()
    case .resetPassword:
      presentResetPasswordScreen()
    case .requestNotification:
      presentRequestNotificationScreen()
    }
  }
  
  func presentWelcomeScreen() {
    pushViewController(welcomeController, animated: false)
  }
  
  func presentSignInScreen() {
    pushViewController(signInViewController, animated: true)
  }

  func presentSignUpScreen() {
    pushViewController(signUpViewController, animated: true)
  }
  
  func presentContactUsScreen() {
    pushViewController(contactUsViewController, animated: true)
  }
  
  func presentResetPasswordScreen() {
    pushViewController(resetPasswordViewController, animated: true)
  }
  
  func presentRequestNotificationScreen() {
    pushViewController(requestNotificationViewController, animated: true)
  }
}

extension GuideViewController {
  func toggleNavigationBar(for view: GuideViewStatus, animated: Bool) {
    if view.hideNavigationBar() {
      hideNavigationBar(animated: animated)
    }
    else {
      showNavigationBar(animated: animated)
    }
  }
  
  func hideNavigationBar(animated: Bool) {
    if animated {
      transitionCoordinator?.animate(alongsideTransition: {
        context in
        self.setNavigationBarHidden(true, animated: true)
      })
    }
    else {
      setNavigationBarHidden(true, animated: false)
    }
  }
  
  func showNavigationBar(animated: Bool) {
    if isNavigationBarHidden {
      if animated {
        transitionCoordinator?.animate(alongsideTransition: {
          context in
          self.setNavigationBarHidden(false, animated: true)
        })
      }
      else {
        self.setNavigationBarHidden(false, animated: false)
      }
    }
  }
}

/// UINavigationControllerDelegate
extension GuideViewController: UINavigationControllerDelegate {
  /// Animate the navigation bar display with view controller transition.
  public func navigationController(
    _ navigationController: UINavigationController,
    willShow viewController: UIViewController,
    animated: Bool) {
    guard let destView = guidingView(to: viewController) else { return }
    toggleNavigationBar(for: destView, animated: animated)
  }
  
  /// Trigger a `GuideNavigateAction` event according to the destination view type.
  public func navigationController(
    _ navigationController: UINavigationController,
    didShow viewController: UIViewController,
    animated: Bool) {
    guard let destView = guidingView(to: viewController) else { return }
    viewModel.presented(guideViewStatus: destView)
  }
}

extension GuideViewController {
  func guidingView(to viewController: UIViewController) -> GuideViewStatus? {
    switch viewController {
    case is WelcomeViewController:
      return .welcome
    case is SignInViewController:
      return .signIn
    case is SignUpViewController:
      return .signUp
    case is ContactUsViewController:
      return .contactUs
    case is ResetPasswordViewController:
      return .resetPassword
    case is RequestNotificationViewController:
      return .requestNotification
    default:
      assertionFailure("Invalid view controller is embedded in GuideViewController")
      return nil
    }
  }
}
