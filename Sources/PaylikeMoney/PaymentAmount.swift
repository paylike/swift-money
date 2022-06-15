import Foundation
import PaylikeCurrencies

/**
 Describes the string representation options for PaymentAmount
 */
public struct PaymentAmountStringOptions {
    public init(padIntegers: Int = 0, padFractions: Int = 0, currency: Bool = true) {
        self.padIntegers = padIntegers
        self.padFractions = padFractions
        self.currency = currency
    }
    /**
     Describes padding for the integers
     */
    public let padIntegers: Int;
    
    /**
     Describes padding for the fractions
     */
    public let padFractions: Int;
    
    /**
     Indicates to include currency or not
     */
    public let currency: Bool;
}

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
    
    /**
     Provides a handy way to represent the amount as a string
     */
    public func toString(opts: PaymentAmountStringOptions = PaymentAmountStringOptions()) -> String {
        var wholes, somes: String
        let negative = value < 0
        let integer = String(negative ? -value : value)
        if exponent <= 0 {
            wholes = integer + "".padding(toLength: -exponent, withPad: "0", startingAt: 0)
            somes = ""
        }
        else if integer.count <= exponent {
            wholes = "0"
            somes = "".padding(toLength: exponent - integer.count, withPad: "0", startingAt: 0) + integer
        } else {
            let dividerIndex = integer.index(integer.startIndex, offsetBy: integer.count - exponent)
            var range = integer.startIndex..<dividerIndex
            wholes = String(integer[range])
            range = dividerIndex..<integer.endIndex
            somes = String(integer[range])
        }
        let paddedWholes = "".padding(toLength: opts.padIntegers, withPad: " ", startingAt: 0) + wholes
        let paddedSomes = opts.padFractions > 0 ? somes +  "".padding(toLength: abs(somes.count - opts.padFractions), withPad: "0", startingAt: 0) : somes
        let currencyString = opts.currency ? currency.code + " " : ""
        return (currencyString +
                (negative ? "-" : "") +
                paddedWholes +
                (paddedSomes == "" ? "" : "." + paddedSomes));
        
    }
}
