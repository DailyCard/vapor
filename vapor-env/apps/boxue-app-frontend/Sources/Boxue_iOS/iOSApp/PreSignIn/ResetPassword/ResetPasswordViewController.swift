//
//  ResetPasswordViewController.swift
//  Boxue_iOS
//
//  Created by Mars on 2018/10/18.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit
import RxSwift
import BoxueUIKit
import BoxueDataKit

public class ResetPasswordViewController: NiblessViewController {
  let bag: DisposeBag = DisposeBag()
  let viewModel: ResetPasswordViewModel
  var customAlert: CustomAlertViewController!
  
  init(factory: ResetPasswordViewModelFactory) {
    self.viewModel = factory.makeResetPasswordViewModel()
    super.init()
    
    title = .resetPassword
  }
    
  /// - Methods
  public override func loadView() {
    view = ResetPasswordRootView(viewModel: viewModel)
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    observeResettingResult()
    dismissKeyboardWhenTappedAround()
  }

  func presentErrorAlert() {
    let icon = #imageLiteral(resourceName: "fail")
    let ac = CustomAlertViewController(
      icon: icon,
      titleLabel: .resetPasswordErrorTitle,
      detailLabel: .resetPasswordErrorDesc,
      buttonText: "OK")
    
    present(ac, animated: true)
  }
  
  func presentSuccessAlert() {
    let icon = #imageLiteral(resourceName: "success")
    let ac = CustomAlertViewController(
      icon: icon,
      titleLabel: .resetSuccessTitle,
      detailLabel: .resetSuccessDesc,
      buttonText: .resetSuccessReLogin)
    
    ac.okAction = {
      self.navigationController?.popViewController(animated: true)
    }
    
    self.present(ac, animated: true)
  }
  
  func observeResettingResult() {
    viewModel.isResetSuccess.subscribe(onNext: {
      if $0 {
        self.presentSuccessAlert()
      }
      else {
        self.presentErrorAlert()
      }
      
    })
    .disposed(by: bag)
  }
}

extension ResetPasswordViewController {
  func dismissKeyboardWhenTappedAround() {
    let tap = UITapGestureRecognizer(
      target: self,
      action: #selector(ResetPasswordViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}

protocol ResetPasswordViewModelFactory {
  func makeResetPasswordViewModel() -> ResetPasswordViewModel
}

extension String {
  static let resetSuccessTitle = localized(of: "RESET_PASSWORD_SUCCESS_TITLE")
  static let resetSuccessDesc = localized(of: "RESET_PASSWORD_SUCCESS_DESC")
  static let resetSuccessReLogin = localized(of: "RESET_PASSWORD_RE_LOGIN")
  
  static let resetPasswordErrorTitle = localized(of: "RESET_PASSWORD_ERROR_TITLE")
  static let resetPasswordErrorDesc = localized(of: "RESET_PASSWORD_ERROR_DESC")
}
