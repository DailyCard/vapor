//
//  ResetPasswordRootView.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/8/25.
//  Copyright © 2019 Mars. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import BoxueUIKit
import BoxueDataKit

class ResetPasswordRootView: NiblessView {
  /// - Properties
  var viewNotReady = true
  let bag = DisposeBag()
  let viewModel: ResetPasswordViewModel
  
  /// - Methods
  public init(frame: CGRect = .zero, viewModel: ResetPasswordViewModel) {
    self.viewModel = viewModel
    super.init(frame: frame)
    
    self.backgroundColor = .systemBackground
    
    bindInteraction()
    bindTextInputsToViewModel()
    bindViewModelToViews()
  }
  
  let upperView: UIView = {
    let view = UIView()
    view.backgroundColor = .secondarySystemBackground
    return view
  }()
  
  let resetPasswordLabel: UILabel = {
    let label = UILabel()
    label.text = .resetPassword
    label.numberOfLines = 0
    label.textColor = .label
    label.textAlignment = .center
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = UIFont.preferredFont(forTextStyle: .largeTitle).bold()
    
    return label
  }()
  
  let resetPasswordSlogan: UILabel = {
    let label = UILabel()
    label.text = .resetPasswordSlogan
    label.numberOfLines = 0
    label.textColor = .placeholderText
    label.textAlignment = .center
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = UIFont.preferredFont(forTextStyle: .footnote).bold()
    
    return label
  }()
  
  let emailIcon: UIView = {
    let imageView = UIImageView()
    imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    imageView.image = #imageLiteral(resourceName: "mail")
    imageView.contentMode = .center
    
    return imageView
  }();
  
  let emailInput: UITextField = {
    let input = UITextField()
    input.placeholder = .email
    input.textColor = .secondaryLabel
    input.textContentType = .emailAddress
    input.keyboardType = .emailAddress
    input.autocapitalizationType = .none
    input.autocorrectionType = .no
    return input
  }()
  
  /* Another input style that might be used later.
  let emailInput1: UITextField = {
    let input = UITextField()
    input.placeholder = .email
    input.textColor = .secondaryLabel
    input.keyboardType = .emailAddress
    input.autocapitalizationType = .none
    input.autocorrectionType = .no
    input.backgroundColor = .tertiarySystemFill
    input.layer.masksToBounds = true
    input.layer.cornerRadius = 8
    input.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 5))
    input.leftViewMode = .always
    input.leftView = paddingView
    return input
  }()
 */
  
  lazy var emailFieldStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [emailIcon, emailInput])
    stack.axis = .horizontal
    stack.spacing = 10
    stack.alignment = .center
    stack.heightAnchor.constraint(equalToConstant: 44).isActive = true
    
    return stack
  }()
  
  lazy var upperSeparator: UIView = {
    let view = UIView()
    view.backgroundColor = .separator
    view.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
    
    return view
  }()

  lazy var bottomSeparator: UIView = {
    let view = UIView()
    view.backgroundColor = .separator
    view.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
    
    return view
  }()
  
  let resetPasswordActivityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.hidesWhenStopped = true
    indicator.color = .white
    return indicator
  }()
  
  let resetPasswordBtn: UIButton = {
    let button = UIButton(type: .system)
    button.layer.cornerRadius = 6
    button.setTitle(.resetPasswordBtn, for: .normal)
    
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body).bold()
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .systemBlue
    
    button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    return button
  }()
  
  let rightsInfo: UILabel = {
    let label = UILabel()
    label.text = .rightsInfo
    label.numberOfLines = 0
    label.textColor = .tertiaryLabel
    label.textAlignment = .center
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    
    return label
  }()
  
  /// - Internal methods
  override func didMoveToWindow() {
    super.didMoveToWindow()
    guard viewNotReady else { return }
    
    constructViewHierarchy()
    activateConstraints()
    
    viewNotReady = false
  }
  
  func constructViewHierarchy() {
    addSubview(upperView)
    upperView.addSubview(resetPasswordLabel)
    upperView.addSubview(resetPasswordSlogan)
    upperView.addSubview(upperSeparator)
    upperView.addSubview(emailFieldStack)
    upperView.addSubview(bottomSeparator)
    addSubview(resetPasswordBtn)
    resetPasswordBtn.addSubview(resetPasswordActivityIndicator)
    addSubview(rightsInfo)
  }
}

extension ResetPasswordRootView {
  func activateConstraints() {
    activateConstraintsUpperView()
    activateConstraintsResetPasswordLabel()
    activateConstraintsResetPasswordSloganLabel()
    activateConstraintsResetPasswordForm()
    activateConstraintsResetPasswordBtn()
    activateConstraintsResetPasswordActivityIndicator()
    activateConstraintsRightsInfo()
  }
  
  func activateConstraintsUpperView() {
    upperView.translatesAutoresizingMaskIntoConstraints = false
    
    let top = upperView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
    let leading = upperView.leadingAnchor.constraint(equalTo: leadingAnchor)
    let trailing = upperView.trailingAnchor.constraint(equalTo: trailingAnchor)
    let bottom = upperView.bottomAnchor.constraint(equalTo: bottomSeparator.bottomAnchor, constant: 26)
    
    NSLayoutConstraint.activate([top, leading, trailing, bottom])
  }
  
  func activateConstraintsResetPasswordLabel() {
    resetPasswordLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let centerX = resetPasswordLabel.centerXAnchor.constraint(equalTo: upperView.centerXAnchor)
    let top = resetPasswordLabel.topAnchor.constraint(equalTo: upperView.topAnchor, constant: 58)
    
    NSLayoutConstraint.activate([centerX, top])
  }
  
