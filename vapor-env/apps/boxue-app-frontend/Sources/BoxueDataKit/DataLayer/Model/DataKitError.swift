//
//  DataKitError.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/15.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation

public enum DataKitError: Error {
  case dataCorrupt
  case localPubKeyNotExists
  case fileNotExist
  case any
  case network(description: String)
  case responseError(data: ResponseError)
}
