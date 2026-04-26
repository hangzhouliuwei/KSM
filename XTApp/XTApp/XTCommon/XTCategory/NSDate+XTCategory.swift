//
//  NSDate+XTCategory.swift
//  XTApp
//
//  Created by Codex on 2026/4/26.
//

import Foundation

private let dMinute: TimeInterval = 60
private let dHour: TimeInterval = 3600
private let dDay: TimeInterval = 86400
private let dWeek: TimeInterval = 604800

@objc
extension NSDate {
    private class func formatter(_ format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC+8")
        formatter.dateFormat = format
        return formatter
    }

    @objc func timeIntervalDescription() -> String {
        let interval = -timeIntervalSinceNow
        if interval < 60 { return NSLocalizedString("NSDateCategory.text1", comment: "") }
        if interval < 3600 { return String(format: NSLocalizedString("NSDateCategory.text2", comment: ""), interval / 60) }
        if interval < 86400 { return String(format: NSLocalizedString("NSDateCategory.text3", comment: ""), interval / 3600) }
        if interval < 2_592_000 { return String(format: NSLocalizedString("NSDateCategory.text4", comment: ""), interval / 86400) }
        if interval < 31_536_000 { return NSDate.formatter(NSLocalizedString("NSDateCategory.text5", comment: "")).string(from: self as Date) }
        return String(format: NSLocalizedString("NSDateCategory.text6", comment: ""), interval / 31_536_000)
    }

    @objc func minuteDescription() -> String {
        let formatter = NSDate.formatter("yyyy-MM-dd")
        let currentDay = formatter.string(from: Date())
        let theDay = formatter.string(from: self as Date)
        if theDay == currentDay {
            formatter.dateFormat = "ah:mm"
            return formatter.string(from: self as Date)
        }
        if let current = formatter.date(from: currentDay),
           let target = formatter.date(from: theDay),
           current.timeIntervalSince(target) == dDay {
            formatter.dateFormat = "ah:mm"
            return String(format: NSLocalizedString("NSDateCategory.text7", comment: ""), formatter.string(from: self as Date))
        }
        formatter.dateFormat = "yyyy-MM-dd ah:mm"
        return formatter.string(from: self as Date)
    }

    @objc func formattedTime() -> String {
        getDateStringByFormat("yyyy-MM-dd HH:mm")
    }

    @objc func formattedDateDescription() -> String {
        getDateStringByFormat("yyyy-MM-dd HH:mm")
    }

    @objc func timeIntervalSince1970InMilliSecond() -> Double {
        timeIntervalSince1970 * 1000
    }

    @objc(dateWithTimeIntervalInMilliSecondSince1970:)
    class func dateWithTimeIntervalInMilliSecondSince1970(_ timeIntervalInMilliSecond: Double) -> NSDate {
        let seconds = timeIntervalInMilliSecond > 140_000_000_000 ? timeIntervalInMilliSecond / 1000 : timeIntervalInMilliSecond
        return NSDate(timeIntervalSince1970: seconds)
    }

    @objc(formattedTimeFromTimeInterval:)
    class func formattedTimeFromTimeInterval(_ time: Int64) -> String {
        dateWithTimeIntervalInMilliSecondSince1970(Double(time)).formattedTime()
    }

    @objc class func dateTomorrow() -> NSDate { dateWithDaysFromNow(1) }
    @objc class func dateYesterday() -> NSDate { dateWithDaysBeforeNow(1) }
    @objc(dateWithDaysFromNow:) class func dateWithDaysFromNow(_ days: Int) -> NSDate { NSDate(timeIntervalSinceNow: dDay * Double(days)) }
    @objc(dateWithDaysBeforeNow:) class func dateWithDaysBeforeNow(_ days: Int) -> NSDate { NSDate(timeIntervalSinceNow: -dDay * Double(days)) }
    @objc(dateWithHoursFromNow:) class func dateWithHoursFromNow(_ hours: Int) -> NSDate { NSDate(timeIntervalSinceNow: dHour * Double(hours)) }
    @objc(dateWithHoursBeforeNow:) class func dateWithHoursBeforeNow(_ hours: Int) -> NSDate { NSDate(timeIntervalSinceNow: -dHour * Double(hours)) }
    @objc(dateWithMinutesFromNow:) class func dateWithMinutesFromNow(_ minutes: Int) -> NSDate { NSDate(timeIntervalSinceNow: dMinute * Double(minutes)) }
    @objc(dateWithMinutesBeforeNow:) class func dateWithMinutesBeforeNow(_ minutes: Int) -> NSDate { NSDate(timeIntervalSinceNow: -dMinute * Double(minutes)) }

    @objc(isEqualToDateIgnoringTime:)
    func isEqual(toDateIgnoringTime date: Date) -> Bool {
        Calendar.current.isDate(self as Date, inSameDayAs: date)
    }

