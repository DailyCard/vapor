//
//  CommonTest.swift
//  BoxueUnitTests
//
//  Created by Mars on 2019/1/24.
//  Copyright © 2019 Mars. All rights reserved.
//

import XCTest
import RxTest
import RxSwift
import PromiseKit
import Foundation

@testable import Boxue_iOS
@testable import BoxueDataKit

class CommonTests: XCTestCase {
  typealias Criteria<T> = ([Recorded<Event<T>>], [Recorded<Event<T>>], StaticString, UInt) -> Void
  
  /// - Properties
  var disposeBag: DisposeBag!
  var scheduler: TestScheduler!
  
  // Containers
  var appContainer: BoxueAppDependencyContainer!
  var guideContainer: BoxueGuideDependencyContainer!
  
  // Models
  var mainViewModel: MainViewModel!
  
  /// - Methods
  override func setUp() {
    disposeBag = DisposeBag()
    scheduler = TestScheduler(initialClock: 0)
    appContainer = BoxueAppDependencyContainer()
    guideContainer = BoxueGuideDependencyContainer(appDependencyContainer: appContainer)
    mainViewModel = appContainer.sharedMainViewModel
    
    super.setUp()
  }
  
  override func tearDown() {
    appContainer = nil
    guideContainer = nil
    mainViewModel = nil
    
    super.tearDown()
  }
  
  /// - Methods
  func t<T: Equatable>(
    source: Observable<T>,
    expected: [Recorded<Event<T>>],
    process: @escaping () -> Void) {
    /// 1. Create the recorder and bind it to the source observable
    let recorder = scheduler.createObserver(T.self)
    source.bind(to: recorder).disposed(by: disposeBag)
    
    /// 2. Make a `(0, Void)` event to trigger the tested `process`
    scheduler.createColdObservable([.next(0, ())])
      .subscribe(onNext: {
        process()
      })
      .disposed(by: disposeBag)
    
    scheduler.start()
    
    /// 3. Compare the result
    XCTAssertEqual(recorder.events, expected)
  }
  
  /// In `t_c`, `T` need not to be `Equatable`. We just count the
  /// number of events, not events themselves.
  func t_c<T>(
    source: Observable<T>,
    expected: Int,
    process: @escaping () -> Void) {
    /// 1. Create the recorder and bind it to the source observable
    let recorder = scheduler.createObserver(T.self)
    source.bind(to: recorder).disposed(by: disposeBag)
    
    /// 2. Make a `(0, Void)` event to trigger the tested `process`
    scheduler.createColdObservable([.next(0, ())])
      .subscribe(onNext: {
        process()
      })
      .disposed(by: disposeBag)
    
    scheduler.start()
    
    /// 3. Compare the result
    XCTAssertEqual(recorder.events.count, expected)
  }
}
