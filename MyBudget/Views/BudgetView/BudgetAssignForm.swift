//
//  BudgetAssinForm.swift
//  MyBudget
//
//  Created by Anton Morenko on 04.12.2023.
//

import SwiftUI
import SwiftData

extension BudgetView {
    
    func assignMoneyToBudget() -> some View {

        
        return NavigationStack {
            
            List {
                assignationTypePicker()
                if assignationType == "Direct" {
                    HStack{
                        Image(category?.image ?? "")
                            .resizable()
                            .scaledToFit()
                            .frame(maxWidth: 30, maxHeight: 30)
                        Text(category?.category ?? "")
                    }
//                    Text("Текущий лимит:  \(budgetToEdit?.limit.formatted() ?? "")")
//                    Text("Расходы:  \(budgetToEdit?.category?.absCategorySum.formatted() ?? "")")
                    
                    if budgetToEdit?.budgetRemain ?? 0 < 0 {
                        Text("Дефицит:  \(budgetToEdit?.budgetRemain.formatted() ?? "")")
                            .foregroundStyle(.red)
                            .bold()
                    } else {
                        Text("Остаток:  \(budgetToEdit?.budgetRemain.formatted() ?? "")")
                            .foregroundStyle(.green)
                            .bold()
                    }
                    HStack {
                        Image(systemName: "minus.circle.fill")
                            .foregroundStyle(.red)
                        Text("Снять:")
                        TextField("0", value: $limitMinus, format: .number)
                            .keyboardType(.decimalPad)
                            .bold()
                    }
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundStyle(.green)
                        Text("Добавить:")
                        TextField("0", value: $limitPlus, format: .number)
                            .keyboardType(.decimalPad)
                            .bold()
                    }

                    HStack {
                        Spacer()
                        Menu("Быстрое действие...") {
                            Button("Обнулить остаток", action: {limitMinus =  (budgetToEdit?.budgetRemain ?? 0) })
                            
                            if budgetToEdit?.budgetRemain ?? 0 < 0 {
                                Button("Компенсировать дефицит", action: {limitPlus = -(budgetToEdit?.budgetRemain ?? 0) })
                            }
                            
                            Button("+Расход пред. месяца", action: {
                                limitPlus = budgetToEdit?.category?.absSumPreviousMonth ?? 0})
                        }
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        Button("Сохранить и закрыть", action: {
                            updateBudgeteData()
                            clearAndCloseBudgetForm()
                        })
                        Spacer()
                    }
                }
                if assignationType == "Transfer" {
                    
                    HStack {
                        budgetPickerTransferFrom()
                        Text(budgetFrom?.budgetRemain.formatted() ?? "")
                            .frame(maxWidth: 80)
                            .lineLimit(1)
                    }
                        .padding(5)
                    HStack {
                        budgetPickerTransferTo()
                        Text(budgetToEdit?.budgetRemain.formatted() ?? "")
                            .frame(maxWidth: 80)
                            .lineLimit(1)

                    }
                        .padding(5)
                    
                    TextField("0", value: $transferLimit, format: .number)
                        .keyboardType(.decimalPad)
                        .font(.title)
                        .bold()
                        .padding(5)
                        .multilineTextAlignment(.trailing)
                    
                }

                
            }
            .navigationTitle("Корректировка")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Отмена") {
                        clearAndCloseBudgetForm()
                    }
                    .tint(.red)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Изменить") {
                        if assignationType == "Direct" {
                            updateBudgeteData()
                            clearAndCloseBudgetForm()
                        } else {
                            transferBudgets()
                            clearAndCloseBudgetForm()
                        }
                    }
                    .disabled(assignationType == "Direct" ? !formIsValid() : !transferFormisValid())
                }
            }
        }
        .presentationDetents([.height(450)])
        .presentationCornerRadius(25)
        .interactiveDismissDisabled()
    }
}