    @objc func isToday() -> Bool { Calendar.current.isDateInToday(self as Date) }
    @objc func isTomorrow() -> Bool { Calendar.current.isDateInTomorrow(self as Date) }
    @objc func isYesterday() -> Bool { Calendar.current.isDateInYesterday(self as Date) }
    @objc(isSameWeekAsDate:) func isSameWeek(as date: Date) -> Bool { Calendar.current.isDate(self as Date, equalTo: date, toGranularity: .weekOfYear) }
    @objc func isThisWeek() -> Bool { isSameWeek(as: Date()) }
    @objc func isNextWeek() -> Bool { isSameWeek(as: Date(timeIntervalSinceNow: dWeek)) }
    @objc func isLastWeek() -> Bool { isSameWeek(as: Date(timeIntervalSinceNow: -dWeek)) }
    @objc(isSameMonthAsDate:) func isSameMonth(as date: Date) -> Bool { Calendar.current.isDate(self as Date, equalTo: date, toGranularity: .month) }
    @objc func isThisMonth() -> Bool { isSameMonth(as: Date()) }
    @objc(isSameYearAsDate:) func isSameYear(as date: Date) -> Bool { Calendar.current.isDate(self as Date, equalTo: date, toGranularity: .year) }
    @objc func isThisYear() -> Bool { isSameYear(as: Date()) }
    @objc func isNextYear() -> Bool { year == NSDate().year + 1 }
    @objc func isLastYear() -> Bool { year == NSDate().year - 1 }
    @objc(isEarlierThanDate:) func isEarlier(than date: Date) -> Bool { compare(date) == .orderedAscending }
    @objc(isLaterThanDate:) func isLater(than date: Date) -> Bool { compare(date) == .orderedDescending }
    @objc func isInFuture() -> Bool { isLater(than: Date()) }
    @objc func isInPast() -> Bool { isEarlier(than: Date()) }
    @objc func isTypicallyWeekend() -> Bool { Calendar.current.isDateInWeekend(self as Date) }
    @objc func isTypicallyWorkday() -> Bool { !isTypicallyWeekend() }

    @objc(dateByAddingDays:) func dateByAddingDays(_ days: Int) -> NSDate { addingTimeInterval(dDay * Double(days)) as NSDate }
    @objc(dateBySubtractingDays:) func dateBySubtractingDays(_ days: Int) -> NSDate { dateByAddingDays(-days) }
    @objc(dateByAddingHours:) func dateByAddingHours(_ hours: Int) -> NSDate { addingTimeInterval(dHour * Double(hours)) as NSDate }
    @objc(dateBySubtractingHours:) func dateBySubtractingHours(_ hours: Int) -> NSDate { dateByAddingHours(-hours) }
    @objc(dateByAddingMinutes:) func dateByAddingMinutes(_ minutes: Int) -> NSDate { addingTimeInterval(dMinute * Double(minutes)) as NSDate }
    @objc(dateBySubtractingMinutes:) func dateBySubtractingMinutes(_ minutes: Int) -> NSDate { dateByAddingMinutes(-minutes) }
    @objc func dateAtStartOfDay() -> NSDate { Calendar.current.startOfDay(for: self as Date) as NSDate }

    @objc(secondAfterDate:) func secondAfterDate(_ date: Date) -> Int { Int(timeIntervalSince(date)) }
    @objc(minutesAfterDate:) func minutesAfterDate(_ date: Date) -> Int { Int(timeIntervalSince(date) / dMinute) }
    @objc(minutesBeforeDate:) func minutesBeforeDate(_ date: Date) -> Int { Int(date.timeIntervalSince(self as Date) / dMinute) }
    @objc(hoursAfterDate:) func hoursAfterDate(_ date: Date) -> Int { Int(timeIntervalSince(date) / dHour) }
    @objc(hoursBeforeDate:) func hoursBeforeDate(_ date: Date) -> Int { Int(date.timeIntervalSince(self as Date) / dHour) }
    @objc(daysAfterDate:) func daysAfterDate(_ date: Date) -> Int { Int(timeIntervalSince(date) / dDay) }
    @objc(daysBeforeDate:) func daysBeforeDate(_ date: Date) -> Int { Int(date.timeIntervalSince(self as Date) / dDay) }
    @objc(distanceInDaysToDate:) func distanceInDays(to date: Date) -> Int { Calendar.current.dateComponents([.day], from: self as Date, to: date).day ?? 0 }

