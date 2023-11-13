import Foundation
import Factory

public enum InjectorEnvironment {
    public static var resolve: InjectorEnvironment {
        let process = ProcessInfo.processInfo
        if process.environment["XCTestConfigurationFilePath"] != nil || NSClassFromString("XCTest") != nil {
            return .unitTest
        } else if process.arguments.contains("-ui_testing") {
            return .uiTest
        } else if process.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            return .swiftUIPreview
        } else {
            return .real
        }
    }

    case unitTest
    case uiTest
    case swiftUIPreview
    case real
}

public enum Syringe {
    /// Removes all dependency registrations.
    public static func clean() {
        Container.Scope.cache.reset()
    }
}

private extension Container.Scope {
    static let cache = Cached()
}

public struct Medicine<T> {

    private let factory: Factory<T>

    /// Creates a `Medicine`.
    /// - Parameters:
    ///   - real: The real instance of `T`.
    ///   - mock: Used for unit tests, ui tests and SwiftUI previews.
    ///   - environment: The current `Environment`. Most cases you'll want to let it resolve itself.
    public init(
        _ real: @escaping @autoclosure () -> T,
        environment: InjectorEnvironment = .resolve
    ) {
        self.init(real(), unitTests: real(), uiTests: real(), swiftUIPreview: real(), environment: environment)
    }

    /// Creates a `Medicine`.
    /// - Parameters:
    ///   - real: The real instance of `T`.
    ///   - mock: Used for unit tests, ui tests and SwiftUI previews.
    ///   - environment: The current `Environment`. Most cases you'll want to let it resolve itself.
    public init(
        _ real: @escaping @autoclosure () -> T,
        mock: @escaping @autoclosure () -> T,
        environment: InjectorEnvironment = .resolve
    ) {
        self.init(real(), unitTests: mock(), uiTests: mock(), swiftUIPreview: mock(), environment: environment)
    }

    /// Creates a `Medicine`.
    /// - Parameters:
    ///   - real: The real instance of `T`.
    ///   - tests: Used for unit tests and ui tests.
    ///   - swiftUIPreview: Used for SwiftUI previews.
    ///   - environment: The current `Environment`. Most cases you'll want to let it resolve itself.
    public init(
        _ real: @escaping @autoclosure () -> T,
        tests: @escaping @autoclosure () -> T,
        swiftUIPreview: @escaping @autoclosure () -> T,
        environment: InjectorEnvironment = .resolve
    ) {
        self.init(real(), unitTests: tests(), uiTests: tests(), swiftUIPreview: swiftUIPreview(), environment: environment)
    }

    /// Creates a `Medicine`.
    /// - Parameters:
    ///   - real: The real instance of `T`.
    ///   - unitTests: Used for unit tests.
    ///   - uiTests: Used for ui tests.
    ///   - swiftUIPreview: Used for SwiftUI previews.
    ///   - environment: The current `Environment`. Most cases you'll want to let it resolve itself.
    public init(
        _ real: @escaping @autoclosure () -> T,
        unitTests: @escaping @autoclosure () -> T,
        uiTests: @escaping @autoclosure () -> T,
        swiftUIPreview: @escaping @autoclosure () -> T,
        environment: InjectorEnvironment = .resolve
    ) {
        factory = {
            switch environment {
            case .unitTest:
                return .init(scope: .cache, factory: unitTests)
            case .uiTest:
                return .init(scope: .cache, factory: uiTests)
            case .swiftUIPreview:
                return .init(scope: .cache, factory: swiftUIPreview)
            case .real:
                return .init(scope: .cache, factory: real)
            }
        }()
    }

    /// Resolves and returns an instance of the desired object type. This may be a new instance or one that was created previously and then cached.
    public func inject() -> T {
        callAsFunction()
    }

    /// Resolves and returns an instance of the desired object type. This may be a new instance or one that was created previously and then cached.
    public func callAsFunction() -> T {
        factory()
    }
}

@propertyWrapper
public struct Inject<T> {
    private var dependency: T
    public init(_ medicine: Medicine<T>) {
        self.dependency = medicine()
    }
    public var wrappedValue: T {
        get { return dependency }
        mutating set { dependency = newValue }
    }
}
