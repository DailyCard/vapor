//
//  SignInRootView.swift
//  Boxue_iOS
//
//  Created by Mars on 2018/11/26.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import BoxueUIKit
import BoxueDataKit

class SignInRootView: NiblessView {
  /// - Properties
  var viewNotReady = true
  let bag = DisposeBag()
  let viewModel: SignInViewModel
  
  /// - Methods
  public init(frame: CGRect = .zero, viewModel: SignInViewModel) {
    self.viewModel = viewModel
    super.init(frame: frame)
    
    self.backgroundColor = .systemBackground
    
    bindInteraction()
    bindTextInputsToViewModel()
    bindViewModelToViews()
  }
  
  let scrollView: UIScrollView = {
    let sv = UIScrollView()
    sv.showsVerticalScrollIndicator = false
    return sv
  }()
  
  let contentView: UIView = {
    let view = UIView()
    view.backgroundColor = .systemBackground
    return view
  }()
  
  let welcomeLabel: UILabel = {
    let label = UILabel()
    label.text = .welcomeLabel
    label.numberOfLines = 0
    label.textColor = .label
    label.textAlignment = .center
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = UIFont.preferredFont(forTextStyle: .largeTitle).bold()
    
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
    input.keyboardType = .emailAddress
    input.textContentType = .emailAddress
    input.autocapitalizationType = .none
    input.autocorrectionType = .no
    return input
  }()
  
  lazy var emailFieldStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [emailIcon, emailInput])
    stack.axis = .horizontal
    stack.spacing = 10
    stack.alignment = .center
    stack.heightAnchor.constraint(equalToConstant: 44).isActive = true
    
    return stack
  }()
  
  let passwordIcon: UIView = {
    let imageView = UIImageView()
    imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
    imageView.image = #imageLiteral(resourceName: "password")
    imageView.contentMode = .center
    
    return imageView
  }();
  
  let passwordInput: UITextField = {
    let input = UITextField()
    input.placeholder = .password
    input.isSecureTextEntry = true
    input.textColor = .secondaryLabel
    input.heightAnchor.constraint(equalToConstant: 44).isActive = true
    
    return input
  }()
  
  lazy var passwordFieldStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [passwordIcon, passwordInput])
    stack.axis = .horizontal
    stack.spacing = 10
    stack.alignment = .center
    stack.heightAnchor.constraint(equalToConstant: 44).isActive = true
    
    return stack
  }()
  
  lazy var midSeparator: UIView = {
    let view = UIView()
    view.backgroundColor = .separator
    view.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
    
    return view
  }()
  
  lazy var signInFormStack: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [emailFieldStack, midSeparator, passwordFieldStack])
    stack.axis = .vertical
    stack.spacing = 5
    return stack
  }()
  
  lazy var bottomSeparator: UIView = {
    let view = UIView()
    view.backgroundColor = .separator
    view.heightAnchor.constraint(equalToConstant: 0.8).isActive = true
    
    return view
  }()
  
  let containerView: UIView = {
    let container = UIView()
    container.backgroundColor = .secondarySystemBackground
    return container
  }()
  
  let signInButton: UIButton = {
    let button = UIButton(type: .system)
    button.layer.cornerRadius = 6
    button.setTitle(.signIn, for: .normal)
    
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body).bold()
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .systemBlue
    
    button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    return button
  }()
  
  let signInActivityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(style: .medium)
    indicator.hidesWhenStopped = true
    indicator.color = .white
    return indicator
  }()
  
  let contactUsButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(.contactUs, for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
    button.tintColor = .link
    return button
  }()
  
  let resetPasswordButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle(.resetPassword, for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
    
    return button
  }()
  
  lazy var helpButtonStack: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [contactUsButton, resetPasswordButton])
    sv.spacing = 10
    sv.axis = .vertical
    sv.alignment = .fill
    sv.distribution = .fillEqually
    
    return sv
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
    scrollView.addSubview(contentView)
    contentView.addSubview(containerView)
    containerView.addSubview(welcomeLabel)
    containerView.addSubview(signInFormStack)
    contentView.addSubview(bottomSeparator)
    contentView.addSubview(signInButton)
    contentView.addSubview(helpButtonStack)
    contentView.addSubview(rightsInfo)
    signInButton.addSubview(signInActivityIndicator)
    
    
    addSubview(scrollView)
  }
  
  func activateConstraints() {
    activateConstraintsScrollView()
    activateConstraintsContentView()
    activateConstraintsContainerView()
    activateConstraintsWelcomeLabel()
    activateConstraintsSignInFormStack()
    activateConstraintsBottomSeparator()
    activateConstraintsSignInButton()
    activateConstraintsSignInActivityIndicator()
    activateConstraintsHelpButtonStack()
    activateConstraintsRightsInfo()
    
  }
  
  func resetScrollViewContentInsect() {
    scrollView.contentInset = UIEdgeInsets.zero
  }
  
  func moveContentForKeyboardDisplay(keyboardFrame: CGRect) {
    scrollView.contentInset.bottom = keyboardFrame.height
  }
}

