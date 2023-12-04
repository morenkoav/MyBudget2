//
//  EditBudgetForm.swift
//  MyBudget
//
//  Created by Anton Morenko on 03.12.2023.
//

import SwiftUI

extension BudgetView {
    
//  MARK: - Форма добавления / редактирования бюджета
    
    func editBudgetForm() -> some View {
        NavigationStack {
            List {
                categoryPicker()
                
                TextField("0", value: $limit, format: .number)
                    .keyboardType(.decimalPad)
                
            }
            .navigationTitle(isUpdatingMode ? "Изменить запись" : "Добавить запись")
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
                    Button(isUpdatingMode ? "Изменить" : "Добавить") {
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
