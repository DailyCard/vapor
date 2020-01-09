//
//  RequestNotificationRootView.swift
//  Boxue_iOS
//
//  Created by Mars on 2018/11/29.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit
import RxSwift
import PromiseKit
import UserNotifications

import BoxueUIKit
import BoxueDataKit

public class RequestNotificationRootView: NiblessView {
  /// - Properties
  let bag = DisposeBag()
  var viewNotReady = true
  let viewModel: NotificationViewModel
  
  /// - Methods
  public init(frame: CGRect = .zero, viewModel: NotificationViewModel) {
    self.viewModel = viewModel
    super.init(frame: frame)
    
    bindInteraction()
  }
  
  let notificationBg: UIImageView = {
    let imageView = UIImageView(
      image: UIImage(named: "request-notification-bg"))
    imageView.contentMode = .scaleAspectFill
    
    return imageView
  }()
  
  let notificationIcon: UIImageView = {
    let imageView = UIImageView(
      image: UIImage(named: "notification-icon"))
    imageView.contentMode = .scaleAspectFill
    imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
    
    return imageView
  }()
  
  let enableTitle: UILabel = {
    let label = UILabel()
    label.text = .requestNotificationTitle
    label.numberOfLines = 0
    label.textColor = .white
    label.textAlignment = .center
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = UIFont.preferredFont(forTextStyle: .largeTitle).bold()
  
    return label
  }()

  let enableDesc: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textAlignment = .center
    label.textColor = Color.blueGreen
    label.text = .requestNotificationDesc
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = UIFont.preferredFont(forTextStyle: .headline).bold()
    
    return label
  }()
  
  let enableButton: UIButton = {
    let button = UIButton(type: .system)
    button.layer.cornerRadius = 6
    button.backgroundColor = SystemColor.blue
    button.setTitleColor(.white, for: .normal)
    button.setTitle(.requestNotificationConfirm, for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body).bold()
    
    button.heightAnchor.constraint(equalToConstant: 50).isActive = true
    
    return button
  }()
  
  let notNowButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitleColor(Color.labelBtnYellow, for: .normal)
    button.setTitle(.requestNotificationNotNow, for: .normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
    
    return button
  }()
  
  lazy var buttonStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [enableButton, notNowButton])
    
    sv.spacing = 15
    sv.axis = .vertical
    sv.alignment = .fill
    sv.distribution = .fillEqually
    
    return sv
  }()
  
  /// - Public methods
  public override func didMoveToWindow() {
    super.didMoveToWindow()
    
    guard viewNotReady else { return }
    
    constructViewHierarchy()
    activateConstraints()
    
    viewNotReady = false
  }
  
  func constructViewHierarchy() {
    addSubview(notificationBg)
    addSubview(notificationIcon)
    addSubview(enableTitle)
    addSubview(enableDesc)
    addSubview(buttonStackView)
  }
  
  func activateConstraints() {
    activateConstraintsNotificationBg()
    activateConstraintsNotificationIcon()
    activateConstraintsEnableTitle()
    activateConstraintsEnableDesc()
    activateConstraintsButtonStack()
  }
  
  func activateConstraintsNotificationBg() {
    notificationBg.translatesAutoresizingMaskIntoConstraints = false
    
    let top = notificationBg.topAnchor.constraint(equalTo: self.topAnchor)
    let bottom = notificationBg.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    let leading = notificationBg.leadingAnchor.constraint(equalTo: self.leadingAnchor)
    let trailing = notificationBg.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    
    NSLayoutConstraint.activate([top, bottom, leading, trailing])
  }
  
  func activateConstraintsNotificationIcon() {
    notificationIcon.translatesAutoresizingMaskIntoConstraints = false
    
    let center = notificationIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    let top = notificationIcon.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 66)
    
    NSLayoutConstraint.activate([center, top])
  }
  
  func activateConstraintsEnableTitle() {
    enableTitle.translatesAutoresizingMaskIntoConstraints = false
    
    let top = enableTitle.topAnchor.constraint(equalTo: notificationIcon.bottomAnchor, constant: 26)
    let leading = enableTitle.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor)
    let trailing = enableTitle.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
    
    NSLayoutConstraint.activate([top, leading, trailing])
  }
  
  func activateConstraintsEnableDesc() {
    enableDesc.translatesAutoresizingMaskIntoConstraints = false
    
    let leading = enableDesc.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor)
    let trailing = enableDesc.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
    let bottom = enableDesc.bottomAnchor.constraint(equalTo: self.buttonStackView.topAnchor, constant: -20)
    
    NSLayoutConstraint.activate([leading, trailing, bottom])
  }
  
  func activateConstraintsButtonStack() {
    buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    
    let leading = buttonStackView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor)
    let trailing = buttonStackView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor)
    let bottom = buttonStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -55)
    
    NSLayoutConstraint.activate([leading, trailing, bottom])
  }
}

extension RequestNotificationRootView {
  func requestNotificationAuthorization() {
    let center = UNUserNotificationCenter.current()
    
    center.requestAuthorization(options: [.badge, .alert, .sound])
      .done {
        if $0 {
          UIApplication.shared.registerForRemoteNotifications()
          self.viewModel.enableNotificationTapped()
        }
        else {
          // The first time, user pressed "Don't allow" on the requesting dialog.
          self.viewModel.disableNotificationTapped()
        }
      }
      .catch {
        fatalError($0.localizedDescription)
    }
  }
  
  func bindInteraction() {
    enableButton.rx.tap.bind {
      let center = UNUserNotificationCenter.current()
      
      center.isNotificationPermissionDenied()
        .done {
          if $0 {
            // The later, iOS returns false directly, we should give users a promption and a settings guide.
            self.viewModel.disableNotificationBySystem()
          }
          else {
            self.requestNotificationAuthorization()
          }
        }
    }.disposed(by: bag)
    
    notNowButton.rx.tap.bind {
      self.viewModel.notDeterminedTapped()
    }.disposed(by: bag)
  }
}

extension String {
  static let requestNotificationTitle = localized(of: "REQ_NOTI_TITLE")
  static let requestNotificationDesc = localized(of: "REQ_NOTI_DESC")
  static let requestNotificationConfirm = localized(of: "REQ_NOTI_CONFIRM")
  static let requestNotificationNotNow = localized(of: "REQ_NOTI_NOTNOW")
}


