//
//  TransactionCommonForm.swift
//  MyBudget
//
//  Created by Anton Morenko on 11.12.2023.
//

import SwiftUI
import SwiftData

struct TransactionCommonForm: View {
    
    @Environment(\.modelContext) var transactionContext
    @Environment(\.dismiss) var dismiss
    
    @Query var allAccaunts: [Accaunts]
    
    @State var transactionDate = Date()
    @State var accaunt: Accaunts?
    @State var category: Categories?
    @State var isPassiveIncome: Bool = false
    @State var isInvestments: Bool = false
    @State var amount: Double? = nil
    @State var memo: String = ""
    
    @State var operationCategory = "Expense"
    
    @Query(filter: #Predicate<Categories> {$0.operation == "Income"}) let incomeCategories: [Categories]
    @Query(filter: #Predicate<Categories> {$0.operation == "Expense"}) let expenseCategories: [Categories]
    @Query(filter: #Predicate<Categories> {$0.operation == "Transfer"}) let transferCategories: [Categories]
    
    @State var transferToAccaunt: Accaunts?
    @State var transactionToEdit: Transactions?
    
    var body: some View {
        
        NavigationStack {
            List {
                TextField("0", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
                    .font(.title)
                    .bold()
                    .padding(5)
                    .multilineTextAlignment(.trailing)
                    
                
                operationPicker()
                Group {
                    if operationCategory == "Income" {
                        categoryPicker(categorySet: incomeCategories)
                        isPassiveIncomeToggle()
                        accauntPicker()
                    }
                    if operationCategory == "Expense" {
                        categoryPicker(categorySet: expenseCategories)
                        accauntPicker()
                        isInvestmentsToggle()
                    }
                    if operationCategory == "Transfer" {
                        categoryPicker(categorySet: transferCategories)
                        accauntPickerForTransferFrom()
                        accauntPickerForTransferTo()
                    }
                }
                datePicker()

                TextField("Заметка", text: $memo)
                
            }
            .navigationTitle("Добавить запись")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Отмена") {
                        clearAndCloseTransactionForm()
                    }
                    .tint(.red)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Добавить") {
                            addTransaction()
                            clearAndCloseTransactionForm()
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

