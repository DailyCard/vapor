//
//  KeychainBasedPublicKeyStore.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/7/25.
//  Copyright © 2019 Mars. All rights reserved.
//

import PromiseKit
import KeychainWrapper
import Foundation

public class KeychainBasedPublicKeyInfoStore {
  let versionKey = "io.boxue.key.public.version"
  let pemKey = "io.boxue.key.public.pem"
  
  #if DEBUG
  let host = "https://apn.boxue.io/api/v1"
  #else
  let host = "https://apn.boxueio.com/api/v1"
  #endif
  
  let pubKeyResource: Resource<PublicKeyInfo>
  
  private init() {
    pubKeyResource = Resource<PublicKeyInfo>(json: URL(string: "\(host)/public-key")!)
  }
  
  public static let `default` = KeychainBasedPublicKeyInfoStore()
  
  func isLocalKeyExists() -> Bool {
    let keyExists = KeychainWrapper.default.hasValue(forKey: versionKey)
    let pemExists = KeychainWrapper.default.hasValue(forKey: pemKey)
    
    return keyExists && pemExists
  }
  
  func fetch() -> Promise<PublicKeyInfo> {
    return URLSession.shared.get(pubKeyResource)
  }
  
  func save(_ info: PublicKeyInfo) throws -> Void {
    KeychainWrapper.default.set(info.version, forKey: versionKey)
    KeychainWrapper.default.set(info.pem, forKey: pemKey)
  }
  
  func update(_ info: PublicKeyInfo) throws -> Void {
    guard let local = getLocalInfo() else {
      throw DataKitError.localPubKeyNotExists
    }
    
    if info.version > local.version {
      try save(info)
    }
  }
}

extension KeychainBasedPublicKeyInfoStore: PublicKeyInfoStore {
  public func refresh() -> Promise<PublicKeyInfo> {
    return fetch().map {
      if self.isLocalKeyExists() {
        try self.update($0)
      }
      else {
        try self.save($0)
      }
      
      return $0
    }
  }
  
  public func getLocalInfo() -> PublicKeyInfo? {
    guard let version = KeychainWrapper.default.object(of: Int.self, forKey: versionKey),
      let pem = KeychainWrapper.default.string(forKey: pemKey) else {
        return nil
    }
    
    return PublicKeyInfo(version: version, pem: pem)
  }
}
