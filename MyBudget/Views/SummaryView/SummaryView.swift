//
//  SummaryView.swift
//  MyBudget
//
//  Created by Anton Morenko on 20.11.2023.
//

import SwiftUI
import SwiftData

struct SummaryView: View {
   
    @Query let transactions: [Transactions]
        
    @State var selectedPeriodSlice = "ThisMonth"
    
    var body: some View {
        NavigationStack {
            VStack {
                periodPicker()
                incomeExpenseBalanceView()
            }
            .navigationTitle("Обзор")
        }
    }
}

#Preview {
    SummaryView()
}
