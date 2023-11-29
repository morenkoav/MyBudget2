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
    
    @State var selectedSector: Double?
    @State var categorySelection: String?
    @State var selectedCategory: Categories?
    
    var body: some View {
        NavigationStack {
            VStack {
                periodPicker()
                incomeExpenseBalanceView()
                operationCategoryPicker()
                categoryStructureChart()
            }
            .navigationTitle("Обзор")
        }
    }
}

#Preview {
    SummaryView()
}
