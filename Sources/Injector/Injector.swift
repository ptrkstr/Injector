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
    
    public static func setup(_ handler: (Injector) -> ()) {
        Resolver.reset()
        Resolver.defaultScope = .application
        handler(Injector())
    }
    
    public func register<P>(_ real: @escaping @autoclosure () -> P, mock: @escaping @autoclosure () -> P, for p: P.Type, environment: Environment = .resolve) {
        switch environment {
        case .unitTest, .swiftUIPreview:
            Resolver.register { mock() as P }
        case .real:
            Resolver.register { real() as P }
        }
    }
}

public func inject<T>(_ type: T.Type) -> T {
    Resolver.root.resolve()
}
