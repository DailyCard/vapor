//
//  RemoteUserSessionStore.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/8/23.
//  Copyright © 2019 Mars. All rights reserved.
//

import Foundation

public protocol RemoteUserSessionStore {
  func save(remoteUserSession: RemoteUserSession) -> Bool
  func load() -> RemoteUserSession?
  func delete() -> Bool
  func isLocalKeyExists() -> Bool
}
