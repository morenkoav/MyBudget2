//
//  TransactionModel.swift
//  MyBudget
//
//  Created by Anton Morenko on 20.11.2023.
//

import Foundation
import SwiftData

@Model
class Transactions {
    
    let id: UUID
    var date: Date
    var accaunt: Accaunts?
    var category: Categories?
    var isPassiveIncome: Bool
    var isInvestments: Bool
    var amount: Double
    var memo: String
    
    init(
        date: Date,
        isPassiveIncome: Bool,
        isInvestments: Bool,
        amount: Double,
        memo: String
    ) {
        self.id = UUID()
        self.date = date
        self.isPassiveIncome = isPassiveIncome
        self.isInvestments = isInvestments
        self.amount = amount
        self.memo = memo
    }
    @Transient
    var absAmount = abs(amount)
}
