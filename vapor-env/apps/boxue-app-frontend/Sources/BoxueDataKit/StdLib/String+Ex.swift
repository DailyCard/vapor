//
//  String+Localized.swift
//  BoxueUIKit
//
//  Created by Mars on 2018/11/21.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation

extension String {
  public static func localized(of key: String, comment: String = "") -> String {
    return NSLocalizedString(key,
                             tableName: "Localizable",
                             bundle: Bundle.init(identifier: "io.boxue.BoxueApp01")!,
                             comment: comment)
  }
}

extension String {
  public func base64Encoded() -> String? {
    return data(using: .utf8)?.base64EncodedString()
  }
  
  public func base64Decoded() -> String? {
    guard let data = Data(base64Encoded: self) else { return nil }
    return String(data: data, encoding: .utf8)
  }
}

extension String {
  /// This regex was define at [emailregex.com](http://emailregex.com/).
  /// Read [RFC 5322](http://www.ietf.org/rfc/rfc5322.txt) for more details.
  static let emailRegex =
    #"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"# +
    #"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@"# +
    #"(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?"# +
    #"|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}"# +
    #"(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]"# +
    #":(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"# 
  
  static func ~= (lhs: String, rhs: String) -> Bool {
    let regex = try! NSRegularExpression(pattern: rhs, options: .caseInsensitive)
    return regex.firstMatch(in: lhs, options: [], range: NSRange(location: 0, length: lhs.count)) != nil
  }
  
  public var isValidEmail: Bool {
    return self ~= String.emailRegex
  }
}
