//
//  HomeDataAPI.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/10/5.
//  Copyright © 2019 Mars. All rights reserved.
//

import Combine
import CoreData
import Foundation

public struct HomeDataAPI {
  #if DEBUG
  let host = "https://apn.boxue.io/api/v1"
  #else
  let host = "https://apn.boxueio.com/api/v1"
  #endif
  
  let homeDataResource: ResourceX<HomeData>
  var remoteUserSession: RemoteUserSession?
  
  public init(remoteUserSession: RemoteUserSession?) {
    var path = "\(host)/home"
    if remoteUserSession != nil {
      path += "/\(remoteUserSession!.token)"
    }
    
    let url = URL(string: path)! // /api/v1/home/{remoteUserSession.token?}
    let decoder = JSONDecoder()
    
    let managedObjectContext = CoreDataManager.shared.managedContext
    decoder.userInfo[CodingUserInfoKey.managedObjectContext!] = managedObjectContext
    
    homeDataResource = ResourceX<HomeData>(json: url, decoder: decoder)
  }
  
  public func get() -> AnyPublisher<HomeData, DataKitError> {
    URLSession.shared.get(homeDataResource)
  }
}
