import Foundation
import Resolver

public enum Environment {
    public static var resolve: Environment {
        let process = ProcessInfo.processInfo
        if process.environment["XCTestConfigurationFilePath"] != nil || NSClassFromString("XCTest") != nil {
            return .unitTest
        } else if process.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            return .swiftUIPreview
        } else {
            return .real
        }
    }
    
    case unitTest
    case swiftUIPreview
    case real
}

public struct Injector {
    
    private static let resolver = Resolver()
    private static let cache = ResolverScopeCache()
    
    public static func setup(_ handler: (Injector) -> ()) {
        cache.reset()
        handler(Injector())
    }
    
    public func register<P>(_ real: @escaping @autoclosure () -> P, mock: @escaping @autoclosure () -> P, for p: P.Type, environment: Environment = .resolve) {
        switch environment {
        case .unitTest, .swiftUIPreview:
            Self.resolver.register { mock() as P }.scope(Self.cache)
        case .real:
            Self.resolver.register { real() as P }.scope(Self.cache)
        }
    }
    
    public static func inject<T>(_ type: T.Type) -> T {
        resolver.resolve()
    }
}

public func inject<T>(_ type: T.Type) -> T {
    Injector.inject(type)
}
