//
//  main.swift
//  Future
//
//  Created by roni on 2019/12/30.
//  Copyright © 2019 roni. All rights reserved.
//

import Foundation

print("Hello, World!")

load { (result) in
    switch result {
    case .value(let value):
        print("value: \(value)")
    case .error(let error):
        print("error: \(error)")
    }
}

//load().register { result in
//    switch result {
//    case .value(let value):
//        let users = try! JSONDecoder().decode([User].self, from: value)
//        print(users)
//    case .error(let error):
//        print(error)
//    }
//}

load().register { users in
    switch users {
    case .value(let users):
        print(users)
    case .error(let error):
        print(error)
    }
}


dispatchMain()
