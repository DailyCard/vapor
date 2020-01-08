//
//  Message.swift
//  App
//
//  Created by roni on 2020/1/8.
//

import Foundation
import Fluent
import Vapor
import FluentMySQL

struct Message: Content, MySQLModel {
    var id: Int?
    var forumId: Int
    var title: String
    var content: String
    var originId: Int
    var author: String
    var createdAt: Date
}
