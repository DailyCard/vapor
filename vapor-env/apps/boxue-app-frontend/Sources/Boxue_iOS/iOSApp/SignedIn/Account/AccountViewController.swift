//
//  AccountViewController.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/7.
//  Copyright © 2019 Mars. All rights reserved.
//

import Foundation
import BoxueUIKit
import BoxueDataKit
import BXAnimatedTabBar

public class AccountViewController: NiblessViewController {
  //MARK: attributes
  let userSessionRepository: UserSessionRepository
  let viewModel: AccountViewModel
  
  //MARK: Methods
  public init(
    userSessionRepository: UserSessionRepository,
    viewModelFactory: AccountViewModelFactory) {
    self.userSessionRepository = userSessionRepository
    self.viewModel = viewModelFactory.makeAccountViewModel()
    super.init()
    
    let accountTabBarItem = BXAnimatedTabBarItem(
      title: .accountTabLabel,
      image: UIImage(systemName: "person.crop.circle.fill"),
      tag: 0)
    accountTabBarItem.animation = BXRotationItemAnimation()
    tabBarItem = accountTabBarItem
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = SystemColor.green
  }
}

public protocol AccountViewModelFactory {
  func makeAccountViewModel() -> AccountViewModel
}

extension String {
  static let accountTabLabel = localized(of: "ACCOUNT_TAB_LABEL")
}
