import Vapor
import FluentMySQL

/// Called before your application initializes.
public func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {
    // Register providers first
    try services.register(FluentMySQLProvider())

    // Register routes to the router
    let router = EngineRouter.default()
    try routes(router)
    services.register(router, as: Router.self)

    // Register middleware
    var middlewares = MiddlewareConfig() // Create _empty_ middleware config
    // middlewares.use(FileMiddleware.self) // Serves files from `Public/` directory
    middlewares.use(ErrorMiddleware.self) // Catches errors and converts to HTTP response
    services.register(middlewares)

//    // Configure a SQLite database
//    let sqlite = try SQLiteDatabase(storage: .memory)
//
//    // Register the configured SQLite database to the database config.
//    var databases = DatabasesConfig()
//    databases.add(database: sqlite, as: .sqlite)
//    services.register(databases)
//
//    // Configure migrations
//    var migrations = MigrationConfig()
//    migrations.add(model: Todo.self, database: .sqlite)
//    services.register(migrations)

    let mysqlHost: String
    let mysqlPort: Int
    let mysqlDB: String
    let mysqlUser: String
    let mysqlPass: String

    if env == .development || env == .testing {
        print("under development")
        mysqlHost = "mysql"
        mysqlPort = 3306
        mysqlDB = "vapor"
        mysqlUser = "vapor"
        mysqlPass = "vapor"
    } else {
        print("under production")
        mysqlHost = Environment.get("MYSQL_HOST") ?? "mysql"
        mysqlPort = 3306
        mysqlDB = Environment.get("MYSQL_DB") ?? "vapor"
        mysqlUser = Environment.get("MYSQL_USER") ?? "vapor"
        mysqlPass = Environment.get("MYSQL_PASS") ?? "vapor"
    }

    // 1. 配置 MySQL
    var databases = DatabasesConfig()
    let mysqlConfig = MySQLDatabaseConfig(
        hostname: mysqlHost,
        port: mysqlPort,
        username: mysqlDB,
        password: mysqlUser,
        database: mysqlPass,
        transport: .unverifiedTLS)
    let mysqlDatabase = MySQLDatabase(config: mysqlConfig)
    databases.add(database: mysqlDatabase, as: .mysql)
    services.register(databases)

    // 2. 创建 model

    // 3. 创建 migration

    // 4. 注册 migration
    var migrations = MigrationConfig()

    Forum.defaultDatabase = .mysql
    migrations.add(migration: CreateForumTable.self, database: .mysql)
    migrations.add(model: Message.self, database: .mysql)

//    migrations.add(model: Forum.self, database: .mysql)

    if env == .development {
        migrations.add(migration: ForumSeeder.self, database: .mysql)
        migrations.add(migration: MessageSeeder.self, database: .mysql)
    }


    services.register(migrations)

    // 5. 给 vapor 添加 fluent 命令
    var commandConfig = CommandConfig.default()
    commandConfig.useFluentCommands()
    services.register(commandConfig)

    // 6. 执行 migration
}
