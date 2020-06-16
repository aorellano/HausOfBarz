//
//  Category.swift
//  App
//
//  Created by Alexis Orellano on 6/10/20.
//

import FluentSQLite
import Vapor

final class Category: Content {
    var id: UUID?
    var name: String
//    var description: String
//    var thumbnail: String
    
    init(name: String) {
        self.name = name
//        self.description = description
//        self.thumbnail = thumbnail
    }
}

extension Category: SQLiteUUIDModel {}
extension Category: Migration {}
extension Category: Parameter {}
