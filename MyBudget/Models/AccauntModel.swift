//
//  AccauntModel.swift
//  MyBudget
//
//  Created by Anton Morenko on 20.11.2023.
//

import Foundation
import SwiftData

@Model
class Accaunts {
    
    let id: UUID
    @Attribute(.unique) var accauntName: String
    var startBalance: Double
    var isTrackingAccaunt: Bool
    @Relationship(deleteRule: .cascade, inverse: \Transactions.accaunt)
    var transactions: [Transactions]?
    
    init(
        accauntName: String,
        startBalance: Double,
        isTrackingAccaunt: Bool
    ) {
        self.id = UUID()
        self.accauntName = accauntName
        self.startBalance = startBalance
        self.isTrackingAccaunt = isTrackingAccaunt
    }
    
    @Transient
    var currentBalance: Double {
        let sum = transactions?.reduce(0) { result, item in
            return result + item.amount }
        
        return startBalance + (sum ?? 0)
    }
}
