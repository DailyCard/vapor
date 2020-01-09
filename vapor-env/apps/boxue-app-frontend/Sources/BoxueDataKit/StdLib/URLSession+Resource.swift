//
//  Alamofire+Resource.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/7/8.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftRSA
import Foundation
import PromiseKit
import CryptoSwift

public enum PMKTag {
  case promise
}

extension URLSession {
  func dataTask(_ tag: PMKTag, with url: URL) -> Promise<(data: Data, response: URLResponse)> {
    return Promise { resolver in
      dataTask(with: url, completionHandler: adapter(resolver)).resume()
    }
  }
  
  public func get<T: Decodable>(_ r: Resource<T>) -> Promise<T> {
    return dataTask(.promise, with: r.url).map { (data, response) in
      try handleResponse(r, data: data, response: response)
    }
  }
  
  func dataTask(_ tag: PMKTag, with request: URLRequest) -> Promise<(data: Data, response: URLResponse)> {
    return Promise { resolver in
      dataTask(with: request, completionHandler: adapter(resolver)).resume()
    }
  }
  
  public func post<T: Decodable>(_ r: Resource<T>, with body: Data, encrypted: Bool = true) -> Promise<T> {
    var er: Data!
    
    if encrypted {
      er = try? body.requestEncryptor()
      
      if er == nil {
        return Promise<T> { seal in
          seal.reject(DataKitError.dataCorrupt)
        }
      }
    }
    
    var request = URLRequest(url: r.url)
    request.httpMethod = "POST"
    request.httpBody = encrypted ? er : body
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")

    return dataTask(.promise, with: request).map { (data, response) in
      try handleResponse(r, data: data, response: response)
    }
  }
}

private func adapter<T, U>(_ seal: Resolver<(data: T, response: U)>) -> (T?, U?, Error?) -> Void {
  return {
    t, u, e in
    if let t = t, let u = u {
      seal.fulfill((t, u))
    }
    else if let e = e {
      seal.reject(e)
    }
    else {
      seal.reject(PMKError.invalidCallingConvention)
    }
  }
}

fileprivate func handleResponse<T: Decodable>(
  _ r: Resource<T>, data: Data, response: URLResponse) throws -> T {
  guard let httpResponse = response as? HTTPURLResponse else {
    // This should never happen
    fatalError("URLResponse cannot be converted to HTTPURLResponse")
  }
  
  if 200...299 ~= httpResponse.statusCode {
    return try r.parser(data)
  }
  else {
    guard let responseError =
      try? JSONDecoder().decode(ResponseError.self, from: data) else {
      throw DataKitError.dataCorrupt
    }
    
    throw DataKitError.responseError(data: responseError)
  }
}
