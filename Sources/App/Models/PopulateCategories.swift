//
//  PopulateCategories.swift
//  App
//
//  Created by Alexis Orellano on 6/15/20.
//

import FluentSQLite

final class PopulateCategories: Migration {
    typealias Database = SQLiteDatabase
    
    static let categoryNames = [
        "Tops",
        "Outwear",
        "Joggers",
        "Shorts",
        "Workout Sets",
        "Sports Bras",
        "Leggings",
        "Swimwear",
        "Accessories"
    ]
    
    static func prepare(on connection: SQLiteConnection) -> Future<Void> {
        let futures = categoryNames.map { name in
            return Category(name: name).create(on: connection).map(to: Void.self) { _ in return }
        }
        return Future<Void>.andAll(futures, eventLoop: connection.eventLoop)
    }
    
    static func revert(on connection: SQLiteConnection) -> Future<Void> {
        do {
            let futures = try categoryNames.map { name in
                return try Category.query(on: connection).filter(\Category.name == name).delete()
        }
            return Future<Void>.andAll(futures, eventLoop: connection.eventLoop)
        } catch {
            return connection.eventLoop.newFailedFuture(error: error)
        }
    }
}
