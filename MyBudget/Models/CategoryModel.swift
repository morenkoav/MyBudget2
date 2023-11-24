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
    
    
}
