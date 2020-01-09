//
//  UIViewController+Ex.swift
//  BoxueUIKit
//
//  Created by Mars on 2018/10/14.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit
import SwiftUI
import BoxueDataKit

extension UIViewController {
  public func addFullScreen(childViewController child: UIViewController) {
    guard child.parent == nil else { return }
    
    addChild(child)
    view.addSubview(child.view)
    child.view.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      view.leadingAnchor.constraint(equalTo: child.view.leadingAnchor),
      view.trailingAnchor.constraint(equalTo: child.view.trailingAnchor),
      view.topAnchor.constraint(equalTo: child.view.topAnchor),
      view.bottomAnchor.constraint(equalTo: child.view.bottomAnchor)
    ].compactMap {$0})
    
    child.didMove(toParent: self)
  }
  
  public func remove(childViewController child: UIViewController) {
    guard child.parent != nil else { return }
    
    child.willMove(toParent: nil)
    child.view.removeFromSuperview()
    child.removeFromParent()
  }
}

extension UIViewController {
  public func present(errorMessage: ErrorMessage) {
    let alertController = UIAlertController(
      title: errorMessage.title,
      message: errorMessage.description,
      preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: "OK", style: .default)
    alertController.addAction(okAction)
    
    present(alertController, animated: true, completion: nil)
  }
  
  public func presentSettingAlert(
    title: String,
    message: String,
    confirmButtonText: String,
    cancelButtonText: String,
    cancelHandler: ((UIAlertAction) -> Void)? = nil) {
    let alertController = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert)
    
    let okAction = UIAlertAction(title: confirmButtonText, style: .default, handler: {
      _ in UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
    })
    let cancelAction = UIAlertAction(title: cancelButtonText, style: .default, handler: cancelHandler)
    
    alertController.addAction(okAction)
    alertController.addAction(cancelAction)
    
    present(alertController, animated: true, completion: nil)
  }
}

public struct ViewControllerHolder {
  weak var value: UIViewController?
}

struct ViewControllerKey: EnvironmentKey {
  static var defaultValue: ViewControllerHolder {
    return ViewControllerHolder(value: UIApplication.shared.windows.first?.rootViewController )
  }
}

public extension EnvironmentValues {
  var viewController: UIViewController? {
    get { return self[ViewControllerKey.self].value }
    set { self[ViewControllerKey.self].value = newValue }
  }
}

public extension UIViewController {
  func present<Content: View>(style: UIModalPresentationStyle = .automatic, @ViewBuilder builder: () -> Content) {
    let toPresent = UIHostingController(rootView: AnyView(EmptyView()))
    toPresent.modalPresentationStyle = style
    
    toPresent.rootView = AnyView(
      builder()
        .environment(\.viewController, toPresent)
    )
    
    let transition = CATransition()
    transition.duration = 0.4
    transition.type = CATransitionType.push
    transition.subtype = CATransitionSubtype.fromRight
    transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
    view.window!.layer.add(transition, forKey: kCATransition)
    
    self.present(toPresent, animated: true, completion: nil)
  }
}
