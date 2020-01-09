//
//  Dismiss.swift
//  BoxueUIKit
//
//  Created by Mars on 2019/8/30.
//  Copyright © 2019 Mars. All rights reserved.
//

import UIKit

public class Dismisser: NSObject,  UIViewControllerAnimatedTransitioning {
  let duration = 0.2
  
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let container = transitionContext.containerView
    let fromView = transitionContext.view(forKey: .from)! as! CustomAlertRootView
    fromView.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(fromView)
    container.bringSubviewToFront(fromView)
    
    let top = container.topAnchor.constraint(equalTo: fromView.topAnchor)
    let leading = container.leadingAnchor.constraint(equalTo: fromView.leadingAnchor)
    let trailing = container.trailingAnchor.constraint(equalTo: fromView.trailingAnchor)
    let bottom = container.bottomAnchor.constraint(equalTo: fromView.bottomAnchor)
    
    NSLayoutConstraint.activate([top, leading, trailing, bottom])

    container.layoutIfNeeded()
    
    UIView.animate(
      withDuration: duration,
      animations: {
        fromView.alpha = 0
      },
      completion: { _ in
        transitionContext.completeTransition(true)
      })
  }
}
