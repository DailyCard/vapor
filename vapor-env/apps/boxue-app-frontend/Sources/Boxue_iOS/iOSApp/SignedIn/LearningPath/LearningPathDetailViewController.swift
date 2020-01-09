//
//  LearningPathDetailViewController.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/10/16.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftUI
import Foundation
import BoxueUIKit
import BoxueDataKit
import BXAnimatedTabBar

public class LearningPathDetailViewController: NiblessViewController {
  let hostVC: UIHostingController<LearningPathDetail>
  
  let presenter = Presenter()
  let dimisser = Dismisser()
  
  // MARK: Methods
  public override init() {
    self.hostVC = UIHostingController<LearningPathDetail>(rootView: LearningPathDetail())
    super.init()
    
    transitioningDelegate = self
  }
  
  public override func loadView() {
    self.view = UIView()
    addFullScreen(childViewController: hostVC)
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = SystemColor.tealBlue
  }
}

extension LearningPathDetailViewController: UIViewControllerTransitioningDelegate {
  public func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return presenter
  }
  
  public func animationController(
    forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return dimisser
  }
}
