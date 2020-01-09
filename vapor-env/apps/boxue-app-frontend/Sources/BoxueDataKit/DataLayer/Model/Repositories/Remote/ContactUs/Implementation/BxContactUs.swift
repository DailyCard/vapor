//
//  BxContactUs.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/9/4.
//  Copyright © 2019 Mars. All rights reserved.
//
import Combine
import Foundation

public struct BxContactUs: ContactUs {
  #if DEBUG
  let host = "https://apn.boxue.io/api/v1"
  #else
  let host = "https://apn.boxueio.com/api/v1"
  #endif
  
  func send(_ message: ContactUsMessage) -> AnyPublisher<GeneralResponse, DataKitError> {
    let url = URL(string: "\(host)/contact-us")!
    
    guard let payload = try? JSONEncoder().encode(message) else {
      return Fail(error: DataKitError.dataCorrupt).eraseToAnyPublisher()
    }
    
    let contactUsResource = ResourceX<GeneralResponse>(json: url)
    
    return URLSession.shared.post(contactUsResource, with: payload)
  }
}
