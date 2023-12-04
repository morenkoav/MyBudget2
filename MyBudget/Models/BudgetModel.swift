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
        return limit - (category?.absCategorySum ?? 0)
    }
    
    init(
        limit: Double
    ) {
        self.id = UUID()
        self.limit = limit
    }
    
    
    
    
}


