//
//  HomeViewController.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/7.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI
import Foundation
import BoxueUIKit
import BoxueDataKit
import BXAnimatedTabBar

public class HomeViewController: NiblessViewController {
  // MARK: - attributes
  let userSessionRepository: UserSessionRepository
  let viewModel: HomeViewModel
  let hostVC: UIHostingController<Home>
  
  // MARK: - Initializers
  public init(
    userSessionRepository: UserSessionRepository,
    viewModelFactory: HomeViewModelFactory) {
    self.userSessionRepository = userSessionRepository
    self.viewModel = viewModelFactory.makeHomeViewModel()
    self.hostVC = UIHostingController<Home>(rootView: Home(viewModel: viewModel))
    
    super.init()
    
    let homeTabBarItem = BXAnimatedTabBarItem(
      title: .localized(of: .homeTabLabel),
      image: UIImage(systemName: "house.fill"),
      tag: 0)
    homeTabBarItem.animation = BXBounceItemAnimation()
    tabBarItem = homeTabBarItem
  }
  
  // MARK: - Methods
  public override func loadView() {
    self.view = UIView()
    addFullScreen(childViewController: hostVC)
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = SystemColor.tealBlue
  }
}

public protocol HomeViewModelFactory {
  func makeHomeViewModel() -> HomeViewModel
}

extension String {
  static let homeTabLabel = localized(of: "HOME_TAB_LABEL")
}
