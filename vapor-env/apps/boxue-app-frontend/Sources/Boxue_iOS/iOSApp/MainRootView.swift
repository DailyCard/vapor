//
//  MainRootView.swift
//  Boxue_iOS
//
//  Created by Mars on 2019/1/23.
//  Copyright © 2019 Mars. All rights reserved.
//

import UIKit

import BoxueUIKit

public class MainRootView: NiblessView {
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
  }
  
  func activateConstraints() {
    activateConstraintsBGImage()
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
}

extension String {
  static let cancel = localized(of: "CANCEL")
}
