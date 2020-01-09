//
//  DecryptedResponse.swift
//  BoxueUnitTests
//
//  Created by Mars on 2019/8/13.
//  Copyright © 2019 Mars. All rights reserved.
//

import CryptoSwift
import XCTest
@testable import BoxueDataKit

class DecryptedResponseTests: CommonTests {
  let key = { () -> [UInt8] in
    var tmp: [UInt8] = []
    for i in 1...32 { tmp.append(UInt8(i)) }
    return tmp
  }()
  
  let iv = { () -> [UInt8] in
    var tmp: [UInt8] = []
    for i in 1...16 { tmp.append(UInt8(i)) }
    return tmp
  }()
  
  let origin = ["testKey": "aaa"]
  var response: [String: String] = [:]
  
  func createMixedKey() -> String {
    let keyString = Data(key).base64EncodedString()
    let ivString = Data(iv).base64EncodedString()
    let origin = "\(keyString):\(ivString)"
    
    let mixed = mix(origin)!
    
    return mixed.base64Encoded()!
  }
  
  override func setUp() {
    let aes = try! AES(key: key, blockMode: CBC(iv: iv), padding: .pkcs7)
    let encoded = try! JSONEncoder().encode(origin)
    let encrypted = try! aes.encrypt(Array<UInt8>(encoded))
    let encryptedData = Data(encrypted).base64EncodedString()

    response = [
     "key": createMixedKey(),
     "encrypted": encryptedData
    ]
  }

  override func tearDown() {}

  func testMixAndUnmix() {
    let origin = "origin"
    
    guard let mixed = mix(origin),
      let unmixed = unmix(mixed),
      unmixed == origin else {
      XCTFail("Mix string failed.")
      return
    }
  }
  
  func testGetAESKeyAndIv() {
    let responseData = try! JSONEncoder().encode(response)
    let (k, i) = responseData.getAESKeyAndIv(response["key"]!)!
    
    XCTAssertEqual(k, key)
    XCTAssertEqual(i, iv)
  }
  
  func testDecryptResponse() {
    let responseData = try! JSONEncoder().encode(response)
    let decryptedData = try! responseData.responseDecryptor(to: [String: String].self)
    
    XCTAssertEqual(origin, decryptedData)
  }

}
