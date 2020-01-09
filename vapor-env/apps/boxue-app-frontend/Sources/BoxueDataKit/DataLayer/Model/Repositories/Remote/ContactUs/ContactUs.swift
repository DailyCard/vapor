//
//  ContactUs.swift
//  BoxueDataKit
//
//  Created by Mars on 2019/9/4.
//  Copyright © 2019 Mars. All rights reserved.
//

import Combine
import Foundation

protocol ContactUs {
  mutating func send(_ message: ContactUsMessage) -> AnyPublisher<GeneralResponse, DataKitError>
}
