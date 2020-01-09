//
//  BoxueAppDependencyContainer.swift
//  Boxue_iOS
//
//  Created by Mars on 2018/10/15.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit
import RxSwift
import BoxueDataKit

public class BoxueAppDependencyContainer {
  let sharedMainViewModel: MainViewModel
  let sharedUserSessionRepository: BoxueUserSessionRepository
  
  public init() {
    func makeAuthRemoteAPI() -> AuthRemoteAPI {
      #if TEST
      return BoxueAuthRemoteAPI.default
      #else
      return BoxueAuthRemoteAPI.default
      #endif
    }
    
    func makeUserProfileStore() -> UserProfileStore {
      #if TEST
      return FakeUserProfileStore()
      #else
      return KeychainBasedUserProfileStore.default
      #endif
    }
    
    func makeRemoteUserSessionStore() -> RemoteUserSessionStore {
      return KeychainBasedRemoteUserSessionStore()
    }
    
    func makeUserSessionRepository() -> BoxueUserSessionRepository {
      return BoxueUserSessionRepository(
        authRemoteAPI: makeAuthRemoteAPI(),
        userProfileStore: makeUserProfileStore(),
        remoteUserSessionStore: makeRemoteUserSessionStore())
    }
    
    func makeMainViewModel() -> MainViewModel {
      return MainViewModel()
    }
    
    self.sharedMainViewModel = makeMainViewModel()
    self.sharedUserSessionRepository = makeUserSessionRepository()
  }
  
  public func makeMainViewController() -> MainViewController {
    let launchViewController = makeLaunchViewController()
    let guideViewControllerFactory = {
      return self.makeGuideViewController()
    }
    let browseViewControllerFactory = {
      return self.makeBrowseViewController()
    }
    
    return MainViewController(viewModel: sharedMainViewModel,
                              launchViewController: launchViewController,
                              guideViewControllerFactory: guideViewControllerFactory,
                              browseViewControllerFactory: browseViewControllerFactory)
  }
  
  public func makeLaunchViewController() -> LaunchViewController {
    return LaunchViewController(launchViewModelFactory: self)
  }
  
  public func makeGuideViewController() -> GuideViewController {
    let di = BoxueGuideDependencyContainer(appDependencyContainer: self)
    return di.makeGuideViewController()
  }
  
  /// Signed In
  public func makeSignedInDependencyContainer() -> BoxueSignedInDependencyContainer {
    return BoxueSignedInDependencyContainer(appDependencyContainer: self)
  }

  public func makeBrowseViewController() -> BrowseViewController {
    let dp = makeSignedInDependencyContainer()
    return dp.makeBrowseViewController()
  }
}

extension BoxueAppDependencyContainer: LaunchViewModelFactory {
  public func makeLaunchViewModel() -> LaunchViewModel {
    return LaunchViewModel(userSessionRepository: sharedUserSessionRepository,
                           guideResponder: sharedMainViewModel,
                           browseResponder: sharedMainViewModel)
  }
}
