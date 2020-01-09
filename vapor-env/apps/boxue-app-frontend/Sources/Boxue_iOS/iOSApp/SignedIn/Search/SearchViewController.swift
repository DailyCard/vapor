//
//  SearchViewController.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/9/7.
//  Copyright © 2019 Mars. All rights reserved.
//

import Foundation
import BoxueUIKit
import BoxueDataKit
import BXAnimatedTabBar

public class SearchViewController: NiblessViewController {
  //MARK: attributes
  let viewModel: SearchViewModel
  
  //MARK: - Methods
  public init(viewModelFactory: SearchViewModelFactory) {
    self.viewModel = viewModelFactory.makeSearchViewModel()
    super.init()
    
    let searchTabBarItem = BXAnimatedTabBarItem(
      title: .searchTabLabel,
      image: UIImage(systemName: "magnifyingglass"),
      tag: 0)
    searchTabBarItem.animation = BXFlipRightTransitionItemAnimation()
    tabBarItem = searchTabBarItem
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = SystemColor.pink
  }
}

public protocol SearchViewModelFactory {
  func makeSearchViewModel() -> SearchViewModel
}

extension String {
  static let searchTabLabel = localized(of: "SEARCH_TAB_LABEL")
}
