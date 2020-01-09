//
//  AuthRemoteAPI.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/15.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation
import PromiseKit

public protocol AuthRemoteAPI {
  func signIn(username: String, password: Secret) -> Promise<UserSession>
  func signUp(account: LoginData) -> Promise<UserSession>
  func signOut(session: UserSession) -> Promise<GeneralResponse>
  func resetPassword(of email: String) -> Promise<GeneralResponse>
}
