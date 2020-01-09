//
//  UserSession.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/15.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation

public class UserSession: Codable {
  public let profile: UserProfile
  public let remoteUserSession: RemoteUserSession
  
  public init(profile: UserProfile, remoteUserSession: RemoteUserSession) {
    self.profile = profile
    self.remoteUserSession = remoteUserSession
  }
}
