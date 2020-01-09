//
//  MainViewModel.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/4.
//  Copyright © 2018 Mars. All rights reserved.
//

import RxSwift
import Foundation

public class MainViewModel: GuideResponder, BrowseResponder {
  /// - Properties
  public var viewStatus: Observable<MainViewStatus> {
    return viewSubject.asObservable()
  }
  
  private let viewSubject = BehaviorSubject<MainViewStatus>(value: .launching)
  
  /// - Methods
  public init() {}
  
  public func guide() {
    viewSubject.onNext(.guiding)
  }
  
  public func browse() {
    viewSubject.onNext(.browsing)
  }
}
