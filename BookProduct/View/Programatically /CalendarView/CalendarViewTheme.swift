//
//  CalendarViewTheme.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 31/10/22.
//

import UIKit

open class CalendarViewTheme {

    public init() {
    }

    open var bgColorForMonthContainer = UIColor.white
    open var bgColorForDaysOfWeekContainer = UIColor.white
    open var bgColorForCurrentMonth = UIColor.white
    open var bgColorForOtherMonth = UIColor.white
    open var colorForDivider = UIColor(hex: 0xCFCFCF)
    open var colorForSelectedDate = UIColor(hex: 0x7651E4)
    open var colorForDatesRange = UIColor(hex: 0x7651E4, alpha: 0.1)
    open var textColorForTitle = UIColor(hex: 0x334D63)
    open var textColorForDayOfWeek = UIColor(hex: 0x334D63)
    open var textColorForNormalDay = UIColor(hex: 0x334D63)
    open var textColorForDisabledDay = UIColor(hex: 0xB6BCC2)
    open var textColorForSelectedDay = UIColor.white
}

extension UIColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}
