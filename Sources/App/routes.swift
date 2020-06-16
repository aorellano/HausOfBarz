import Routing
import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    router.get { req in
        return try req.view().render("home")
    }
    
    // Example of configuring a controller
    let categoryController = CategoryController()
    router.get("categories", use: categoryController.list)
    router.post("categories", use: categoryController.create)
    router.patch("categories", Category.parameter, use: categoryController.update)
    router.delete("categories", Category.parameter, use: categoryController.delete)
}
