//
//  UserSessionRepository.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/15.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation
import PromiseKit

public protocol UserSessionRepository {
  func signUp(newAccount: LoginData) -> Promise<Bool>
  func signIn(email: String, password: Secret) -> Promise<Bool>
  func signOut() -> Promise<GeneralResponse>
  
  // - MARK: Helpers
  func isSignedIn() -> Bool
  func resetPassword(of email: String) -> Promise<GeneralResponse>
  func remoteUserSession() -> RemoteUserSession?
  func clearUserSession()
}
