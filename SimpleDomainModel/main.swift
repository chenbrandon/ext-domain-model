//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

public func testMe() -> String {
    return "I have been tested"
}

open class TestMe {
    open func Please() -> String {
        return "I have been tested"
    }
}
public enum Currency: String {
    case USD = "USD"
    case GBP = "GBP"
    case EUR = "EUR"
    case CAN = "CAN"
}

////////////////////////////////////
// Money
//
public struct Money {
    public var amount : Int
    public var currency : Currency
    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = Currency(rawValue: currency)!
    }
    public func convert(_ to: String) -> Money {
        var money: Int
        switch self.currency { // change money USD
        case .USD:
            money = self.amount
        case .GBP:
            money = self.amount * 2
        case .CAN:
            money = self.amount * 4 / 5
        case .EUR:
            money = self.amount * 2 / 3
        }
        switch Currency(rawValue: to)! {
        case .GBP:
            return Money(amount: money / 2, currency: to)
        case .EUR:
            return Money(amount: money * 3 / 2, currency: to)
        case .CAN:
            return Money(amount: money * 5 / 4, currency: to)
        case .USD:
            return Money(amount: money, currency: to)
        }
    }
    public func add(_ to: Money) -> Money {
        let money = (self.convert(to.currency.rawValue)).amount
        return Money(amount: money + to.amount, currency: to.currency.rawValue)
    }
    
    public func subtract(_ from: Money) -> Money {
        let money = (self.convert(from.currency.rawValue)).amount
        return Money(amount: money + from.amount, currency: from.currency.rawValue)
    }
}


////////////////////////////////////
// Job
//
open class Job {
    fileprivate var title : String
    fileprivate var type : JobType
    
    public enum JobType {
        case Hourly(Double)
        case Salary(Int)
    }
    
    public init(title : String, type : JobType) {
        self.title = title
        self.type = type
    }
    
    open func calculateIncome(_ hours: Int) -> Int {
        switch self.type {
        case .Hourly (let hourly) :
            return Int((hourly) * Double(hours))
        case .Salary (let salary) :
            return salary
        }
    }
    
    open func raise(_ amt : Double) {
        switch self.type {
        case .Hourly(let pay):
            self.type = JobType.Hourly(pay + amt)
        case .Salary(let pay):
            self.type = JobType.Salary(pay + Int(amt))
        }
    }
}

////////////////////////////////////
// Person
//
open class Person {
    open var firstName : String = ""
    open var lastName : String = ""
    open var age : Int = 0
    
    fileprivate var _job : Job? = nil
    open var job : Job? {
        get { return _job }
        set(value) {
            if self.age >= 16 {
                _job = value
            }
        }
    }
    
    fileprivate var _spouse : Person? = nil
    open var spouse : Person? {
        get { return _spouse }
        set(value) {
            if (self.age >= 18) {
                _spouse = value
            }
        }
    }
    
    public init(firstName : String, lastName: String, age : Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    open func toString() -> String {
        return "[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(String(describing: job)) spouse:\(String(describing: spouse))]"
    }
}

////////////////////////////////////
// Family
//
open class Family {
    fileprivate var members : [Person] = []
    
    public init(spouse1: Person, spouse2: Person) {
        if let _ = spouse1.spouse, let _ = spouse2.spouse {
            
        } else {// no spouse, safe to set
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            self.members.append(spouse1)
            self.members.append(spouse2)
        }
    }
    
    open func haveChild(_ child: Person) -> Bool {
        for p in self.members {
            let a = p.age
            if a >= 21 { // person over 21, safe to have baby
                child.age = 0
                self.members.append(child)
                return true // child added
            }
        }
        return false // child not added
    }
    
    open func householdIncome() -> Int {
        var sum = 0
        for p in self.members {
            if let j = p.job { // person has a job (safely check value)
                sum += j.calculateIncome(2000) // add job value
            }
        }
        return sum // return sum
    }
}





