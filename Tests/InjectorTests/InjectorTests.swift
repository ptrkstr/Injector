import XCTest
@testable import Injector

protocol ObjectType {
    var id: String { get set }
}
class Object: ObjectType {
    var id: String = ""

    init(id: String) {
        self.id = id
    }
}

final class InjectorTests: XCTestCase {

    func test_clean() {
        let medicine = Medicine<ObjectType>(Object(id: ""))

        var person = medicine.inject()
        XCTAssertEqual(person.id, "")
        person.id = "alex"

        person = medicine.inject()
        XCTAssertEqual(person.id, "alex")
        Syringe.clean()

        person = medicine.inject()
        XCTAssertEqual(person.id, "")
    }

    func test_environmentReal() throws {
        let medicine = Medicine<ObjectType>(Object(id: "real"), environment: .real)
        let person = medicine.inject()
        XCTAssertEqual(person.id, "real")
    }

    func test_environmentUnitTest() throws {
        let medicine = Medicine<ObjectType>(Object(id: "real"), mock: Object(id: "mock"), environment: .unitTest)
        let person = medicine.inject()
        XCTAssertEqual(person.id, "mock")
    }

    func test_environmentUiTest() throws {
        let medicine = Medicine<ObjectType>(Object(id: "real"), mock: Object(id: "mock"), environment: .uiTest)
        let person = medicine.inject()
        XCTAssertEqual(person.id, "mock")
    }

    func test_environmentSwiftUIPreview() throws {
        let medicine = Medicine<ObjectType>(Object(id: "real"), mock: Object(id: "mock"), environment: .swiftUIPreview)
        let person = medicine.inject()
        XCTAssertEqual(person.id, "mock")
    }

    func test_fullInitializer() throws {
        let map: [InjectorEnvironment: ObjectType] = [
            .unitTest: Object(id: "unitTest"),
            .uiTest: Object(id: "uiTest"),
            .swiftUIPreview: Object(id: "preview"),
            .real: Object(id: "real")
        ]
        map.forEach { pair in
            let medicine = Medicine<ObjectType>(
                Object(id: "real"),
                unitTests: Object(id: "unitTest"),
                uiTests: Object(id: "uiTest"),
                swiftUIPreview: Object(id: "preview"),
                environment: pair.key
            )
            let person = medicine.inject()
            XCTAssertEqual(person.id, pair.value.id)
        }
    }

    func test_environmentResolve() throws {
        let medicine = Medicine<ObjectType>(Object(id: "real"), mock: Object(id: "mock"))
        let person = medicine.inject()
        XCTAssertEqual(person.id, "mock")
    }
}
