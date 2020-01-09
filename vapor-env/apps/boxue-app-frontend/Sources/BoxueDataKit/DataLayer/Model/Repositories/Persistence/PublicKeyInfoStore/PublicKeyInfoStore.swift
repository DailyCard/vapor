//
//  PublicKeyStore.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/7/25.
//  Copyright © 2019 Mars. All rights reserved.
//

import PromiseKit
import Foundation

public protocol PublicKeyInfoStore {
  func refresh() -> Promise<PublicKeyInfo>
  func getLocalInfo() -> PublicKeyInfo?
}
