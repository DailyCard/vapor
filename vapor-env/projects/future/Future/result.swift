//
//  result.swift
//  Future
//
//  Created by roni on 2019/12/30.
//  Copyright © 2019 roni. All rights reserved.
//

import Foundation

enum Result<T> {
    case value(T)
    case error(Error)
}