/// - Layouts
extension SignInRootView {
  func activateConstraintsScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    
    let leading = scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
    let trailing = scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    let top = scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor)
    let bottom = scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
    
    NSLayoutConstraint.activate([leading, trailing, top, bottom])
  }
  
  func activateConstraintsContentView() {
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    /// Mark
    ///
    /// `ContentLayoutGuide` is only available above iOS 11
    /// We can use `contentInset` instead to be compatible with previous iOS version.
    ///
    let svCLG = scrollView.contentLayoutGuide
    
    NSLayoutConstraint.activate([
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
      
      contentView.topAnchor.constraint(equalTo: svCLG.topAnchor),
      contentView.leadingAnchor.constraint(equalTo: svCLG.leadingAnchor),
      contentView.bottomAnchor.constraint(equalTo: svCLG.bottomAnchor),
      contentView.trailingAnchor.constraint(equalTo: svCLG.trailingAnchor)
    ])
  }
  
  func activateConstraintsContainerView() {
    containerView.translatesAutoresizingMaskIntoConstraints = false
    
    let top = containerView.topAnchor.constraint(equalTo: contentView.topAnchor)
    let leading = containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
    let trailing = containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
    let bottom = containerView.bottomAnchor.constraint(equalTo: signInFormStack.bottomAnchor, constant: 5)
    
    NSLayoutConstraint.activate([top, leading, trailing, bottom])
  }
  
  func activateConstraintsBottomSeparator() {
    bottomSeparator.translatesAutoresizingMaskIntoConstraints = false
    
    let top = bottomSeparator.topAnchor.constraint(equalTo: containerView.bottomAnchor)
    let leading = bottomSeparator.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
    let trailing = bottomSeparator.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
    
    NSLayoutConstraint.activate([top, leading, trailing])
  }
  
  func activateConstraintsWelcomeLabel() {
    welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
    
    let top = welcomeLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 58)
    let leading = welcomeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
    let trailing = welcomeLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
    
    NSLayoutConstraint.activate([top, leading, trailing]) 
  }
  
  func activateConstraintsSignInFormStack() {
    signInFormStack.translatesAutoresizingMaskIntoConstraints = false
    
    let top = signInFormStack.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 58)
    let leading = signInFormStack.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
    let trailing = signInFormStack.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
    
    NSLayoutConstraint.activate([top, leading, trailing])
  }
  
  func activateConstraintsSignInButton() {
    signInButton.translatesAutoresizingMaskIntoConstraints = false
    let top = signInButton.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 25)
    let leading = signInButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor)
    let trailing = signInButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
    
    NSLayoutConstraint.activate([top, leading, trailing])
  }
  
  func activateConstraintsSignInActivityIndicator() {
    signInActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
    
    let centerX = signInActivityIndicator.centerXAnchor.constraint(equalTo: signInButton.centerXAnchor)
    let centerY = signInActivityIndicator.centerYAnchor.constraint(equalTo: signInButton.centerYAnchor)
    
    NSLayoutConstraint.activate([centerX, centerY])
  }
  
  func activateConstraintsHelpButtonStack() {
    helpButtonStack.translatesAutoresizingMaskIntoConstraints = false
    
    
    let center = helpButtonStack.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    let leading = helpButtonStack.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor)
    let trailing = helpButtonStack.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
    let bottom = helpButtonStack.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -55)
    
    NSLayoutConstraint.activate([center, leading, trailing, bottom])
  }
  
  func activateConstraintsRightsInfo() {
    rightsInfo.translatesAutoresizingMaskIntoConstraints = false
    
    let hCenter = rightsInfo.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    let bottom = rightsInfo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    let width = rightsInfo.widthAnchor.constraint(equalToConstant: LaunchRootView.APP_TITLE_WIDTH)
    
    NSLayoutConstraint.activate([hCenter, bottom, width])
  }
}

