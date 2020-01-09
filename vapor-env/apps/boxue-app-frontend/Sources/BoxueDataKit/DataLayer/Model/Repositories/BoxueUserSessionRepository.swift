//
//  BoxueUserSessionRepository.swift
//  BoxueDataKit
//
//  Created by Mars on 2018/10/15.
//  Copyright © 2018 Mars. All rights reserved.
//

import Foundation
import PromiseKit

public class BoxueUserSessionRepository: UserSessionRepository {
  /// - Properties
  let authRemoteAPI: AuthRemoteAPI
  let userProfileStore: UserProfileStore
  let remoteUserSessionStore: RemoteUserSessionStore
  
  public init(authRemoteAPI: AuthRemoteAPI,
              userProfileStore: UserProfileStore,
              remoteUserSessionStore: RemoteUserSessionStore) {
    self.authRemoteAPI = authRemoteAPI
    self.userProfileStore = userProfileStore
    self.remoteUserSessionStore = remoteUserSessionStore
  }
  
  public func signUp(newAccount: LoginData) -> Promise<Bool> {
    return authRemoteAPI.signUp(account:newAccount).map(saveUserSession)
  }
  
  public func signIn(email: String, password: Secret) -> Promise<Bool> {
    return authRemoteAPI.signIn(username:email, password:password).map(saveUserSession)
  }
  
  public func signOut() -> Promise<GeneralResponse> {
    return authRemoteAPI
      .signOut(session: makeUserSession())
  }
  
  public func isSignedIn() -> Bool {
    return remoteUserSessionStore.isLocalKeyExists()
  }
  
  public func resetPassword(of email: String) -> Promise<GeneralResponse> {
    return authRemoteAPI.resetPassword(of: email)
  }
  
  public func remoteUserSession() -> RemoteUserSession? {
    return remoteUserSessionStore.load()
  }
  
  public func clearUserSession() {
    _ = userProfileStore.delete()
    _ = remoteUserSessionStore.delete()
  }
  
  func makeUserSession() -> UserSession {
    return UserSession(profile: userProfileStore.load()!, remoteUserSession: remoteUserSessionStore.load()!)
  }
  
  func saveUserSession(_ session: UserSession) -> Bool {
    let saveProfileResult = self.userProfileStore.save(userProfile: session.profile)
    let saveSessionResult = self.remoteUserSessionStore.save(remoteUserSession: session.remoteUserSession)
    
    return saveProfileResult && saveSessionResult
  }
}
