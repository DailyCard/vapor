//
//  PromiseKit+Ex.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/7/27.
//  Copyright © 2019 Mars. All rights reserved.
//

import PromiseKit
import Foundation

public func attempt<T>(
  delayBeforeRetry: Int = 5,
  body: @escaping () -> Promise<T>) -> Promise<T> {
  var attempts = 0
  
  func _attempt() -> Promise<T> {
    attempts += 1
    
    return body().recover {
      error -> Promise<T> in
      print("attempts: \(attempts)")
      print(error)
      return after(.seconds(attempts * delayBeforeRetry)).then(_attempt)
    }
  }
  
  return _attempt()
}
