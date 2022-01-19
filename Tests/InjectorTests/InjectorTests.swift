import XCTest
@testable import Injector

protocol CarType {}
class Car: CarType {}
class Car_Mock: CarType {}

final class InjectorTests: XCTestCase {
    
    func test_environmentReal() throws {
        Injector.setup {
            $0.register(Car(), mock: Car_Mock(), for: CarType.self, environment: .real)
        }
        
        let car = inject(CarType.self)
        XCTAssertTrue(car is Car)
    }
    
    func test_environmentUnitTest() throws {
        Injector.setup {
            $0.register(Car(), mock: Car_Mock(), for: CarType.self, environment: .unitTest)
        }
        
        let car = inject(CarType.self)
        XCTAssertTrue(car is Car_Mock)
    }
    
    func test_environmentSwiftUIPreview() throws {
        Injector.setup {
            $0.register(Car(), mock: Car_Mock(), for: CarType.self, environment: .swiftUIPreview)
        }
        
        let car = inject(CarType.self)
        XCTAssertTrue(car is Car_Mock)
    }
    
    func test_environmentResolve() throws {
        Injector.setup {
            $0.register(Car(), mock: Car_Mock(), for: CarType.self)
        }
        
        let car = inject(CarType.self)
        XCTAssertTrue(car is Car_Mock)
    }

}
