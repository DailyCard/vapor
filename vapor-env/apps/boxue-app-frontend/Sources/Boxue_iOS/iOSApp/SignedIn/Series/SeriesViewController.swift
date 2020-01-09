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

public class SeriesViewController: NiblessViewController {
  //MARK: attributes
  let userSessionRepository: UserSessionRepository
  let viewModel: SeriesViewModel
  
  //MARK: methods
  public init(
    userSessionRepository: UserSessionRepository,
    viewModelFactory: SeriesViewModelFactory) {
    self.userSessionRepository = userSessionRepository
    self.viewModel = viewModelFactory.makeSeriesViewModel()
    super.init()
    
    let seriesTabBarItem = BXAnimatedTabBarItem(
      title: .seriesTabLabel,
      image: UIImage(systemName: "map.fill"),
      tag: 0)
    seriesTabBarItem.animation = BXBounceItemAnimation()
    tabBarItem = seriesTabBarItem
  }
  
  override public func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = SystemColor.purple
  }
}

public protocol SeriesViewModelFactory {
  func makeSeriesViewModel() -> SeriesViewModel
}

extension String {
  static let seriesTabLabel = localized(of: "SERIES_TAB_LABEL")
}
