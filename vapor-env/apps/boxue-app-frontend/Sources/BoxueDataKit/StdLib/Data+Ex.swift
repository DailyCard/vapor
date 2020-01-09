//
//  Data+Ex.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/8/15.
//  Copyright © 2019 Mars. All rights reserved.
//

import SwiftRSA
import CryptoSwift
import Foundation

extension Data {
  public func requestEncryptor() throws -> Data {
    let ct = ClearText(data: self)
    
    guard let pubKeyData = KeychainBasedPublicKeyInfoStore.default.getLocalInfo(),
      let pubKey = PublicKey(pemEncoded: pubKeyData.pem) else {
      throw DataKitError.dataCorrupt
    }
    
    let et = try ct.encrypted(with: pubKey, by: .rsaEncryptionOAEPSHA1)
    
    return try JSONEncoder().encode([
      "encrypted": et.data
    ])
  }
  
  public func responseDecryptor<T: Decodable>(
    to type: T.Type, decoder: JSONDecoder = JSONDecoder()) throws -> T {
    /// 1. Decode the response
    let response = try JSONDecoder().decode(EnryptedResponse.self, from: self)
    
    /// 2. Get key and iv of AES
    guard let (key, iv) = getAESKeyAndIv(response.key),
      let encryptedData = Data(base64Encoded: response.encrypted) else {
      throw DataKitError.dataCorrupt
    }
    
    /// 3. Decrypt data
    let aes = try AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
    let decryptedData = try aes.decrypt(Array<UInt8>(encryptedData))
    
    /// 4. Decode data from JSON
    return try decoder.decode(type, from: Data(decryptedData))
  }
  
  func getAESKeyAndIv(_ base64edMixedKey: String) -> (Array<UInt8>, Array<UInt8>)? {
    guard let mixedKey: String = base64edMixedKey.base64Decoded(),
      let unmixedString = unmix(mixedKey) else { return nil }
    
    let splitted = unmixedString.split(separator: ":")
    guard splitted.count == 2 else { return nil }
    
    let key = Array<UInt8>(Data(base64Encoded: String(splitted[0]))!)
    let iv = Array<UInt8>(Data(base64Encoded: String(splitted[1]))!)
    
    return (key, iv)
  }
}
