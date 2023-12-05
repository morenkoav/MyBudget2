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
                
                HStack {
                    Image(category?.image ?? "")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 30, maxHeight: 30)
                    Text(budgetToEdit?.category?.category ?? "")
                }
                Text("Текущий лимит: \(limit.formatted())")
                HStack {
                    Text("Расход: ")
                    Text(budgetToEdit?.category?.absCategorySum.formatted() ?? "")
                }
                if budgetToEdit?.budgetRemain ?? 0 >= 0 {
                    Text("Остаток: \(budgetToEdit?.budgetRemain.formatted() ?? "")")
                        .foregroundStyle(.green)
                } else {
                    Text("Дефицит: \(budgetToEdit?.budgetRemain.formatted() ?? "")")
                        .foregroundStyle(.red)
                }
                
                HStack {
                    Text("Новый лимит:")
                    TextField("0", value: $newLimit, format: .number)
                        .keyboardType(.decimalPad)
                }
                
                Menu("Быстрые действия") {
                    if budgetToEdit?.budgetRemain ?? 0 < 0 {
                        Button("Покрыть дефицит", action: {
                            newLimit = limit - (budgetToEdit?.budgetRemain ?? 0)}
                        )
                    }
                    Button("Обнулить остаток", action: {
                        newLimit = limit - (budgetToEdit?.budgetRemain ?? 0)}
                    )
                    Button("+Расход прошлого месяца", action: {
                        newLimit = limit + (budgetToEdit?.category?.absSumPreviousMonth ?? 0)}
                    )
                }
                
            }
            .navigationTitle("Корректировка")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Отмена") {
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
