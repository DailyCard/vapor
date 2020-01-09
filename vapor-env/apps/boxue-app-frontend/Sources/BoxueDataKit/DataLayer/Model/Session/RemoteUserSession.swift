//
//  RemoteUserSession.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/15.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation

public struct RemoteUserSession {
  let token: String
  let deadline: Date
  
  private enum CodingKeys: CodingKey {
    case token
    case deadline
  }
    
  public init(token: String) {
    self.token = token
    self.deadline = Date()
  }
}

extension RemoteUserSession: Codable {
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(token, forKey: .token)
    
    let formatter = DateFormatter.mysql
    let datetime = formatter.string(from: deadline)
    try container.encode(datetime, forKey: .deadline)
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.token = try container.decode(String.self, forKey: .token)
    let datetime = try container.decode(String.self, forKey: .deadline)
    let formatter = DateFormatter.mysql
    guard let date = formatter.date(from: datetime) else {
      throw DataKitError.dataCorrupt
    }
    
    self.deadline = date
  }
}

extension RemoteUserSession: Equatable {
  public static func ==(lhs: RemoteUserSession, rhs: RemoteUserSession) -> Bool {
    return lhs.token == rhs.token
  }
}
