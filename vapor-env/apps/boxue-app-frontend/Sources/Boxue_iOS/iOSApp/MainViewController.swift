//
//  ViewController.swift
//  Boxue
//
//  Created by Mars on 2018/10/4.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit
import RxSwift
import BoxueUIKit
import BoxueDataKit

public class MainViewController: NiblessViewController {
  /// - Properties
  /// View Model
  let viewModel: MainViewModel
  
  /// Transition
  let dissolveTransition: DissolveAnimator
  
  /// Child View Controllers
  let launchViewController: LaunchViewController
  var guideViewController: GuideViewController?
  var browseViewController: BrowseViewController?
  
  /// State
  let isFirstLaunch = Flag.isFirstLaunch
  let disposeBag = DisposeBag()
  
  /// Factories
  let makeGuideViewController: () -> GuideViewController
  let makeBrowseViewController: () -> BrowseViewController
  
  /// - Methods
  public init(viewModel: MainViewModel,
    launchViewController: LaunchViewController,
    guideViewControllerFactory: @escaping () -> GuideViewController,
    browseViewControllerFactory: @escaping () -> BrowseViewController) {
    self.viewModel = viewModel
    self.dissolveTransition = DissolveAnimator()
    self.launchViewController = launchViewController
    self.makeGuideViewController = guideViewControllerFactory
    self.makeBrowseViewController = browseViewControllerFactory
    
    super.init()
  }
  
  public override func loadView() {
    self.view = MainRootView()
  }
  
  public override func viewDidAppear(_ animated: Bool) {
    observeViewModel()
    super.viewDidAppear(animated)
  }
  
  private func observeViewModel() {
    let observable = self.viewModel.viewStatus.distinctUntilChanged()
    subscribe(to: observable)
  }
  
  func subscribe(to observable: Observable<MainViewStatus>) {
    observable.subscribe(onNext: {
      [weak self] status in
      guard let `self` = self else { return }
      self.present(status)
    }).disposed(by: disposeBag)
  }
  
  public func present(_ viewStatus: MainViewStatus) {
    switch viewStatus {
    case .launching:
      presentLaunching()
    case .guiding:
      presentGuiding()
    case .browsing:
      presentBrowsing()
    }
  }
  
  public func presentLaunching() {
    addFullScreen(childViewController: launchViewController)
  }
  
  public func presentGuiding() {
    let guideViewController = makeGuideViewController()
    
    guideViewController.transitioningDelegate = self
    guideViewController.modalPresentationStyle = .fullScreen

    present(guideViewController, animated: true) {
      [weak self] in
      guard let `self` = self else { return }

      self.remove(childViewController: self.launchViewController)
    }

    self.guideViewController = guideViewController
  }
  
  public func presentBrowsing() {
    remove(childViewController: launchViewController)
    
    let browseViewControllerPresented: BrowseViewController
    
    if let vc = self.browseViewController {
      browseViewControllerPresented = vc
    }
    else {
      browseViewControllerPresented = makeBrowseViewController()
      self.browseViewController = browseViewControllerPresented
    }
    
    addFullScreen(childViewController: browseViewControllerPresented)
    
    if guideViewController?.presentingViewController != nil {
      guideViewController = nil
      dismiss(animated: true)
    }
  }
}

extension MainViewController: UIViewControllerTransitioningDelegate {
  public func animationController(forPresented presented: UIViewController,
                           presenting: UIViewController,
                           source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return dissolveTransition
  }
}

class GenericError: Error {
  
}
