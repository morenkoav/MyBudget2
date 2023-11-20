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
    var category: String
    
    init(
        operation: String,
        category: String
    ) {
        self.id = UUID()
        self.operation = operation
        self.category = category
    }
}
