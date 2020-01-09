//
//  RequestNotificationViewController.swift
//  Boxue_iOS
//
//  Created by Mars on 2018/11/29.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit

import RxSwift

import BoxueUIKit
import BoxueDataKit

public class RequestNotificationViewController: NiblessViewController {
  let viewModel: NotificationViewModel
  let bag = DisposeBag()
  
  public init(factory: NotificationViewModelFactory) {
    self.viewModel = factory.makeNotificationViewModel()
    super.init()
  }
  
  public override func loadView() {
    self.view = RequestNotificationRootView(viewModel: viewModel)
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    observeDisableNotificationBySystem()
  }
  
  func observeDisableNotificationBySystem() {
    viewModel.systemDisabledPermission
      .asDriver { _ in fatalError("Unexpected error from system disabled permission observable.") }
      .drive(onNext: { [weak self] errorMessage in
        self?.presentSettingAlert(
          title: "Notification disabled",
          message: "You can enable the notification in Settings.",
          confirmButtonText: "OK",
          cancelButtonText: "Cancel",
          cancelHandler: { _ in self?.viewModel.disableNotificationTapped() })
      })
      .disposed(by: bag)
  }
}

public protocol NotificationViewModelFactory {
  func makeNotificationViewModel() -> NotificationViewModel
}
