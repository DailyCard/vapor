//
//  UIColor+Hex.swift
//  BoxueUIKit
//
//  Created by Mars on 2018/11/20.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit

extension UIColor {
  public convenience init(red: Int, green: Int, blue: Int) {
    self.init(
      red: CGFloat(red) / 255.0,
      green: CGFloat(green) / 255.0,
      blue: CGFloat(blue) / 255.0,
      alpha: 1.0
    )
  }
  
  public convenience init(_ hex: Int) {
    assert(0...0xFFFFFF ~= hex, "The color hex value must between 0 to 0xFFFFFF.")
    
    let r = (hex & 0xFF0000) >> 16
    let g = (hex & 0x00FF00) >> 8
    let b = (hex & 0x0000FF)
    
    self.init(red: r, green: g, blue: b)
  }
}

extension UIColor {
  public static var fixedSystemGray5: UIColor {
    if #available(iOS 13, *) {
      return UIColor { (traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
          return UIColor(red: 229, green: 229, blue: 234)
        } else {
          return UIColor(red: 229, green: 229, blue: 234)
        }
      }
    } else {
      return UIColor(red: 229, green: 229, blue: 234)
    }
  }
  
  public static var fixedSystemGray6: UIColor {
    if #available(iOS 13, *) {
      return UIColor { (traitCollection: UITraitCollection) -> UIColor in
        if traitCollection.userInterfaceStyle == .dark {
          return UIColor(red: 242, green: 242, blue: 247)
        } else {
          return UIColor(red: 242, green: 242, blue: 247)
        }
      }
    } else {
      return UIColor(red: 242, green: 242, blue: 247)
    }
  }
}
