//
//  BlackboardViewController.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/7.
//  Copyright © 2019 Mars. All rights reserved.
//

import Foundation
import BoxueUIKit
import BoxueDataKit
import BXAnimatedTabBar

public class BlackboardViewController: NiblessViewController {
  //MARK: attributes
  let userSessionRepository: UserSessionRepository
  let viewModel: BlackboardViewModel
  
  /// - Methods
  public init(
    userSessionRepository: UserSessionRepository,
    viewModelFactory: BlackboardViewModelFactory) {
    self.userSessionRepository = userSessionRepository
    self.viewModel = viewModelFactory.makeBlackboardViewModel()
    super.init()
    
    let blackboardTabBarItem = BXAnimatedTabBarItem(
      title: .blackboardTabLabel,
      image: UIImage(systemName: "pencil.and.outline"),
      tag: 0)
    blackboardTabBarItem.animation = BXFlipLeftTransitionItemAnimation()
    tabBarItem = blackboardTabBarItem
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = SystemColor.orange
  }
}

public protocol BlackboardViewModelFactory {
  func makeBlackboardViewModel() -> BlackboardViewModel
}

extension String {
  static let blackboardTabLabel = localized(of: "BLACKBOARD_TAB_LABEL")
}
