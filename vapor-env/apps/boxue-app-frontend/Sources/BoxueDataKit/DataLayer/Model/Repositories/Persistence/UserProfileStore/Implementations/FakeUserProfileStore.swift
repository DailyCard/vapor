//
//  FakeUserSessionSLD.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/15.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation
import PromiseKit

public class FakeUserProfileStore: UserProfileStore {
  public init() {}
  
  public func save(userProfile: UserProfile) -> Bool {
    return true
  }
  
  public func load() -> UserProfile? {
    return UserProfile(name: Fake.name, email: Fake.email, mobile: Fake.mobile, avatar: Fake.avatar)
  }
  
  public func delete() -> Bool {
    return true
  }
}
