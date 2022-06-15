import Foundation
import PaylikeCurrencies

/**
 Describes a payment amount used in the Paylike ecosystem
 */
public struct PaymentAmount : Equatable, Codable {
    /**
        Important to notice: this is not a mathematical equation
     */
    public static func == (lhs: PaymentAmount, rhs: PaymentAmount) -> Bool {
        return lhs.currency.code == rhs.currency.code && lhs.value == rhs.value && lhs.exponent == rhs.exponent
    }
    /**
        Currency of the payment
     */
    public let currency: PaylikeCurrency;
    /**
        Value of the amount
     */
    public let value: Int;
    /**
        Exponent of the amount
     */
    public let exponent: Int;
}
