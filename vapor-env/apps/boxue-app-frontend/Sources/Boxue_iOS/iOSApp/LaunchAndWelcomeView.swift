//
//  LaunchAndWelcomeView.swift
//  Boxue_iOS
//
//  Created by Mars on 2018/11/25.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit
import BoxueUIKit

public class LaunchAndWelcomeView: NiblessView {
  /// - Constants
  static let APP_TITLE_WIDTH: CGFloat = 300.0
  static let APP_TITLE_HEIGHT: CGFloat = 90.0

  /// - Properties
  var viewNotReady = true
  
  let bgImage: UIImageView = {
    let imageView = UIImageView(image: UIImage(named: "LaunchScreen_iPhoneX_dark"))
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = .systemBackground
    
    return imageView
  }()
  
  let appTitleView: UIView = {
    let frame = CGRect(x: 0, y: 0,
                       width: LaunchRootView.APP_TITLE_WIDTH,
                       height: LaunchRootView.APP_TITLE_HEIGHT)
    let view = UIView(frame: frame)
    let gradient = CAGradientLayer()
    
    gradient.frame = view.bounds
    gradient.startPoint = CGPoint(x: 0, y: 0)
    gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
    gradient.colors = [
      Color.appTitleGradientBegin.cgColor,
      Color.appTitleGradientMid.cgColor,
      Color.appTitleGradientEnd.cgColor]
    view.layer.addSublayer(gradient)
    
    let label = UILabel(frame: view.bounds)
    label.text = .appTitle
    label.numberOfLines = 0
    label.textAlignment = .center
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = UIFont.preferredFont(forTextStyle: .largeTitle).bold()
    
    view.addSubview(label)
    view.mask = label
    
    return view
  }()
  
  let appSlogan: UILabel = {
    let label = UILabel()
    label.text = .appSlogan
    label.numberOfLines = 0
    label.textColor = .white
    label.textAlignment = .center
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = UIFont.preferredFont(forTextStyle: .headline).bold()
    
    return label
  }()
  
  let rightsInfo: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.text = .rightsInfo
    label.textAlignment = .center
    label.textColor = .systemGray
    label.lineBreakMode = NSLineBreakMode.byWordWrapping
    label.font = UIFont.preferredFont(forTextStyle: .footnote)
    
    return label
  }()
  
  /// - Public methods
  public override func didMoveToWindow() {
    super.didMoveToWindow()
    
    guard viewNotReady else { return }
    
    constructViewHierarchy()
    activateConstraints()
    
    viewNotReady = false
  }
  
  /// - Internal methods
  func constructViewHierarchy() {
    addSubview(bgImage)
    addSubview(appTitleView)
    addSubview(appSlogan)
    addSubview(rightsInfo)
  }
  
  func activateConstraints() {
    activateConstraintsBGImage()
    activateConstraintsAppTitle()
    activateConstraintsAppSlogan()
    activateConstraintsRightsInfo()
  }
  
  func activateConstraintsBGImage() {
    bgImage.translatesAutoresizingMaskIntoConstraints = false
    
    /**
     +--------------+
     |self  0       |
     |  +--------+  |
     |  |        |  |
     |  |        |  |
     | 0|bgImage |0 |
     |  |        |  |
     |  |        |  |
     |  +--------+  |
     |      0       |
     +--------------+
     */
    let top = bgImage.topAnchor.constraint(equalTo: self.topAnchor)
    let bottom = bgImage.bottomAnchor.constraint(equalTo: self.bottomAnchor)
    let leading = bgImage.leadingAnchor.constraint(equalTo: self.leadingAnchor)
    let trailing = bgImage.trailingAnchor.constraint(equalTo: self.trailingAnchor)
    
    NSLayoutConstraint.activate([top, bottom, leading, trailing])
  }
  
  func activateConstraintsAppTitle() {
    appTitleView.translatesAutoresizingMaskIntoConstraints = false
    
    /**
     +--------------------------------------+
     |self         140 xCenter              |
     |    +----------------------------+    |
     |    | appTitleView         ^     |    |
     |    |                      |     |    |
     |    |<---------- 300 ------90--->|    |
     |    |                      |     |    |
     |    |                      v     |    |
     |    +----------------------------+    |
     |                                      |
     +--------------------------------------+
     */
    let hCenter = appTitleView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    let top = appTitleView.topAnchor.constraint(equalTo: self.topAnchor, constant: 140)
    let width = appTitleView.widthAnchor.constraint(equalToConstant: LaunchRootView.APP_TITLE_WIDTH)
    let height = appTitleView.heightAnchor.constraint(equalToConstant: LaunchRootView.APP_TITLE_HEIGHT)
    
    NSLayoutConstraint.activate([hCenter, top, width, height])
  }
  
  func activateConstraintsAppSlogan() {
    appSlogan.translatesAutoresizingMaskIntoConstraints = false
    
    /**
     +--------------------------------------+
     |self                                  |
     |    +----------------------------+    |
     |    | appTitleView               |    |
     |    +----------------------------+    |
     |             40 xCenter               |
     |    +----------------------------+    |
     |    | appSlogan                  |    |
     |    |<---------- 300 ----------->|    |
     |    +----------------------------+    |
     |                                      |
     +--------------------------------------+
     */
    let hCenter = appSlogan.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    let width = appSlogan.widthAnchor.constraint(equalToConstant: LaunchRootView.APP_TITLE_WIDTH)
    let top = appSlogan.topAnchor.constraint(equalTo: self.appTitleView.bottomAnchor, constant: 40)
    
    NSLayoutConstraint.activate([hCenter, width, top])
  }
  
  func activateConstraintsRightsInfo() {
    rightsInfo.translatesAutoresizingMaskIntoConstraints = false
    
    /**
     +--------------------------------------+
     |self                                  |
     |    +----------------------------+    |
     |    | rightsInfo                 |    |
     |    |<---------- 300 ----------->|    |
     |    +----------------------------+    |
     |     SafeArea.bottom(-10) xCenter     |
     +--------------------------------------+
     */
    let hCenter = rightsInfo.centerXAnchor.constraint(equalTo: self.centerXAnchor)
    let width = rightsInfo.widthAnchor.constraint(equalToConstant: LaunchRootView.APP_TITLE_WIDTH)
    let bottom = rightsInfo.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10)
    
    NSLayoutConstraint.activate([hCenter, width, bottom])
  }
}

extension String {
  static let appTitle = localized(of: "APP_TITLE")
  static let appSlogan = localized(of: "APP_SLOGAN")
  static let rightsInfo = localized(of: "RIGHTS_INFO")
}
