//
//  CategoryController.swift
//  App
//
//  Created by Alexis Orellano on 6/15/20.
//

import Vapor

final class CategoryController {
    func list(_ req: Request) throws -> Future<[Category]> {
        return Category.query(on: req).all()
    }

    func create(_ req: Request) throws -> Future<Category> {
        return try req.content.decode(Category.self).flatMap { category in
            return category.save(on: req)
        }
    }
    
    func update(_ req: Request) throws -> Future<Category> {
        return try req.parameters.next(Category.self).flatMap { category in
            return try req.content.decode(Category.self).flatMap { newCategory in
                category.name = newCategory.name
                return category.save(on: req)
            }
        }
    }
    
    func delete(_ req: Request) throws -> Future<HTTPStatus> {
        return try req.parameters.next(Category.self).flatMap { category in
            return category.delete(on: req)
        }.transform(to: .ok)
    }
}
