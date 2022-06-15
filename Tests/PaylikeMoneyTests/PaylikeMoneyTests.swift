import XCTest
@testable import PaylikeMoney
import PaylikeCurrencies

final class PaylikeMoneyTests: XCTestCase {
    let eur = PaylikeCurrencies.byCode(code: CurrencyCode.EUR)
    func testFromDouble() throws {
        XCTAssertEqual(try PaylikeMoney.fromDouble(currency: eur, n: 0),
                       PaymentAmount(currency: eur, value: 0, exponent: 0))
        XCTAssertEqual(try PaylikeMoney.fromDouble(currency: eur, n: -0),
                       PaymentAmount(currency: eur, value: 0, exponent: 0))
        XCTAssertEqual(try PaylikeMoney.fromDouble(currency: eur, n: -0.0),
                       PaymentAmount(currency: eur, value: 0, exponent: 0))
        XCTAssertEqual(try PaylikeMoney.fromDouble(currency: eur, n: 1),
                       PaymentAmount(currency: eur, value: 10, exponent: 1))
        XCTAssertEqual(try PaylikeMoney.fromDouble(currency: eur, n: -1),
                       PaymentAmount(currency: eur, value: -10, exponent: 1))
        XCTAssertEqual(try PaylikeMoney.fromDouble(currency: eur, n: 120),
                       PaymentAmount(currency: eur, value: 1200, exponent: 1))
        XCTAssertEqual(try PaylikeMoney.fromDouble(currency: eur, n: 12.0),
                       PaymentAmount(currency: eur, value: 120, exponent: 1))
        XCTAssertEqual(try PaylikeMoney.fromDouble(currency: eur, n: 1.2),
                       PaymentAmount(currency: eur, value: 12, exponent: 1))
        XCTAssertEqual(try PaylikeMoney.fromDouble(currency: eur, n: 0.12),
                       PaymentAmount(currency: eur, value: 12, exponent: 2))
        XCTAssertEqual(try PaylikeMoney.fromDouble(currency: eur, n: 0.012),
                       PaymentAmount(currency: eur, value: 12, exponent: 3))
        XCTAssertThrowsError(try PaylikeMoney.fromDouble(currency: eur, n: 9007199254740992)) { error in
            switch error {
            case MoneyError.UnsafeNumber(number: 9007199254740992):
                break
            default:
                XCTFail("Unexpected error thrown")
            }
        }
    }
    
    func testToString() throws {
        XCTAssertEqual(try PaylikeMoney.fromDouble(currency: eur, n: 0).toString(), "EUR 0")
        XCTAssertEqual(
            PaymentAmount(currency: eur, value: 1, exponent: 0)
                .toString(),
            "EUR 1");
        XCTAssertEqual(
            PaymentAmount(currency: eur, value: -1, exponent: 0)
                .toString(),
            "EUR -1");
        XCTAssertEqual(
            PaymentAmount(currency: eur, value: 1, exponent: 1)
                .toString(),
            "EUR 0.1");
        XCTAssertEqual(
            PaymentAmount(currency: eur, value: -1, exponent: 1)
                .toString(),
            "EUR -0.1");
        XCTAssertEqual(try PaylikeMoney.fromDouble(currency: eur, n: 0.01).toString(), "EUR 0.01");
        XCTAssertEqual(
            PaymentAmount(currency: eur, value: 1, exponent: -1)
                .toString(),
            "EUR 10");
        XCTAssertEqual(
            PaymentAmount(currency: eur, value: 12, exponent: -1)
                .toString(),
            "EUR 120");
        XCTAssertEqual(
            PaymentAmount(currency: eur, value: 12, exponent: 0)
                .toString(),
            "EUR 12");
        XCTAssertEqual(
            PaymentAmount(currency: eur, value: 12, exponent: 1)
                .toString(),
            "EUR 1.2");
        XCTAssertEqual(
            PaymentAmount(currency: eur, value: 12, exponent: 2)
                .toString(),
            "EUR 0.12");
        XCTAssertEqual(
            PaymentAmount(currency: eur, value: 12, exponent: 3)
                .toString(),
            "EUR 0.012");
    }
}
