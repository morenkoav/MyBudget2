//
//  CategoryModel.swift
//  MyBudget
//
//  Created by Anton Morenko on 20.11.2023.
//

import Foundation
import SwiftData

@Model
class Categories {
    
    let id: UUID
    var operation: String
    @Attribute(.unique) var category: String
    var image: String
    @Relationship(deleteRule: .cascade, inverse: \Transactions.category)
    var transactions = [Transactions]()
    @Relationship(deleteRule: .cascade, inverse: \Budgets.category)
    var budgets = [Budgets]()
    
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
    
    @Transient var absCategorySum: Double {
        abs(categorySum)
    }
    
    @Transient var absSumThisMonth: Double {
        abs(sumThisMonth)
    }
    
    @Transient var absSumPreviousMonth: Double {
        abs(sumPreviousMonth)
    }
    
    @Transient var absSumThisYear: Double {
        abs(sumThisYear)
    }
    
    @Transient var absSumPreviousYear: Double {
        abs(sumPreviousYear)
    }
}
