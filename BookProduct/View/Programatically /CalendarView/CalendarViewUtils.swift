//
//  CalendarViewUtils.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 31/10/22.
//

import Foundation

class CalendarViewUtils: NSObject {

    static let instance = CalendarViewUtils()
    
    let calendar: Calendar
    
    override init() {
        var calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        calendar.timeZone = TimeZone.autoupdatingCurrent
        self.calendar = calendar
        super.init()
    }
}
