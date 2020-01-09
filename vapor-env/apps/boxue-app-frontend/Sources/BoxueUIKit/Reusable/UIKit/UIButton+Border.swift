//
//  UIButton+Border.swift
//  BoxueUIKit
//
//  Created by Mars on 2019/8/28.
//  Copyright © 2019 Mars. All rights reserved.
//

import UIKit

public enum UIButtonBorderPosition {
  case top, bottom, left, right
}

extension UIButton {
  public func addBorder(on side: UIButtonBorderPosition, color: UIColor, size: CGFloat) {
    let border = CALayer()
    border.backgroundColor = color.cgColor
    
    switch side {
    case .top:
      border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: size)
    case .bottom:
      border.frame = CGRect(x: 0, y: frame.size.height - size, width: frame.size.width, height: size)
    case .left:
      border.frame = CGRect(x: 0, y: 0, width: size, height: frame.size.height)
    case .right:
      border.frame = CGRect(x: frame.size.width - size, y: 0, width: size, height: frame.size.height)
    }
    
    layer.addSublayer(border)
  }
}
