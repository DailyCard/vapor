//
//  ResponseError.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/8/27.
//  Copyright © 2019 Mars. All rights reserved.
//

import Foundation

public struct ResponseError: Codable {
  public let statusCode: Int
  public let description: String
}

public struct GeneralResponse: Codable {
  public let statusCode: Int
  public let description: String
}

public struct EnryptedResponse: Codable {
  public let key: String
  public let encrypted: String
}
