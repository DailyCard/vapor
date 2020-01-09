//
//  Resource.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/7/8.
//  Copyright © 2019 Mars. All rights reserved.
//

import Combine
import CoreData
import Foundation

public struct Resource<R> {
  public let url: URL
  public let parser: (Data) throws -> R
}

extension Resource where R: Decodable {
  public init(json url: URL, decoder: JSONDecoder = JSONDecoder()) {
    self.url = url
    
    self.parser = {
      if let decrypted = try? $0.responseDecryptor(to: R.self, decoder: decoder) {
        
        /// Save the data into core data if the decoder set `.managedObjectContext` key.
        if decoder.userInfo[CodingUserInfoKey.managedObjectContext!] as? NSManagedObjectContext != nil {
          CoreDataManager.shared.saveContext()
        }
        
        /// An encrypted response
        return decrypted
      }
      
      /// A normal response
      let decoded = try decoder.decode(R.self, from: $0)
      return decoded
    }
  }
}

public struct ResourceX<R> {
  public let url: URL
  public let parser: (Data) -> AnyPublisher<R, DataKitError>
}

extension ResourceX where R: Decodable {
  public init(json url: URL, decoder: JSONDecoder = JSONDecoder()) {
    self.url = url
    self.parser = { ResourceX._parser($0, decoder) }
  }
  
  /// `AnyPublisher` version
  static func _parser(_ data: Data, _ decoder: JSONDecoder) -> AnyPublisher<R, DataKitError> {
    if let decrypted = try? data.responseDecryptor(to: R.self, decoder: decoder) {
      
      /// Save the data into core data if the decoder set `.managedObjectContext` key.
      if decoder.userInfo[CodingUserInfoKey.managedObjectContext!] as? NSManagedObjectContext != nil {
        CoreDataManager.shared.saveContext()
      }
      
      return Result<R, DataKitError>
        .Publisher(decrypted)
        .eraseToAnyPublisher()
    }
    
    return Just(data)
      .decode(type: R.self, decoder: decoder)
      .mapError { _ in DataKitError.dataCorrupt }
      .eraseToAnyPublisher()
  }
  
  /// `Future` version
  static func _parser(_ data: Data, _ decoder: JSONDecoder) -> Future<R, DataKitError> {
    if let decrypted = try? data.responseDecryptor(to: R.self, decoder: decoder) {
      return Future { promise in
        promise(.success(decrypted))
      }
    }
    
    return Future { promise in
      do {
        let decoded = try decoder.decode(R.self, from: data)
        promise(.success(decoded))
      }
      catch {
        promise(.failure(.dataCorrupt))
      }
    }
  }
}
