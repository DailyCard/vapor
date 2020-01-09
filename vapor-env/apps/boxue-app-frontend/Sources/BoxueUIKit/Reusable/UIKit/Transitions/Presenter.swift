//
//  Popup.swift
//  BoxueUIKit
//
//  Created by Mars on 2019/8/30.
//  Copyright © 2019 Mars. All rights reserved.
//

import UIKit

public class Presenter: NSObject,  UIViewControllerAnimatedTransitioning {
  let duration = 0.4
  
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let container = transitionContext.containerView
    let toView = transitionContext.view(forKey: .to)! as! CustomAlertRootView
    toView.translatesAutoresizingMaskIntoConstraints = false
    container.addSubview(toView)
    container.bringSubviewToFront(toView)
    
    let top = container.topAnchor.constraint(equalTo: toView.topAnchor)
    let leading = container.leadingAnchor.constraint(equalTo: toView.leadingAnchor)
    let trailing = container.trailingAnchor.constraint(equalTo: toView.trailingAnchor)
    let bottom = container.bottomAnchor.constraint(equalTo: toView.bottomAnchor)
    
    NSLayoutConstraint.activate([top, leading, trailing, bottom])
    
    container.layoutIfNeeded()
    
    toView.alertContainer.transform = CGAffineTransform(scaleX: 0, y: 0)
    
    UIView.animate(
      withDuration: duration,
      delay: 0.0,
      usingSpringWithDamping: 0.6,
      initialSpringVelocity: 0,
      options: [.curveEaseOut],
      animations: {
        toView.alertContainer.transform = CGAffineTransform(scaleX: 1, y: 1)
      },
      completion: { _ in
        transitionContext.completeTransition(true)
      })
  }
}
