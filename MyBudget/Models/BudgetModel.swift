//
//  BudgetModel.swift
//  MyBudget
//
//  Created by Anton Morenko on 25.11.2023.
//

import SwiftUI
import SwiftData

@Model
class Budgets {
    
    var id: UUID
    var category: Categories?
    var limit: Double
    
    @Transient
    var budgetRemain: Double {
        return limit - (category?.categorySum ?? 0)
    }
    
    init(
        category: Categories,
        limit: Double
    ) {
        self.id = UUID()
        self.category = category
        self.limit = limit
    }
    
    
    
    
}


