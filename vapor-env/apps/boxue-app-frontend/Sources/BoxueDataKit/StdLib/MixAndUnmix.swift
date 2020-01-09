//
//  EncrypterAndDecrypter.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/8/13.
//  Copyright © 2019 Mars. All rights reserved.
//
import SwiftRSA
import CryptoSwift
import Foundation

func mix(_ data: String) -> String? {
  return algo(data)
}

func unmix(_ data: String) -> String? {
  return algo(data)
}

func algo(_ data: String) -> String? {
  guard var d = data.data(using: .utf8) else { return nil }
  
  d.withUnsafeMutableBytes {
    let p = $0.bindMemory(to: UInt8.self)
    var curr = p.startIndex
    var next = p.index(after: curr)
    let last = p.index(before: p.endIndex)

    while next <= last {
      p[curr] = p[curr] ^ p[next]

      curr = p.index(curr, offsetBy: 2)
      next = p.index(after: curr)
    }
  }
  
  return String(data: d, encoding: .utf8)
}


