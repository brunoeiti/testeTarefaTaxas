//
//  Extensoes.swift
//  Taxas
//
//  Created by Bruno on 11/7/15.
//  Copyright © 2015 Bruno Hassunuma. All rights reserved.
//

import Foundation
// MARK: NSDate
extension NSDate{
    
    
    class func from(year year:Int, month:Int, day:Int) -> NSDate? {
        let c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day
        var gregorian:NSCalendar!
        if #available(iOS 8.0, *) {
            gregorian = NSCalendar(identifier:NSGregorianCalendar)
        } else {
            gregorian = NSCalendar(calendarIdentifier: NSGregorianCalendar)
        }
        let date = gregorian!.dateFromComponents(c)
        return date
    }
    
    func getString(formato:String)->String{
        let f = NSDateFormatter()
        f.locale = NSLocale(localeIdentifier: "pt")
        f.dateFormat = formato
        let str = f.stringFromDate(self)
        return str
    }
    
    func dateDiff(outraData:NSDate, unidade:NSCalendarUnit)->NSDateComponents{
        let cal = NSCalendar.currentCalendar()
        let components = cal.components(unidade, fromDate: self, toDate: outraData, options: NSCalendarOptions.MatchFirst)
        return components
    }
    
    static func fromString(dt:String, formato:String)->NSDate? {
        let f = NSDateFormatter()
        //deixa mes por extenso no formato portugues sempre
        f.locale = NSLocale(localeIdentifier: "pt")
        f.dateFormat = formato
        return f.dateFromString(dt)
    }
    
    
    
}

// MARK: String





// MARK: NSDecimalNumber


extension NSDecimalNumber: Comparable {}

extension NSDecimalNumber{
    
    func getMonetarioString()->String?{
        let f = NSNumberFormatter()
        f.locale = NSLocale(localeIdentifier: "pt-br")
        f.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        
        return f.stringFromNumber(self)
    }
    
}

public func ==(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}


public prefix func -(value: NSDecimalNumber) -> NSDecimalNumber {
    return value.decimalNumberByMultiplyingBy(NSDecimalNumber(mantissa: 1, exponent: 0, isNegative: true))
}

public func +(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberByAdding(rhs)
}

public func -(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberBySubtracting(rhs)
}

public func *(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberByMultiplyingBy(rhs)
}

public func /(lhs: NSDecimalNumber, rhs: NSDecimalNumber) -> NSDecimalNumber {
    return lhs.decimalNumberByDividingBy(rhs)
}

public func ^(lhs: NSDecimalNumber, rhs: Int) -> NSDecimalNumber {
    return lhs.decimalNumberByRaisingToPower(rhs)
}