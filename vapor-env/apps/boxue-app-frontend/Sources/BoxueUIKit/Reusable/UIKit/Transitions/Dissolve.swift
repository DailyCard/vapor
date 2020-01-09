//
//  Dissolve.swift
//  BoxueUIKit
//
//  Created by Mars on 2019/1/23.
//  Copyright © 2019 Mars. All rights reserved.
//

import UIKit

public class DissolveAnimator: NSObject,  UIViewControllerAnimatedTransitioning {
  let duration = 1.0
  
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView
    let toView = transitionContext.view(forKey: .to)!
    
    containerView.addSubview(toView)
    toView.alpha = 0.0
    UIView.animate(
      withDuration: duration,
      animations: {
        toView.alpha = 1.0
      },
      completion: { _ in
        transitionContext.completeTransition(true)
      })
  }
}
