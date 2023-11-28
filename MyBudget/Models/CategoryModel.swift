//
//  CategoryModel.swift
//  MyBudget
//
//  Created by Anton Morenko on 20.11.2023.
//

import Foundation
import SwiftData

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
let endOfCurrentMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfCurrentMonth)!

// MARK: - Начало и окончание предыдущего месяца
let startOfPreviousMonth = calendar.date(byAdding: DateComponents(month: -1, day: 0), to: startOfCurrentMonth)!
let endOfPreviousMonth = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startOfPreviousMonth)!

// MARK: - Начало текущего года
let startOfYear = currentDate.startOfYear

// MARK: - Начало и окончание предыдущего года
let startOfPreviousYear = calendar.date(byAdding: DateComponents(year: -1), to: startOfYear!)!
let endOfPreviousYear = calendar.date(byAdding: DateComponents(year: 1, day: -1), to: startOfPreviousYear)!



@Model
class Categories {
    
    let id: UUID
    var operation: String
    @Attribute(.unique) var category: String
    var image: String
    @Relationship(deleteRule: .cascade, inverse: \Transactions.category)
    var transactions = [Transactions]()
    
    init(
        operation: String,
        category: String,
        categoryImage: String
    ) {
        self.id = UUID()
        self.operation = operation
        self.category = category
        self.image = categoryImage
    }
    
    @Transient
    var categorySum: Double {
        let sum = transactions.reduce(0) { result, item in
            return result + item.amount }
        
        return sum
    }
    
    @Transient
    var sumThisMonth: Double {
        let filteredArray = transactions.filter {
            $0.date >= startOfCurrentMonth && $0.date <= endOfCurrentMonth
        }
        let sum = filteredArray.reduce(0) { result, item in
            return result + item.amount
        }
        return sum
    }
    
    @Transient
    var sumPreviousMonth: Double {
        let filteredArray = transactions.filter {
            $0.date >= startOfPreviousMonth && $0.date <= endOfPreviousMonth
        }
        let sum = filteredArray.reduce(0) { result, item in
            return result + item.amount
        }
        return sum
    }
    
    @Transient
    var sumThisYear: Double {
        let filteredArray = transactions.filter {
            $0.date >= startOfYear!
        }
        let sum = filteredArray.reduce(0) { result, item in
            return result + item.amount
        }
        return sum
    }
    
    @Transient
    var sumPreviousYear: Double {
        let filteredArray = transactions.filter {
            $0.date >= startOfPreviousYear &&
            $0.date <= endOfPreviousYear
        }
        let sum = filteredArray.reduce(0) { result, item in
            return result + item.amount
        }
        return sum
    }
    
    
}