/// UI bindings
extension SignInRootView {
  func bindInteraction() {
    signInButton.rx.tap.bind(to: viewModel.signInButtonTapped).disposed(by: bag)
    resetPasswordButton.rx.tap.bind(to: viewModel.resetPasswordButtonTapped).disposed(by: bag)
    contactUsButton.rx.tap.bind(to: viewModel.contactUsButtonTapped).disposed(by: bag)
  }
  
  func bindTextInputsToViewModel() {
    bindEmailInput()
    bindPasswordInput()
  }
  
  func bindEmailInput() {
    emailInput.rx.text
      .asDriver()
      .map { $0 ?? "" }
      .drive(viewModel.emailInput)
      .disposed(by: bag)
  }
  
  func bindPasswordInput() {
    passwordInput.rx.text
      .asDriver()
      .map { $0 ?? "" }
      .drive(viewModel.passwordInput)
      .disposed(by: bag)
  }
  
  func bindViewModelToViews() {
    bindViewModelToEmailField()
    bindViewModelToPasswordField()
    bindViewModelToSignInButton()
    bindViewModelToSignInActivityIndicator()
  }
  
  func bindViewModelToEmailField() {
    viewModel.emailInputEnabled
      .asDriver(onErrorJustReturn: true)
      .drive(emailInput.rx.isEnabled)
      .disposed(by: bag)
  }
  
  func bindViewModelToPasswordField() {
    viewModel.passwordInputEnabled
      .asDriver(onErrorJustReturn: true)
      .drive(passwordInput.rx.isEnabled)
      .disposed(by: bag)
  }
  
  func bindViewModelToSignInButton() {
    viewModel.signInButtonEnabled.subscribe {
      guard let status = $0.element else { return }
      
      if !status {
        self.signInButton.alpha = 0.6
        self.signInButton.isEnabled = false
      }
      else {
        self.signInButton.alpha = 1.0
        self.signInButton.isEnabled = true
      }
    }.disposed(by: bag)
  }
  
  func bindViewModelToSignInActivityIndicator() {
    viewModel.signInActivityIndicatorAnimating.subscribe(onNext: {
      if $0 {
        self.signInButton.setTitle("", for: .disabled)
        self.signInActivityIndicator.startAnimating()
      }
      else {
        self.signInButton.setTitle(.signIn, for: .disabled)
        self.signInButton.setTitle(.signIn, for: .normal)
        self.signInActivityIndicator.stopAnimating()
      }
    }).disposed(by: bag)
  }
}

extension String {
  static let email = localized(of: "EMAIL")
  static let password = localized(of: "PASSWORD")
  static let contactUs = localized(of: "CONTACT_US")
  static let welcomeLabel = localized(of: "WELCOME_LABEL")
  static let resetPassword = localized(of: "RESET_PASSWORD")
}
