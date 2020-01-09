//
//  ErrorMessage.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/12/24.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation

public struct ErrorMessage: Error {
  public let id: UUID
  public let title: String
  public let description: String
  
  public init(title: String, description: String) {
    self.id = UUID()
    self.title = title
    self.description = description
  }
}

extension ErrorMessage: Equatable {
  public static func ==(lhs: ErrorMessage, rhs: ErrorMessage) -> Bool {
    return lhs.id == rhs.id
  }
}
