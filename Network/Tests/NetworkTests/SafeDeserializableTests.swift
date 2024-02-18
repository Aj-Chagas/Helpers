import XCTest

@testable import Network

final class SafeDeserializableTests: XCTestCase {
    func test_initialize_from_json_should_return_correct_object_without_throwing_error() {
        let sut = makeSut()

        XCTAssertEqual(sut.credentials.count, 3)
        XCTAssertTrue(sut.missingCredentials.isEmpty)

        // Item 1
        XCTAssertEqual(sut.credentials[0].title, "Title")
        XCTAssertTrue(sut.credentials[0].isValid)
        XCTAssertEqual(sut.credentials[0].descripton, "Description")
        XCTAssertEqual(sut.credentials[0].price, 101)

        // Item 2
        XCTAssertEqual(sut.credentials[1].title, "Title3")
        XCTAssertTrue(sut.credentials[1].isValid)
        XCTAssertNil(sut.credentials[2].descripton)
        XCTAssertEqual(sut.credentials[1].price, 104)

        // Item 3
        XCTAssertEqual(sut.credentials[2].title, "Title6")
        XCTAssertTrue(sut.credentials[2].isValid)
        XCTAssertNil(sut.credentials[2].descripton)
        XCTAssertEqual(sut.credentials[2].price, 106)
    }
}

extension SafeDeserializableTests {
    func makeSut() -> SafeDeserializableSample {
        let data = try! Data(contentsOf: Bundle.module.url(forResource: "Some", withExtension: "json")!)
        let model: SafeDeserializableSample = data.toModel()!
        return model
    }
}
