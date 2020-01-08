//
//  19-12-31-CreateForumTable.swift
//  App
//
//  Created by roni on 2019/12/31.
//

import Foundation
import Fluent
import FluentMySQL

struct CreateForumTable: Migration {
    typealias Database = MySQLDatabase

    static func prepare(on conn: MySQLConnection) -> EventLoopFuture<Void> {
        return Database.create(Forum.self, on: conn, closure: { (builder) in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.name)
        })
    }

    static func revert(on conn: MySQLConnection) -> EventLoopFuture<Void> {
        return Database.delete(Forum.self, on: conn)
    }
}
