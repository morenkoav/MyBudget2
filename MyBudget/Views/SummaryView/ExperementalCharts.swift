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
            operationCategoryPicker()
            ScrollView {
                categoryStructureChart()
                    .frame(height: 300)
                categoriesBarChart()
                    .frame(height: 200)
                operationsPerPeriod()
                    .frame(height: 200)
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
