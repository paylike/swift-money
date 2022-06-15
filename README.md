# PaylikeMoney

Small utility library to help working with payment amounts inside the Paylike ecosystem

## Features

Currently this package only supports a fraction of our JavaScript library. We may extend functionality later.

## Install

__SPM__:
```swift
// dependencies: 
.package(url: "git@github.com:paylike/swift-money.git", .upToNextMajor(from: "0.1.0")

// target:
.product(name: "PaylikeMoney", package: "swift-money")
```

__Cocoapods__:
https://cocoapods.org/pods/PaylikeMoney
```ruby
pod 'PaylikeMoney'
```

## Usage

Check [PaylikeCurrencies](https://github.com/paylike/swift-currencies) for our supported currencies

```swift
let eur = PaylikeCurrencies.byCode(CurrencyCode.EUR)

// Create from double
let amount = PaylikeMoney.fromDouble(currency: eur, n: 0.01) // EUR 0.01

// Create by hand
let amount2 = PaymentAmount(currency: eur, value: 1, exponent: 0) // EUR 1

amount.toString() // "EUR 0.01"

amount.toString(opts: PaymentAmountStringOptions(currency: false)) // "0.01"
amount.toString(opts: PaymentAmountStringOptions(padFractions: 3)) // "EUR 0.010"
amount.toString(opts: PaymentAmountStringOptions(padIntegers: 2)) // "EUR   0.01"
```

