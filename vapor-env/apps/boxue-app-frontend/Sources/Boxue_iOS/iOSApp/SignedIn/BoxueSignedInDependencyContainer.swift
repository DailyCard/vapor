//
//  BoxueSignedInDependencyContainer.swift
//  Boxue_iOS
//
//  Created by Mars on 2018/12/29.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit
import BoxueUIKit
import BoxueDataKit

public class BoxueSignedInDependencyContainer {
  // MARK: - Properties
  // From parent container
  let sharedUserSessionRepository: UserSessionRepository
  
  // MARK: - Methods
  public init(appDependencyContainer: BoxueAppDependencyContainer) {
    sharedUserSessionRepository = appDependencyContainer.sharedUserSessionRepository
  }
  
  public func makeBrowseViewController() -> BrowseViewController {
    return BrowseViewController(
      homeVC: makeHomeViewController(),
      searchVC: makeSearchViewController(),
      seriesVC: makeSeriesViewController(),
      blackboardVC: makeBlackboardViewController(),
      accountVC: makeAccountViewController())
  }
  
  public func makeHomeViewController() -> HomeViewController {
    return HomeViewController(
      userSessionRepository: sharedUserSessionRepository, viewModelFactory: self)
  }
  
  public func makeSearchViewController() -> SearchViewController {
    return SearchViewController(viewModelFactory: self)
  }
  
  public func makeSeriesViewController() -> SeriesViewController {
    return SeriesViewController(
      userSessionRepository: sharedUserSessionRepository, viewModelFactory: self)
  }
  
  public func makeBlackboardViewController() -> BlackboardViewController {
    return BlackboardViewController(
      userSessionRepository: sharedUserSessionRepository, viewModelFactory: self)
  }
  
  public func makeAccountViewController() -> AccountViewController {
    return AccountViewController(
      userSessionRepository: sharedUserSessionRepository, viewModelFactory: self)
  }
}

// MARK: - Extensions
extension BoxueSignedInDependencyContainer: HomeViewModelFactory {
  public func makeHomeViewModel() -> HomeViewModel {
    return HomeViewModel(userSessionRepository: sharedUserSessionRepository)
  }
}

extension BoxueSignedInDependencyContainer: SearchViewModelFactory {
  public func makeSearchViewModel() -> SearchViewModel {
    return SearchViewModel()
  }
}

extension BoxueSignedInDependencyContainer: SeriesViewModelFactory {
  public func makeSeriesViewModel() -> SeriesViewModel {
    return SeriesViewModel()
  }
}

extension BoxueSignedInDependencyContainer: BlackboardViewModelFactory {
  public func makeBlackboardViewModel() -> BlackboardViewModel {
    return BlackboardViewModel()
  }
}

extension BoxueSignedInDependencyContainer: AccountViewModelFactory {
  public func makeAccountViewModel() -> AccountViewModel {
    return AccountViewModel()
  }
}
