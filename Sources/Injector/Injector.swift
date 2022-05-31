import Foundation
import Resolver

public enum Environment {
    public static var resolve: Environment {
        let process = ProcessInfo.processInfo
        if process.environment["XCTestConfigurationFilePath"] != nil || NSClassFromString("XCTest") != nil {
            return .unitTest
        } else if process.arguments.contains("-ui_testing") {
            return .uiTest
        } else if process.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            return .swiftUIPreview
        } else {
            return .live
        }
    }
    
    case unitTest
    case uiTest
    case swiftUIPreview
    case live
}

public struct Injector {
    
    private static let resolver = Resolver()
    private static let cache = ResolverScopeCache()
    
    public static func setup(_ handler: (Injector) -> ()) {
        cache.reset()
        handler(Injector())
    }
    
    public func register<P>(
        _ live: @escaping @autoclosure () -> P,
        unitTest: @escaping @autoclosure () -> P,
        uiTest: (() -> P)? = nil,
        swiftUIPreview: (() -> P)? = nil,
        for p: P.Type,
        environment: Environment = .resolve) {
        switch environment {
        case .unitTest:
            Self.resolver.register { unitTest() as P }.scope(Self.cache)
        case .uiTest:
            if let uiTest = uiTest {
                Self.resolver.register { uiTest() as P }.scope(Self.cache)
            } else {
                Self.resolver.register { unitTest() as P }.scope(Self.cache)
            }
        case .swiftUIPreview:
            if let swiftUIPreview = swiftUIPreview {
                Self.resolver.register { swiftUIPreview() as P }.scope(Self.cache)
            } else {
                Self.resolver.register { unitTest() as P }.scope(Self.cache)
            }
//            Self.resolver.register { unitTest() as P }.scope(Self.cache)
        case .live:
            Self.resolver.register { live() as P }.scope(Self.cache)
        }
    }
    
    public static func inject<T>(_ type: T.Type) -> T {
        resolver.resolve()
    }
}

public func inject<T>(_ type: T.Type) -> T {
    Injector.inject(type)
}
