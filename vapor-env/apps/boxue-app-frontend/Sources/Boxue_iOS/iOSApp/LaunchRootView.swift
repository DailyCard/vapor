//
//  LaunchRootView.swift
//  Boxue_iOS
//
//  Created by Mars on 2018/10/14.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit
import BoxueUIKit
import BoxueDataKit

public class LaunchRootView: LaunchAndWelcomeView {
  /// - Properties
  let viewModel: LaunchViewModel
  
  /// - Initializers
  init(frame: CGRect = .zero, viewModel: LaunchViewModel) {
    self.viewModel = viewModel
    super.init(frame: frame)
  }
}
