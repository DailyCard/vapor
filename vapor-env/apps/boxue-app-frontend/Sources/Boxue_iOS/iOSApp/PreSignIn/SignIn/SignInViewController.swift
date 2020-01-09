//
//  SignInViewController.swift
//  Boxue_iOS
//
//  Created by Mars on 2018/10/4.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit
import RxSwift
import BoxueUIKit
import BoxueDataKit

public class SignInViewController: NiblessViewController {
  /// - Properties
  let disposeBag = DisposeBag()
  let viewModel: SignInViewModel
  
  /// - Methods
  init(signInViewModelFactory: SignInViewModelFactory) {
    self.viewModel = signInViewModelFactory.makeSignInViewModel()
    super.init()
  }

  public override func loadView() {
    self.view = SignInRootView(viewModel: viewModel)
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.title = .signIn
    observeErrorMessage()
    dismissKeyboardWhenTappedAround()
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    addKeyboardObservers()
  }
  
  public override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    removeKeyboardObservers()
  }
}

/// Error handling
extension SignInViewController {
  func observeErrorMessage() {
    viewModel.errorMessages
      .asDriver { _ in fatalError("Unexpected error from error messages observable.") }
      .drive(onNext: { [weak self] errorMessage in
        self?.present(errorMessage: errorMessage)
      })
      .disposed(by: disposeBag)
  }
}

/// Respond to keyboard up and down
extension SignInViewController {
  func addKeyboardObservers() {
    let notificationCenter = NotificationCenter.default
    
    notificationCenter.addObserver(
      self,
      selector: #selector(adjustUIwithKeyboard),
      name: UIResponder.keyboardWillHideNotification,
      object: nil)
    
    notificationCenter.addObserver(
      self,
      selector: #selector(adjustUIwithKeyboard),
      name: UIResponder.keyboardWillShowNotification,
      object: nil)
  }
  
  func removeKeyboardObservers() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc func adjustUIwithKeyboard(notification: Notification) {
    if let userInfo = notification.userInfo,
      let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
      // Keyboard frame is always accordance to screen coordinates.
      // We should convert it within the `view's` own bounds before using it.
      let convertedKeyboardFrame = view.convert(keyboardFrame.cgRectValue, from: view.window)
      
      if notification.name == UIResponder.keyboardWillHideNotification {
        // Make the UI fit the whole screen
        (view as! SignInRootView).resetScrollViewContentInsect()
      }
      else if notification.name == UIResponder.keyboardWillShowNotification {
        // Make the UI scrollable
        (view as! SignInRootView).moveContentForKeyboardDisplay(keyboardFrame: convertedKeyboardFrame)
      }
    }
  }
}

extension SignInViewController {
  func dismissKeyboardWhenTappedAround() {
    let tap = UITapGestureRecognizer(
      target: self,
      action: #selector(SignInViewController.dismissKeyboard))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}

protocol SignInViewModelFactory {
  func makeSignInViewModel() -> SignInViewModel
}
