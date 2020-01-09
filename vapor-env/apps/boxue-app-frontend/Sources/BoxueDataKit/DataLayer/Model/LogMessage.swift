//
//  LogMessage.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/15.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation

public struct LogMessage: Error {
  public let id: UUID
  public let title: String
  public let message: String
  
  public init(title: String, message: String) {
    self.id = UUID()
    self.title = title
    self.message = message
  }
}

extension LogMessage: Equatable {
  public static func == (lhs: LogMessage, rhs: LogMessage) -> Bool {
    return lhs.id == rhs.id
  }
}
