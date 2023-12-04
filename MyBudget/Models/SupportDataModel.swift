//
//  SupportDataModel.swift
//  MyBudget
//
//  Created by Anton Morenko on 03.12.2023.
//

import SwiftUI

extension Date {
    var startOfYear: Date? {
        Calendar.current.date(from: Calendar.current.dateComponents([.year], from: self))
    }
}


let currentDate = Date()
let calendar = Calendar.autoupdatingCurrent
let components = calendar.dateComponents([.year, .month], from: currentDate)

// MARK: - Начало и окончание предыдущего дня
let startOfPreviousDay = calendar.date(byAdding: DateComponents(month: 0, day: -1), to: dayOfToday)!
let endOfPreviousDay = calendar.date(byAdding: DateComponents(month: 0, day: 0), to: dayOfToday)!

// MARK: - Текущий день
let dayOfToday = calendar.startOfDay(for: currentDate)

// MARK: - Начало и окончание текущего месяца
let startOfCurrentMonth = calendar.date(from: components)!
let startOfCurrentMonth2 = calendar.startOfDay(for: startOfCurrentMonth)
let endOfCurrentMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfCurrentMonth2)!

// MARK: - Начало и окончание предыдущего месяца
let startOfPreviousMonth = calendar.date(byAdding: DateComponents(month: -1, day: 1), to: startOfCurrentMonth2)!
let endOfPreviousMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfPreviousMonth)!

// MARK: - Начало текущего года
let startOfYear = currentDate.startOfYear

// MARK: - Начало и окончание предыдущего года
let startOfPreviousYear = calendar.date(byAdding: DateComponents(year: -1), to: startOfYear!)!
let endOfPreviousYear = calendar.date(byAdding: DateComponents(year: 1, day: -1), to: startOfPreviousYear)!


struct MonthlyIncome: Identifiable {
    var id: UUID
    let month: Date
    let sum: Double
}

struct MonthlyExpense: Identifiable {
    var id: UUID
    let month: Date
    let sum: Double
}

struct MonthlyCashFlow: Identifiable {
    var id: UUID
    let month: Date
    let sum: Double
}
