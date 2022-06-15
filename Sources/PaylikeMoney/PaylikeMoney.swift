import Foundation
import PaylikeCurrencies
/**
    Responsible for creating and manipulating payment amounts
 */
public struct PaylikeMoney {
    /**
     Maximum integer that can be used (originates from JS limitations)
     */
    static let maxInt = Int64(9007199254740991)
    /**
     Checks if the input parameter is in the safe range or not
     */
    static func isInSafeRange(n: Decimal) -> Bool {
        return n <= Decimal(maxInt) && n >= Decimal(-maxInt)
    }
    
    /**
        Allows the conversion from double to PaymentAmount
     */
    public static func fromDouble(currency: PaylikeCurrency, n: Double) throws -> PaymentAmount {
        if !n.isFinite {
            throw MoneyError.UnsafeNumber(number: n)
        }
        if (!isInSafeRange(n: Decimal(n))) {
            throw MoneyError.UnsafeNumber(number: n)
        }
        let splitted = n.description.split(separator: ".")
        let wholes = splitted[0];
        let somes = splitted.count > 1 ? splitted[1] : "";
        guard let value = Int(wholes + somes) else {
            throw MoneyError.UnsafeNumber(number: n)
        }
        return PaymentAmount(
            currency: currency,
            value: value,
            exponent: value == 0 ? 0 : somes.count);
    }
}
