import XCTest
@testable import PaylikeMoney
import PaylikeCurrencies

final class PaylikeMoneyTests: XCTestCase {
    func testExample() throws {
        print(CurrencyCode.EUR)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PaylikeMoney().text, "Hello, World!")
    }
}
