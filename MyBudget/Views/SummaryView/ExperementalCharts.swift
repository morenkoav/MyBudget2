//
//  ExperementalCharts.swift
//  MyBudget
//
//  Created by Anton Morenko on 29.11.2023.
//

import SwiftUI
import Charts

extension SummaryView {
    
    func showAditionalCharts() -> some View {
        let expenseArray = categories.filter {
            $0.operation == "Expense"
        }
        let incomeArray = categories.filter {
            $0.operation == "Income"
        }
        
        let sortedExpenseArray = expenseArray
            .sorted(by: { $1.sumThisMonth > $0.sumThisMonth })
        
        return Group {
            Chart(sortedExpenseArray) { expense in
                BarMark(
                    x: .value("Сумма", expense.sumThisMonth),
                    y: .value("Категория", expense.category)
                )
            }
        }
        .navigationTitle("Аналитика")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Отмена") {
                    showAdditionalInfo = false
                }
                .tint(.red)
            }
        }
    }
}
