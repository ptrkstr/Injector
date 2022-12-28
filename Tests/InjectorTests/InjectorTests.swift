import XCTest
@testable import Injector

protocol PersonType {
    var name: String { get set }
}
class Person: PersonType {
    var name: String = ""
}
class Person_Mock: PersonType {
    var name: String = ""
}

final class InjectorTests: XCTestCase {

    func test_clean() {
        let medicine = Medicine<PersonType>(Person())

        var person = medicine.inject()
        XCTAssertEqual(person.name, "")
        person.name = "alex"

        person = medicine.inject()
        XCTAssertEqual(person.name, "alex")
        Syringe.clean()

        person = medicine.inject()
        XCTAssertEqual(person.name, "")
    }

    func test_environmentReal() throws {
        let medicine = Medicine<PersonType>(Person(), environment: .real)
        let person = medicine.inject()
        XCTAssertTrue(person is Person)
    }

    func test_environmentUnitTest() throws {
        let medicine = Medicine<PersonType>(Person(), mock: Person_Mock(), environment: .unitTest)
        let person = medicine.inject()
        XCTAssertTrue(person is Person_Mock)
    }

    func test_environmentUiTest() throws {
        let medicine = Medicine<PersonType>(Person(), mock: Person_Mock(), environment: .uiTest)
        let person = medicine.inject()
        XCTAssertTrue(person is Person_Mock)
    }

    func test_environmentSwiftUIPreview() throws {
        let medicine = Medicine<PersonType>(Person(), mock: Person_Mock(), environment: .swiftUIPreview)
        let person = medicine.inject()
        XCTAssertTrue(person is Person_Mock)
    }

    func test_environmentResolve() throws {
        let medicine = Medicine<PersonType>(Person(), mock: Person_Mock())
        let person = medicine.inject()
        XCTAssertTrue(person is Person_Mock)
    }
}
