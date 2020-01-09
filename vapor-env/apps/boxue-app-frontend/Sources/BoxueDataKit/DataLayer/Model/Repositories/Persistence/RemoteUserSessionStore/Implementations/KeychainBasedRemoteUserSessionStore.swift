//
//  KeychainBasedRemoteUserSessionStore.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/8/23.
//  Copyright © 2019 Mars. All rights reserved.
//

import Foundation
import KeychainWrapper

public class KeychainBasedRemoteUserSessionStore {
  let remoteUserSessionkey = "io.boxue.key.remote.usersession"
  
  #if DEBUG
  let host = "https://apn.boxue.io/api/v1"
  #else
  let host = "https://apn.boxueio.com/api/v1"
  #endif
  
  let remoteUserSessionResource: Resource<RemoteUserSession>
  
  public init() {
    remoteUserSessionResource = Resource<RemoteUserSession>(json: URL(string: "\(host)/user/remote-session")!)
  }
  
  public static let `default` = KeychainBasedRemoteUserSessionStore()
  
  public func isLocalKeyExists() -> Bool {
    return KeychainWrapper.default.hasValue(forKey: remoteUserSessionkey)
  }
}

extension KeychainBasedRemoteUserSessionStore: RemoteUserSessionStore {
  public func save(remoteUserSession: RemoteUserSession) -> Bool {
    return KeychainWrapper.default.set(remoteUserSession, forKey: remoteUserSessionkey)
  }
  
  public func load() -> RemoteUserSession? {
    return KeychainWrapper.default.object(of: RemoteUserSession.self, forKey: remoteUserSessionkey)
  }
  
  public func delete() -> Bool {
    KeychainWrapper.default.removeObject(forKey: remoteUserSessionkey)
  }
}
