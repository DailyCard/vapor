//
//  PublicKey.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/7/25.
//  Copyright © 2019 Mars. All rights reserved.
//

import Foundation

public struct PublicKeyInfo: Decodable {
  public let version: Int
  public let pem: String
  
  private enum CodingKeys: String, CodingKey {
    case version
    case data
  }
  
  public init(version: Int, pem: String) {
    self.version = version
    self.pem = pem
  }
  
  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.version = try container.decode(Int.self, forKey: .version)
    let mixedPem = try container.decode(String.self, forKey: .data)
    
    guard let base64Decoded = mixedPem.base64Decoded(),
      let unmixed = unmix(base64Decoded) else {
      throw DataKitError.dataCorrupt
    }
    
    self.pem = unmixed
  }
}

