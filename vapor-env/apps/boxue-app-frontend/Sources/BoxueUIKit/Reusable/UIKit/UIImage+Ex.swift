//
//  UIImage+Ex.swift
//  BoxueUIKit
//
//  Created by Mars on 2019/9/12.
//  Copyright © 2019 Mars. All rights reserved.
//

import UIKit

extension UIImage {
  /// Create an `UIImage` with solid color and size
  ///
  /// - Parameter size: size of the image
  /// - Parameter color: color filled into the image
  ///
  /// - Returns: A new `UIImage`
  ///
  public static func image(of size: CGSize, with color: UIColor) -> UIImage {
    return UIGraphicsImageRenderer(size: size).image { context in
      color.setFill()
      context.fill(CGRect(origin: .zero, size: size))
    }
  }
}
