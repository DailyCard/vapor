//
//  Forum.swift
//  App
//
//  Created by roni on 2019/12/31.
//

import Foundation
import Vapor
import Fluent
import FluentMySQL

struct Forum: Content, MySQLModel, Migration {
    var id: Int?
    var name: String
    init(id: Int?, name: String) {
        self.id = id
        self.name = name
    }

    init(name: String) {
        self.init(id: nil, name: name)
    }
}