    @objc var nearestHour: Int { Calendar.current.component(.hour, from: Date(timeIntervalSinceNow: dMinute * 30)) }
    @objc var hour: Int { Calendar.current.component(.hour, from: self as Date) }
    @objc var minute: Int { Calendar.current.component(.minute, from: self as Date) }
    @objc var seconds: Int { Calendar.current.component(.second, from: self as Date) }
    @objc var day: Int { Calendar.current.component(.day, from: self as Date) }
    @objc var month: Int { Calendar.current.component(.month, from: self as Date) }
    @objc var week: Int { Calendar.current.component(.weekOfYear, from: self as Date) }
    @objc var weekday: Int { Calendar.current.component(.weekday, from: self as Date) }
    @objc var nthWeekday: Int { Calendar.current.component(.weekdayOrdinal, from: self as Date) }
    @objc var chineaseWeekDay: String { ["1": "日", "2": "一", "3": "二", "4": "三", "5": "四", "6": "五", "7": "六"]["\(weekday)"] ?? "" }
    @objc var engWeekDay: String { ["1": "Sun", "2": "Mon", "3": "Tue", "4": "Wed", "5": "Thur", "6": "Fri", "7": "Sat"]["\(weekday)"] ?? "" }
    @objc var year: Int { Calendar.current.component(.year, from: self as Date) }
    @objc var weekLevel: Int { Calendar.current.component(.weekOfMonth, from: self as Date) - 1 }
    @objc var timeStemp: TimeInterval { Double(Int64(timeIntervalSince1970)) * 1000 }
    @objc var timeStempString: String { String(format: "%.f", timeStemp) }
    @objc var zeroTime: NSDate { dateAtStartOfDay() }
    @objc var dayEndTime: NSDate { zeroTime.addingTimeInterval(dDay - 1) as NSDate }
    @objc var formerMonth: NSDate { Calendar.current.date(byAdding: .month, value: -1, to: dateAtStartOfDay() as Date)! as NSDate }
    @objc var followMonth: NSDate { Calendar.current.date(byAdding: .month, value: 1, to: dateAtStartOfDay() as Date)! as NSDate }

    @objc func numberOfDaysInCurrentMonth() -> UInt {
        UInt(Calendar.current.range(of: .day, in: .month, for: self as Date)?.count ?? 0)
    }

    @objc func firstDayOfCurrentMonth() -> NSDate {
        let comps = Calendar.current.dateComponents([.year, .month], from: self as Date)
        return (Calendar.current.date(from: comps) ?? self as Date) as NSDate
    }

    @objc func lastDayOfCurrentMonth() -> NSDate {
        Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: firstDayOfCurrentMonth() as Date)! as NSDate
    }

    @objc func weeklyOrdinality() -> UInt {
        UInt(Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: self as Date) ?? 0)
    }

    @objc func numberOfWeeksInCurrentMonth() -> UInt {
        UInt(Calendar.current.range(of: .weekOfMonth, in: .month, for: self as Date)?.count ?? 0)
    }

    @objc(dateFromString:)
    class func dateFromString(_ dateString: String?) -> NSDate? {
        guard let dateString else { return nil }
        return formatter("yyyy-MM").date(from: dateString) as NSDate?
    }

    @objc(convertDateFromString:)
    class func convertDateFromString(_ uiDate: String?) -> NSDate? {
        guard let uiDate else { return nil }
        return formatter("yyyy年MM月dd日").date(from: uiDate) as NSDate?
    }

    @objc(dateFromString:Format:)
    class func dateFromString(_ dateString: String?, format: String?) -> NSDate? {
        guard let dateString, let format else { return nil }
        return formatter(format).date(from: dateString) as NSDate?
    }

    @objc(dateFromStringYYMMDD:)
    class func dateFromStringYYMMDD(_ dateString: String?) -> NSDate? {
        guard let dateString else { return nil }
        return formatter("yyyy-MM-dd").date(from: dateString) as NSDate?
    }

    @objc(getDateStringByFormat:)
    func getDateStringByFormat(_ format: String) -> String {
        NSDate.formatter(format).string(from: self as Date)
    }

    @objc(getWeekFirstDate:)
    class func getWeekFirstDate(_ inputDate: Date) -> NSDate {
        let weekday = weekdayFrom(inputDate)
        return inputDate.addingTimeInterval(dDay * Double(weekday == 7 ? 0 : -weekday)) as NSDate
    }

    @objc(getWeekLastDate:)
    class func getWeekLastDate(_ inputDate: Date) -> NSDate {
        let weekday = weekdayFrom(inputDate)
        return inputDate.addingTimeInterval(dDay * Double(weekday == 7 ? 6 : 6 - weekday)) as NSDate
    }

    @objc(weekdayFromDate:)
    class func weekdayFrom(_ inputDate: Date) -> Int32 {
        let weekday = Calendar(identifier: .gregorian).component(.weekday, from: inputDate)
        return Int32(weekday == 1 ? 7 : weekday - 1)
    }

    @objc(isTheSameDayWithDate:)
    func isTheSameDay(with date: Date) -> Bool {
        Calendar.current.isDate(self as Date, inSameDayAs: date)
    }

    @objc(dateWithYear:Month:Day:)
    class func dateWithYear(_ year: Int, month: Int, day: Int) -> NSDate? {
        dateFromStringYYMMDD("\(year)-\(month)-\(day)")
    }

    @objc(beginDateByWeekLevel:)
    func beginDateByWeekLevel(_ level: Int) -> NSDate {
        let first = NSDate.dateWithYear(year, month: month, day: 1) ?? self
        let start = NSDate.getWeekFirstDate(first as Date).dateByAddingDays(1)
        return start.dateByAddingDays(7 * level)
    }

    @objc(endDateByWeekLevel:)
    func endDateByWeekLevel(_ level: Int) -> NSDate {
        let first = NSDate.dateWithYear(year, month: month, day: 1) ?? self
        let end = NSDate.getWeekLastDate(first as Date).dateByAddingDays(1)
        return end.dateByAddingDays(7 * level)
    }
}

