//
//  DateFormatter.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/8/21.
//  Copyright © 2019 Mars. All rights reserved.
//

import Foundation

extension DateFormatter {
  static let mysql: DateFormatter = {
    let formatter = DateFormatter()
    // 2019-05-04 15:18:51
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return formatter
  }()
  
  static let normal: DateFormatter = {
    let formatter = DateFormatter()
    // 09/28/2019
    formatter.dateFormat = "MM/dd/yyyy"
    return formatter
  }()
}
