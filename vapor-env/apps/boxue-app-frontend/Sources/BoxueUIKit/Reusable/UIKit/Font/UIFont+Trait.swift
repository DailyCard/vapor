//
//  UIFont+Trait.swift
//  BoxueUIKit
//
//  Created by Mars on 2018/11/21.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit

extension UIFont {
  func withTraits(traits: UIFontDescriptor.SymbolicTraits) -> UIFont {
    let descriptor = fontDescriptor.withSymbolicTraits(traits)
    return UIFont(descriptor: descriptor!, size: 0) // 0 means leave the size as it is.
  }
  
  public func bold() -> UIFont {
    return withTraits(traits: .traitBold)
  }
}
