//
//  SummaryView.swift
//  MyBudget
//
//  Created by Anton Morenko on 20.11.2023.
//

import SwiftUI
import SwiftData
import Charts

struct SummaryView: View {
   
    @Query let transactions: [Transactions]
    @Query var categories: [Categories]
        
    @State var selectedPeriodSlice = "ThisMonth"
    @State var operationCategory = "Expense"
    
    var body: some View {
        NavigationStack {
            VStack {
                periodPicker()
                incomeExpenseBalanceView()
                operationCategoryPicker()
                
                    if operationCategory == "Expense" {
                        expenseChart()
                    }
                    
                    if operationCategory == "Income" {
                        incomeChart()
                    }
            }
            .navigationTitle("Обзор")
        }
    }
}

#Preview {
    SummaryView()
}
