//
//  20-01-08-CreateMessageTable.swift
//  App
//
//  Created by roni on 2020/1/8.
//

import Foundation
import Fluent
import FluentMySQL

extension Message: Migration {
    typealias Database = MySQLDatabase
    
    static func prepare(
        on connection: MySQLConnection) -> Future<Void> {
        return Database.create(Message.self, on: connection) {
            builder in
            try addProperties(to: builder)
        }
    }

    static func revert(
        on connection: MySQLConnection) -> Future<Void> {
        return Database.delete(Message.self, on: connection)
    }
}
