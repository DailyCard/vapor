//
//  LaunchViewModel.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/15.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation
import RxSwift

public class LaunchViewModel {
  /// - Properties
  // Make this flag as a property enable us to test the methods
  var isFirstLaunch = Flag.isFirstLaunch
  
  let userSessionRepository: UserSessionRepository
  let guideResponder: GuideResponder
  let browseResponder: BrowseResponder
  
  public var logMessages: Observable<LogMessage> {
    return self.logMessagesSubject.asObservable()
  }
  
  private let logMessagesSubject = PublishSubject<LogMessage>()
  
  /// - Initializers
  public init(userSessionRepository: UserSessionRepository,
              guideResponder: GuideResponder,
              browseResponder: BrowseResponder) {
    self.userSessionRepository = userSessionRepository
    self.guideResponder = guideResponder
    self.browseResponder = browseResponder
    
    if isFirstLaunch {
      userSessionRepository.clearUserSession()
    }
  }
  
  /// - Methods
  public func goToNextScreen() {
    isFirstLaunch ? guideResponder.guide() : browseResponder.browse()
  }
}
