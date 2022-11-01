//
//  CalendarViewDelegate.swift
//  BookProduct
//
//  Created by Iftiquar Ahmed Ove on 31/10/22.
//
import Foundation

public protocol CalendarViewDelegate {
    
    func calendarView(_ calendarView: CalendarView, didUpdateBeginDate beginDate: Date?)
    func calendarView(_ calendarView: CalendarView, didUpdateFinishDate finishDate: Date?)
}
