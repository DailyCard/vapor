//
//  RemoteUserSessionTests.swift
//  BoxueUnitTests
//
//  Created by Mars on 2019/8/21.
//  Copyright © 2019 Mars. All rights reserved.
//

import XCTest
@testable import BoxueDataKit

class RemoteUserSessionTests: CommonTests {
  //
  let json = """
  {
    "token": "\(UUID())",
    "deadline": "2019-08-21 11:21:06"
  }
  """.data(using: .utf8)!
  
  override func setUp() {}

  override func tearDown() {}
  
  func testDecodeRemoteSession() throws {
    do {
      let decoder = JSONDecoder()
      let rus = try decoder.decode(RemoteUserSession.self, from: json)
      print(rus)
      
      let calendar = Calendar.current
      let components = calendar.dateComponents(
        [Calendar.Component.day,
         Calendar.Component.month,
         Calendar.Component.year,
         Calendar.Component.hour,
         Calendar.Component.minute,
         Calendar.Component.second],
        from: rus.deadline)
      
      XCTAssertEqual(components.year!,   2019)
      XCTAssertEqual(components.month!,  8)
      XCTAssertEqual(components.day!,    21)
      XCTAssertEqual(components.hour!,   11)
      XCTAssertEqual(components.minute!, 21)
      XCTAssertEqual(components.second!, 06)
    }
    catch {
      XCTFail("Decode remote user session failed.")
    }
  }
  
  func testEncodeRemoteSession() throws {
    do {
      let decoder = JSONDecoder()
      let rus = try decoder.decode(RemoteUserSession.self, from: json)
      
      let encoder = JSONEncoder()
      let encoded = try encoder.encode(rus)
      
      XCTAssertEqual(encoded, json)
    }
    catch {
      XCTFail("Encode remote user session failed.")
    }
  }
}
