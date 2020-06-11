//
//  Category.swift
//  App
//
//  Created by Alexis Orellano on 6/10/20.
//

import Vapor
import FluentMySQL

final class Category: Codable {
    var id: Int?
    var name: String
    var description: String
    var thumbnail: String
    
    init(name: String, description: String, thumbnail: String) {
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
    }
}

extension Category: MySQLModel {}
extension Category: Migration {}
extension Category: Content {}
extension Category: Parameter {}