  func activateConstraintsResetPasswordSloganLabel() {
    resetPasswordSlogan.translatesAutoresizingMaskIntoConstraints = false
    
    let top = resetPasswordSlogan.topAnchor.constraint(equalTo: resetPasswordLabel.bottomAnchor, constant: 30)
    let leading = resetPasswordSlogan.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
    let trailing = resetPasswordSlogan.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
    
    NSLayoutConstraint.activate([top, leading, trailing])
  }
  
  func activateConstraintsResetPasswordForm() {
    upperSeparator.translatesAutoresizingMaskIntoConstraints = false
    emailFieldStack.translatesAutoresizingMaskIntoConstraints = false
    bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
    
    let topU = upperSeparator.topAnchor.constraint(equalTo: resetPasswordSlogan.bottomAnchor, constant: 15)
    let leadingU = upperSeparator.leadingAnchor.constraint(equalTo: leadingAnchor)
    let trailingU = upperSeparator.trailingAnchor.constraint(equalTo: trailingAnchor)
    
    NSLayoutConstraint.activate([topU, leadingU, trailingU])
    
    let top = emailFieldStack.topAnchor.constraint(equalTo: upperSeparator.bottomAnchor)
    let leading = emailFieldStack.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
    let trailing = emailFieldStack.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
    
    NSLayoutConstraint.activate([top, leading, trailing])
    
    let topB = bottomSeparator.topAnchor.constraint(equalTo: emailFieldStack.bottomAnchor)
    let leadingB = bottomSeparator.leadingAnchor.constraint(equalTo: leadingAnchor)
    let trailingB = bottomSeparator.trailingAnchor.constraint(equalTo: trailingAnchor)
    
    NSLayoutConstraint.activate([topB, leadingB, trailingB])
  }
  
  func activateConstraintsResetPasswordBtn() {
    resetPasswordBtn.translatesAutoresizingMaskIntoConstraints = false
    
    let top = resetPasswordBtn.topAnchor.constraint(equalTo: upperView.bottomAnchor, constant: 20)
    let leading = resetPasswordBtn.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
    let trailing = resetPasswordBtn.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
    
    NSLayoutConstraint.activate([top, leading, trailing])
  }
  
  
  func activateConstraintsResetPasswordActivityIndicator() {
    resetPasswordActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
    
    let xCenter = resetPasswordActivityIndicator.centerXAnchor.constraint(equalTo: resetPasswordBtn.centerXAnchor)
    let yCenter = resetPasswordActivityIndicator.centerYAnchor.constraint(equalTo: resetPasswordBtn.centerYAnchor)
    
    NSLayoutConstraint.activate([xCenter, yCenter])
  }
  
  func activateConstraintsRightsInfo() {
    rightsInfo.translatesAutoresizingMaskIntoConstraints = false
    
    let hCenter = rightsInfo.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    let bottom = rightsInfo.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10)
    let width = rightsInfo.widthAnchor.constraint(equalToConstant: LaunchRootView.APP_TITLE_WIDTH)
    
    NSLayoutConstraint.activate([hCenter, bottom, width])
  }
}

/// UI bindings
extension ResetPasswordRootView {
  func bindInteraction() {
    resetPasswordBtn.rx.tap.bind(to: viewModel.resetPasswordBtnTapped).disposed(by: bag)
  }
  
  func bindTextInputsToViewModel() {
    bindEmailInput()
  }
  
  func bindEmailInput() {
    emailInput.rx.text
      .asDriver()
      .map { $0 ?? "" }
      .drive(viewModel.emailInput)
      .disposed(by: bag)
  }
  
  func bindViewModelToViews() {
    bindViewModelToEmailField()
    bindViewModelToResetPasswordButton()
    bindViewModelToActivityIndicator()
  }
  
  func bindViewModelToEmailField() {
    viewModel.emailInputEnabled
      .asDriver(onErrorJustReturn: true)
      .drive(emailInput.rx.isEnabled)
      .disposed(by: bag)
    
    viewModel.emailInput.asDriver(onErrorJustReturn: "")
      .drive(emailInput.rx.text)
      .disposed(by: bag)
  }
  
  func bindViewModelToResetPasswordButton() {
    viewModel.resetPasswordBtnEnabled.subscribe {
      guard let status = $0.element else { return }
      
      if !status {
        self.resetPasswordBtn.alpha = 0.6
        self.resetPasswordBtn.isEnabled = false
      }
      else {
        self.resetPasswordBtn.alpha = 1.0
        self.resetPasswordBtn.isEnabled = true
      }
    }.disposed(by: bag)
  }
  
  func bindViewModelToActivityIndicator() {
    viewModel.activityIndicatorAnimating.subscribe(onNext: {
      if $0 {
        self.resetPasswordBtn.setTitle("", for: .disabled)
        self.resetPasswordActivityIndicator.startAnimating()
      }
      else {
        self.resetPasswordBtn.setTitle(.resetPassword, for: .disabled)
        self.resetPasswordBtn.setTitle(.resetPassword, for: .normal)
        self.resetPasswordActivityIndicator.stopAnimating()
      }
    }).disposed(by: bag)
  }
}

extension String {
  static let resetPasswordBtn = localized(of: "RESET_PASSWORD_BTN")
  static let resetPasswordSlogan = localized(of: "RESET_PASSWORD_SLOGAN")
}
