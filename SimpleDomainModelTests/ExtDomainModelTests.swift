//
//  ExtDomainModelTests.swift
//  SimpleDomainModel
//
//  Created by Brandon Chen on 4/12/17.
//  Copyright © 2017 Ted Neward. All rights reserved.
//

import XCTest


class ExtDomainModelTests: XCTestCase {
    func testDescriptions() { // test descriptions
        let usd10 = Money(amount: 10, currency: Currency.USD)
        let can15 = Money(amount: 15, currency: Currency.CAN)
        let eur13 = Money(amount: 13, currency: Currency.EUR)
        let gbp99 = Money(amount: 99, currency: Currency.GBP)
        
        XCTAssert(usd10.description == "USD10.0")
        XCTAssert(can15.description == "CAN15.0")
        XCTAssert(eur13.description == "EUR13.0")
        XCTAssert(gbp99.description == "GBP99.0")
    }
    
    func testMath() { // test add and subtract
        let usd10 = Money(amount: 10, currency: Currency.USD)
        let can15 = Money(amount: 15, currency: Currency.CAN)
        let eur13 = Money(amount: 13, currency: Currency.EUR)
        let gbp99 = Money(amount: 99, currency: Currency.GBP)
        
        let USD10subtractCAN15 = usd10.subtract(can15) // should be -3 can
        let USD10addUSD10 = usd10.add(usd10) // should be 20 usd
        let eur13subtractgbp99 = eur13.subtract(gbp99)
        XCTAssert(USD10addUSD10.description == "USD20.0")
        XCTAssert(USD10subtractCAN15.description == "CAN-3.0")
        XCTAssert(eur13subtractgbp99.description == "GBP-95.0")
    }
    
    func testDoubleExtension() { // test if double extension for currency works
        let usd10 = Money(amount: 10, currency: Currency.USD)
        let usd10extension = 10.0.USD
        let eur13 = Money(amount: 13, currency: Currency.EUR)
        let gbp99 = Money(amount: 99, currency: Currency.GBP)
        let eur13subtractgbp99 = eur13.subtract(gbp99)
        let eur13subtractgbp99extension = (-95).GBP
        XCTAssert(usd10.description == usd10extension.description)
        XCTAssert(eur13subtractgbp99.description == eur13subtractgbp99extension.description)
        
    }
}
