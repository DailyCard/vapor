//
//  WelcomeViewController.swift
//  Boxue_iOS
//
//  Created by Mars on 2018/10/4.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit
import UserNotifications

import RxSwift

import BoxueUIKit
import BoxueDataKit

public class WelcomeViewController: NiblessViewController {
  /// - Properties
  let bag = DisposeBag()
  let welcomeViewModelFactory: WelcomeViewModelFactory
  
  /// - Methods:
  init(welcomeViewModelFactory: WelcomeViewModelFactory) {
    self.welcomeViewModelFactory = welcomeViewModelFactory
    super.init()
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.cyan
    // Do any additional setup after loading the view.
  }
  
  public override func loadView() {
    let vm = welcomeViewModelFactory.makeWelcomeViewModel()
    view = WelcomeRootView(viewModel: vm)
    
    vm.requestProvisionalNotification
      .asDriver { _ in fatalError("Unexpected error from request provisional notification.") }
      .drive(onNext: self.requestProvisionalAuthorization)
      .disposed(by: bag)
  }
  
  func requestProvisionalAuthorization() {
    UNUserNotificationCenter.current()
      .requestAuthorization(options: [.badge, .alert, .sound, .provisional])
      .catch { fatalError($0.localizedDescription) }
  }
}

protocol WelcomeViewModelFactory {
  func makeWelcomeViewModel() -> WelcomeViewModel
}
