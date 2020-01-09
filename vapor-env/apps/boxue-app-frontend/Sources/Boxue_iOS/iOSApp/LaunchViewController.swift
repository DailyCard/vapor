//
//  LaunchViewController.swift
//  Boxue_iOS
//
//  Created by Mars on 2018/10/4.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit
import RxSwift
import BoxueUIKit
import BoxueDataKit

public class LaunchViewController: NiblessViewController {
  let viewModel: LaunchViewModel
  let bag: DisposeBag = DisposeBag()
  
  /// - Methods
  init(launchViewModelFactory: LaunchViewModelFactory) {
    self.viewModel = launchViewModelFactory.makeLaunchViewModel()
    super.init()
  }

  public override func loadView() {
    self.view = LaunchRootView(viewModel: viewModel)
  }
  
  public override func viewDidAppear(_ animated: Bool) {
    viewModel.goToNextScreen()
  }
}

protocol LaunchViewModelFactory {
  func makeLaunchViewModel() -> LaunchViewModel
}
