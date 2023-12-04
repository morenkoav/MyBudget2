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
    
    @State var selectedSector: Double? = nil
    @State var categorySelection: String?
    @State var selectedCategory: Categories?
    
    @State var showAdditionalInfo = false
    
    @State var selectedReport = "CashFlow"
    
    
    var body: some View {
        NavigationStack {
            VStack {
                periodPicker()
                incomeExpenseBalanceView()
                operationCategoryPicker()
                categoryStructureChart()
               
            }
            .navigationTitle("Обзор")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing,
                            content: {
                    Button {
                        showAdditionalInfo.toggle()
                    } label: {
                        Image(systemName: "chart.bar.doc.horizontal")
                            .font(.title2)
                    }
                    .foregroundStyle(.blue.gradient.opacity(0.9))

                })
            }
        }
        .sheet(isPresented: $showAdditionalInfo) {
            
        } content: {
            showAditionalCharts()
        }
    }
}

#Preview {
    SummaryView()
}
