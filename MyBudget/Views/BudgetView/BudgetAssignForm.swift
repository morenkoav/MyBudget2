//
//  BudgetAssinForm.swift
//  MyBudget
//
//  Created by Anton Morenko on 04.12.2023.
//

import SwiftUI

extension BudgetView {
    
    func assignMoneyToBudget() -> some View {
        NavigationStack {
            List {
                
                
                TextField("0", value: $limit, format: .number)
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle("Корректировка бюджета")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Отмена") {
                        showEditBudgetForm = false
                        isUpdatingMode = false
                    }
                    .tint(.red)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Изменить") {
                        if isUpdatingMode {
                            updateBudgeteData()
                            clearAndCloseBudgetForm()
                        } else {
                            addBudget()
                            clearAndCloseBudgetForm()
                        }
                    }
                    .disabled(!formIsValid())
                }
            }
        }
        .presentationDetents([.height(450)])
        .presentationCornerRadius(25)
        .interactiveDismissDisabled()
    }
    
}
