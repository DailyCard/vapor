//
//  KeychainBasedUserSessionStore.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/8/21.
//  Copyright © 2019 Mars. All rights reserved.
//

import Foundation
import PromiseKit
import KeychainWrapper

public class KeychainBasedUserProfileStore {
  let userProfileKey = "io.boxue.key.user.profile"
  
  #if DEBUG
  let host = "https://apn.boxue.io/api/v1"
  #else
  let host = "https://apn.boxueio.com/api/v1"
  #endif
  
  let profileResource: Resource<UserProfile>
  
  init() {
    profileResource = Resource<UserProfile>(json: URL(string: "\(host)/user/profile")!)
  }
  
  public static let `default` = KeychainBasedUserProfileStore()
  
  func isLocalKeyExists() -> Bool {
    return KeychainWrapper.default.hasValue(forKey: userProfileKey)
  }
}

extension KeychainBasedUserProfileStore: UserProfileStore {
  public func save(userProfile: UserProfile) -> Bool {
    return KeychainWrapper.default.set(userProfile, forKey: userProfileKey)
  }
  
  public func load() -> UserProfile? {
    return KeychainWrapper.default.object(of: UserProfile.self, forKey: userProfileKey)
  }
  
  public func delete() -> Bool {
    KeychainWrapper.default.removeObject(forKey: userProfileKey)
  }
}
