//
//  CustomAlertView.swift
//  BoxueUIKit
//
//  Created by Mars on 2019/8/28.
//  Copyright © 2019 Mars. All rights reserved.
//

import UIKit
import SwiftUI

public final class CustomAlertViewController: NiblessViewController {
  let icon: UIImage
  let titleLabel: String
  let detailLabel: String
  let buttonText: String
  
  let presenter = Presenter()
  let dimisser = Dismisser()
  
  public var okAction: (() -> Void)?
  
  public init(icon: UIImage, titleLabel: String, detailLabel: String, buttonText: String) {
    self.icon = icon
    self.titleLabel = titleLabel
    self.detailLabel = detailLabel
    self.buttonText = buttonText
    
    super.init()
    
    transitioningDelegate = self
    modalPresentationStyle = .overFullScreen
  }
  
  public override func loadView() {
    view = CustomAlertRootView(icon: icon, titleLabel: titleLabel, detailLabel: detailLabel, buttonText: buttonText)
    
    (view as! CustomAlertRootView).button.addTarget(
      self,
      action: #selector(CustomAlertViewController.okTapped),
      for: .touchUpInside)
  }
}

extension CustomAlertViewController {
  @objc func okTapped() {
    dismiss(animated: true)
    okAction?()
  }
}

extension CustomAlertViewController: UIViewControllerTransitioningDelegate {
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

