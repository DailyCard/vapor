//
//  AppDelegate.swift
//  Boxue
//
//  Created by Mars on 2018/10/4.
//  Copyright © 2018 Mars. All rights reserved.
//

import UIKit

import PromiseKit
import UserNotifications

import Boxue_iOS
import BoxueUIKit
import BoxueDataKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  typealias LaunchOptionsDic = [UIApplication.LaunchOptionsKey: Any]?
  var token: String?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: LaunchOptionsDic) -> Bool {
    /// - Todo
    /// Add an in-app locale switch config
    UserDefaults.standard.set(["zh-Hans"], forKey: "AppleLanguages")
    // UserDefaults.standard.set(["en"], forKey: "AppleLanguages")
    
    registerForRemoteNotificationsIfAuthorized(application)
    
    // Continue fetching the public key at backend until success
    _ = attempt() {
      KeychainBasedPublicKeyInfoStore
        .default
        .refresh()
        .done { print($0) }
    }
    
    return true
  }
  
  // MARK: - UISceneSession Lifecycle

  func application(_ application: UIApplication,
                   configurationForConnecting connectingSceneSession: UISceneSession,
                   options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication,
                   didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
  }
  
  // MARK: - APN related
  
  func registerForRemoteNotificationsIfAuthorized(_ application: UIApplication) {
    let center = UNUserNotificationCenter.current()
    
    firstly {
      center.isNotificationPermissionAuthorized()
    }
    .done { isAuthorized in
      if isAuthorized {
        ///
        /// By default, everything runs on the main queue within the `done` block.
        /// So we do not need to put the registration on the main queue maunally:
        ///
        ///    DispatchQueue.main.async {
        ///        application.registerForRemoteNotifications()
        ///    }
        ///
        application.registerForRemoteNotifications()
      }
    }
  }
  
  func application(_ application: UIApplication,
                   didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    token = deviceToken.reduce("") { $0 + String(format: "%02x", $1) }
  }
}
