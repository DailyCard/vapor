//
//  UserProfile.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/15.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation

public struct UserProfile: Equatable {
  public let name: String
  public let email: String
  public let mobile: String?
  public let avatar: URL
  
  private enum CodingKeys: CodingKey {
    case name
    case email
    case mobile
    case avatar
  }
  
  public init(name: String, email: String, mobile: String?, avatar: URL) {
    self.name = name
    self.email = email
    self.mobile = mobile
    self.avatar = avatar
  }
}

extension UserProfile: Codable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(name, forKey: .name)
    try container.encode(email, forKey: .email)
    try container.encodeIfPresent(mobile, forKey: .mobile)
    try container.encode(avatar, forKey: .avatar)
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.name = try container.decode(String.self, forKey: .name)
    self.email = try container.decode(String.self, forKey: .email)
    self.mobile = try container.decodeIfPresent(String.self, forKey: .mobile)
    self.avatar = try container.decode(URL.self, forKey: .avatar)
  }
}
