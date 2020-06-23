
import Leaf
import Vapor
import FluentSQLite
/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(LeafProvider())
    config.prefer(LeafRenderer.self, for: ViewRenderer.self)
    
    try services.register(FluentSQLiteProvider())
    
    //let sqlite = try SQLiteDatabase(storage: .memory)
    
    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)
    
    let directoryConfig = DirectoryConfig.detect()
    services.register(directoryConfig)
    
    var databases = DatabasesConfig()
    let db = try SQLiteDatabase(storage: .file(path: "\(directoryConfig.workDir)vapor.db"))
    
    
    databases.add(database: db, as: .sqlite)
    services.register(databases)
    
    var migrationConfig = MigrationConfig()
    migrationConfig.add(model: Category.self, database: DatabaseIdentifier<Category.Database>.sqlite)
//    migrationConfig.add(migration: PopulateCategories.self, database: DatabaseIdentifier<PopulateCategories.Database>.sqlite)
    services.register(migrationConfig)
}
