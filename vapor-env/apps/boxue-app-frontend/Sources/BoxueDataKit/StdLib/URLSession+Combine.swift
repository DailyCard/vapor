//
//  URLSession+Combine.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/9/4.
//  Copyright © 2019 Mars. All rights reserved.
//
import Combine
import Foundation

extension URLSession {
  public func post<T: Decodable>(
    _ r: ResourceX<T>, with body: Data, encrypted: Bool = true)
    -> AnyPublisher<T, DataKitError> {
    var er: Data!
    
    if encrypted {
      er = try? body.requestEncryptor()
      
      if er == nil {
        return Fail(error: DataKitError.dataCorrupt).eraseToAnyPublisher()
      }
    }

    var request = URLRequest(url: r.url)
    request.httpMethod = "POST"
      request.httpBody = encrypted ? er : body
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    
    return dataTaskPublisher(for: request)
      .mapError { DataKitError.network(description: $0.localizedDescription) }
      .flatMap(maxPublishers: .max(1)) { pair in
        return handleResponse(r, data: pair.data, response: pair.response)
      }
      .eraseToAnyPublisher()
  }
  
  public func get<T: Decodable>(_ r: ResourceX<T>) -> AnyPublisher<T, DataKitError> {
    var request = URLRequest(url: r.url)
    request.httpMethod = "GET"
    
    return dataTaskPublisher(for: request)
      .mapError {
        DataKitError.network(description: $0.localizedDescription)
      }
      .flatMap(maxPublishers: .max(1)) { pair in
        return handleResponse(r, data: pair.data, response: pair.response)
      }
      .eraseToAnyPublisher()
  }
}

fileprivate func handleResponse<T: Decodable>(
  _ r: ResourceX<T>, data: Data, response: URLResponse) -> AnyPublisher<T, DataKitError> {
  
  guard let httpResponse = response as? HTTPURLResponse else {
    // This should never happen
    fatalError("URLResponse cannot be converted to HTTPURLResponse")
  }
  
  if 200...299 ~= httpResponse.statusCode {
    return r.parser(data)
  }
  else {
    if let responseError = try? JSONDecoder().decode(ResponseError.self, from: data) {
      return Result<T, DataKitError>
        .Publisher(.failure(.responseError(data: responseError)))
        .eraseToAnyPublisher()
    } else {
      return Result<T, DataKitError>
        .Publisher(.failure(.dataCorrupt))
        .eraseToAnyPublisher()
    }
  }
}



