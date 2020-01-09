//
//  BoxueAuthRemoteAPI.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/8/12.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftRSA
import PromiseKit
import Foundation

public struct BoxueAuthRemoteAPI: AuthRemoteAPI {
  #if DEBUG
  let host = "https://apn.boxue.io/api/v1"
  #else
  let host = "https://apn.boxueio.com/api/v1"
  #endif
  
  let authResource: Resource<UserSession>
  public static let `default` = BoxueAuthRemoteAPI()
  
  init() {
    self.authResource = Resource<UserSession>(json: URL(string: "\(host)/auth/login")!)
  }
  
  public func signIn(username: String, password: Secret) -> Promise<UserSession> {
    let loginInfo = LoginData(username: username, password: password)
    
    guard let loginData = try? JSONEncoder().encode(loginInfo) else {
      return Promise<UserSession> { seal in
        seal.reject(DataKitError.dataCorrupt)
      }
    }
    
    return URLSession.shared.post(authResource, with: loginData)
  }
  
  public func signUp(account: LoginData) -> Promise<UserSession> {
    fatalError("Unimplemented yet.")
  }
  
  public func signOut(session: UserSession) -> Promise<GeneralResponse> {
    let signOutResource = Resource<GeneralResponse>(json: URL(string: "\(host)/auth/logout")!)
    
    guard let signOutData = try? JSONEncoder().encode(session) else {
      return Promise<GeneralResponse> { seal in
        seal.reject(DataKitError.dataCorrupt)
      }
    }
    
    return URLSession.shared.post(signOutResource, with: signOutData)
  }
  
  public func resetPassword(of email: String) -> Promise<GeneralResponse> {
    let resetPasswordResource =
      Resource<GeneralResponse>(json: URL(string: "\(host)/auth/reset-password")!)

    let emailData = try! JSONEncoder().encode(["email": email])
    return URLSession.shared.post(resetPasswordResource, with: emailData)
  }
}
