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
        
        return NavigationStack {
            
            Picker(
                "",
                selection: $selectedReport,
                content: {
                    Text("Денежный поток")
                        .tag("CashFlow")
                    Text("Категории")
                        .tag("Categories")
                }
            )
            .pickerStyle(.segmented)
            .padding()
            
            ScrollView {
                
                if selectedReport == "CashFlow" {
                    incomeDynamicChart()
                        .frame(height: 200)
                    expenseDynamicChart()
                        .frame(height: 200)
                    cashFlowDynamicChart()
                        .frame(height: 200)
                    cashFlowChart()
                        .frame(height: 200)
                } else {
                    VStack {
                        periodPicker()
                        incomeCategoriesBarChart()
                            .frame(height: 400)
                        expenseCategoriesBarChart()
                            .frame(height: 400)
                    }
                    
                    
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
}
