//
//  NewAccount.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/15.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation

public struct LoginData: Codable {
  
  /// - Properties
  public let username: String
  public let password: Secret
  
  /// - Methods
  init(username: String, password: Secret) {
    self.username = username
    self.password = password
  }
}
