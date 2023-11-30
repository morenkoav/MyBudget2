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
    
    @Query(filter: #Predicate<Categories> {$0.operation == "Expense"}) let expenseCategories: [Categories]
    
    func parsingCategoryNameAndValue() -> [(name: String, range: Range<Double>)] {
       
        var cumulative = 0.0
        
        let identifierArray = expenseCategories.map {
            let newCumulative = cumulative + $0.absSumThisMonth
            let result = (name: $0.category, range: cumulative ..< newCumulative)
            cumulative = newCumulative
            return result
        }
        return identifierArray
    }
    
//    var selectedCategoryIndex: (name: String, sum: Double)? {
//        
//        
//        if let selectedSector,
//           let selectedIndex = parsingCategoryNameAndValue().firstIndex(where: {$0.range.contains(selectedSector)}) {
//            return categories(id(<#T##ID#>))
//        }
//                return nil
//    }
    
    var body: some View {
        NavigationStack {
            VStack {
                periodPicker()
                incomeExpenseBalanceView()
                operationCategoryPicker()
                categoriesBarChart()
               
            }
            .navigationTitle("Обзор")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing,
                            content: {
                    Button {
                        showAdditionalInfo.toggle()
                    } label: {
                        Image(systemName: "chart.bar.fill")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }
                    .foregroundStyle(.blue.gradient.opacity(0.6))

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
