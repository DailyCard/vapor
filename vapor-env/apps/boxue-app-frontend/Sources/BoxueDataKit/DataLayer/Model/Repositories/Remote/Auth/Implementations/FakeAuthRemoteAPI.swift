//
//  FakeAuthRemoteAPI.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/15.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation
import PromiseKit

struct Fake {
  static let email = "11@boxue.io"
  static let password = "boxue1011"
  static let name = "bx11"
  static let mobile = "18610111110"
  static let avatar = makeURL()
  static let token = "bx10&11"
}

public struct FakeAuthRemoteAPI: AuthRemoteAPI {
  public func resetPassword(of email: String) -> Promise<GeneralResponse> {
    return Promise { $0.fulfill(GeneralResponse(statusCode: 200, description: "Success")) }
  }
  
  public func signOut(session: UserSession) -> Promise<GeneralResponse> {
    return Promise { $0.fulfill(GeneralResponse(statusCode: 200, description: "Success")) }
  }
  
  public init() {}
  
  public func signIn(username: String, password: Secret) -> Promise<UserSession> {
    return Promise<UserSession> { seal in
      guard username == Fake.email && password == Fake.password else {
        return seal.reject(DataKitError.any)
      }
      
      let profile = UserProfile(name: Fake.name,
                                email: Fake.email,
                                mobile: Fake.mobile,
                                avatar: Fake.avatar)
      let remoteSession = RemoteUserSession(token: Fake.token)
      let userSession = UserSession(profile: profile,
                                    remoteUserSession: remoteSession)
      
      seal.fulfill(userSession)
    }
  }
  
  public func signUp(account: LoginData) -> Promise<UserSession> {
    let profile = UserProfile(name: Fake.name,
                              email: account.username,
                              mobile: nil,
                              avatar: makeURL())
    let remoteSession = RemoteUserSession(token: Fake.token)
    let userSession = UserSession(profile: profile,
                                  remoteUserSession: remoteSession)
    
    return Promise.value(userSession)
  }
}

