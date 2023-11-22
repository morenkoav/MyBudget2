//
//  TransactionViewComponents.swift
//  MyBudget
//
//  Created by Anton Morenko on 21.11.2023.
//

import SwiftUI

extension TransactionView {
    
    func updateTransactionData() {
        
    }
    
    func addTransaction() {
        
        if operationCategory == "Income" {
//            let accauntSchema: Accaunts?
            let incomeTransaction = Transactions(
                date: transactionDate,
                accaunt: accaunt!,
                category: category!,
                isPassiveIncome: isPassiveIncome,
                isInvestments: isInvestments,
                amount: amount,
                memo: memo
            )
            
            incomeTransaction.accaunt = accaunt!
            incomeTransaction.category = category!
            
            
            transactionContext.insert(incomeTransaction)
            
            
            
//            accaunt?.transactions?.append(incomeTransaction)
//            category?.transactions?.append(incomeTransaction)
//            incomeTransaction.accaunt = accauntSchema
//            accauntSchema?.transactions?.append(incomeTransaction)
        }
        
        if operationCategory == "Expense" {
            let expenseTransaction = Transactions(
                date: transactionDate,
                accaunt: accaunt!,
                category: category!,
                isPassiveIncome: isPassiveIncome,
                isInvestments: isInvestments,
                amount: -amount,
                memo: memo
            )
            transactionContext.insert(expenseTransaction)
        }
        
        if operationCategory == "Transfer"
        {
            let transactionFrom = Transactions(
                date: transactionDate,
                accaunt: accaunt!,
                category: category!,
                isPassiveIncome: false,
                isInvestments: false,
                amount: -amount,
                memo: memo
            )
            let transactionTo = Transactions(
                date: transactionDate,
                accaunt: transferToAccaunt!,
                category: category!,
                isPassiveIncome: false,
                isInvestments: false,
                amount: amount,
                memo: memo
            )
            
            transactionContext.insert(transactionFrom)
            transactionContext.insert(transactionTo)
        }
    }
    
    func clearAndCloseTransactionForm() {
//        category = nil
//        accaunt = nil
//        transferToAccaunt = nil
//        transactionDate = Date()
        amount = 0
        memo = ""
        showEditTransactionForm = false
    }
    
    func formIsValid() -> Bool {
        if operationCategory != "Transfer" {
            amount != .zero && accaunt != nil && category != nil
        } else {
            amount != .zero && accaunt != nil && transferToAccaunt != nil && category != nil
        }
        
    }
    
    func accauntPicker() -> some View {
        return HStack{
            
            if operationCategory == "Income" {
                Text("На счет")
                
                Spacer()
                
                Menu {
                    ForEach(allAccaunts) { acc in
                        Button(acc.accauntName) {
                            self.accaunt = acc
                        }
                    }
                } label: {
                    if let accaunt = accaunt?.accauntName {
                        Text(accaunt)
                    } else {
                        Text("Выбрать счет")
                    }
                }
            }
            
            if operationCategory == "Expense" {
                Text("Со счета")
                
                Spacer()
                
                Menu {
                    ForEach(allAccaunts) { acc in
                        Button(acc.accauntName) {
                            self.accaunt = acc
                        }
                    }
                } label: {
                    if let accaunt = accaunt?.accauntName {
                        Text(accaunt)
                    } else {
                        Text("Выбрать счет")
                    }
                }
            }
        }
    }
    
    func accauntPickerForTransferFrom() -> some View {
        return HStack {
            Text("Со счета")
            
            Spacer()
            
            Menu {
                ForEach(allAccaunts) { acc in
                    Button(acc.accauntName) {
                        self.accaunt = acc
                    }
                }
            } label: {
                if let accaunt = accaunt?.accauntName {
                    Text(accaunt)
                } else {
                    Text("Выбрать счет")
                }
            }
        }
    }
    
    func accauntPickerForTransferTo() -> some View {
        return HStack {
            Text("На счет")
            
            Spacer()
            
            Menu {
                ForEach(allAccaunts) { acc in
                    Button(acc.accauntName) {
                        self.transferToAccaunt = acc
                    }
                }
            } label: {
                if let transferToAccaunt = transferToAccaunt?.accauntName {
                    Text(transferToAccaunt)
                } else {
                    Text("Выбрать счет")
                }
            }
        }
    }
    
    
    
    func operationPicker() -> some View {
        return Picker("", selection: $operationCategory, content: {
            Text("Доход")
                .tag("Income")
            Text("Расход")
                .tag("Expense")
            Text("Перевод")
                .tag("Transfer")
        })
        .pickerStyle(.segmented)
    }
    
    func categoryPicker(categorySet: [Categories]) -> some View {
        return HStack{
            Text("Категория")
            
            Spacer()
            Image(category?.image ?? "")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 30, maxHeight: 30)
            Menu {
                ForEach(categorySet) { cat in
                    Button(action: {self.category = cat}, label: {
                        Image(cat.image)
                        Text(cat.category)
                    })
                }
            } label: {
                if let category = category?.category {
                    Text(category)
                }
                else {
                    Text("Выбрать категорию")
                }
            }
        }
    }
    
    func datePicker() -> some View {
        return Group {
            DatePicker(selection:  $transactionDate, displayedComponents: [.date], label: {
                Text("Дата операции")
                    .datePickerStyle(.graphical)
            }
            )
        }
    }
    
    func isInvestmentsToggle() -> some View {
        
        return Toggle("Это инвестиции", isOn: $isInvestments)
        
    }
    
    func isPassiveIncomeToggle() -> some View {
        return Toggle("Пассивный доход", isOn: $isPassiveIncome)
    }
    
    var editTransactionForm: some View {
        NavigationStack {
            List {
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
                TextField("0", value: $amount, format: .number)
                    .keyboardType(.decimalPad)
                TextField("Заметка", text: $memo)
                
            }
            .navigationTitle(isUpdatingMode ? "Изменить запись" : "Добавить запись")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Отмена") {
                        showEditTransactionForm = false
                        isUpdatingMode = false
                    }
                    .tint(.red)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(isUpdatingMode ? "Изменить" : "Добавить") {
                        if isUpdatingMode {
                            updateTransactionData()
                            clearAndCloseTransactionForm()
                        } else {
                            addTransaction()
                            clearAndCloseTransactionForm()
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
