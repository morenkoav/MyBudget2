//
//  TransactionViewComponents.swift
//  MyBudget
//
//  Created by Anton Morenko on 21.11.2023.
//

import SwiftUI

extension TransactionView {
    
    func updateTransactionData() {
        transactionToEdit?.category = category
        transactionToEdit?.accaunt = accaunt
        transactionToEdit?.date = transactionDate
        transactionToEdit?.amount = amount
        transactionToEdit?.memo = memo
    }
    
    func addTransaction() {
        
        if operationCategory == "Income" {
            let incomeTransaction = Transactions(
                date: transactionDate,
                isPassiveIncome: isPassiveIncome,
                isInvestments: isInvestments,
                amount: amount,
                memo: memo
            )
            
            transactionContext.insert(incomeTransaction)
            
            accaunt?.transactions.append(incomeTransaction)
            category?.transactions.append(incomeTransaction)
            
            
        }
        
        if operationCategory == "Expense" {
            let expenseTransaction = Transactions(
                date: transactionDate,
                isPassiveIncome: isPassiveIncome,
                isInvestments: isInvestments,
                amount: -amount,
                memo: memo
            )
            transactionContext.insert(expenseTransaction)
            
            accaunt?.transactions.append(expenseTransaction)
            category?.transactions.append(expenseTransaction)
        }
        
        if operationCategory == "Transfer" {
            let transactionFrom = Transactions(
                date: transactionDate,
                isPassiveIncome: false,
                isInvestments: false,
                amount: -amount,
                memo: memo
            )
            let transactionTo = Transactions(
                date: transactionDate,
                isPassiveIncome: false,
                isInvestments: false,
                amount: amount,
                memo: memo
            )
            
            transactionContext.insert(transactionFrom)
            transactionContext.insert(transactionTo)
            
            accaunt?.transactions.append(transactionFrom)
            category?.transactions.append(transactionFrom)
            
            transferToAccaunt?.transactions.append(transactionTo)
            category?.transactions.append(transactionTo)
        }
    }
    
    func clearAndCloseTransactionForm() {
        category = nil
        accaunt = nil
        transferToAccaunt = nil
        transactionDate = Date()
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
                        Button("\(acc.accauntName): \(acc.currentBalance.formatted())") {
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
                        Button("\(acc.accauntName): \(acc.currentBalance.formatted())") {
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
                    Button("\(acc.accauntName): \(acc.currentBalance.formatted())") {
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
                    Button("\(acc.accauntName): \(acc.currentBalance.formatted())") {
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
                            .lineLimit(1)
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
    
    func transactionsList(model: [Transactions]) -> some View {
        return List(model) { transaction in
            HStack {
                Image(transaction.category?.image ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30, maxHeight: 30)
                VStack(alignment: .leading) {
                    Text(transaction.category?.category ?? "")
                        .font(.subheadline)
                        .bold()
                        .lineLimit(1)
                    Text(transaction.date.formatted(date: Date.FormatStyle.DateStyle.abbreviated, time: Date.FormatStyle.TimeStyle.omitted))
                        .font(.footnote)
                    HStack {
                        Text(transaction.accaunt?.accauntName ?? "")
                            .font(.caption2)
                        if !transaction.memo.isEmpty {
                            Text("- \(transaction.memo)")
                                .font(.caption)
                                .lineLimit(1)
                        }
                    }
                }
                Spacer()
                Text(transaction.amount.formatted())
                    .font(.subheadline)
                    .bold()
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(transaction.category?.operation == "Income" ? .green : transaction.category?.operation == "Expense" ? .red : .gray)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                
                Button(role: .destructive, action: {transactionContext.delete(transaction)}, label: {
                    Image(systemName: "trash.fill")
                })
                
                Button(action: {
                    isUpdatingMode.toggle()
                    category = transaction.category
                    accaunt = transaction.accaunt
                    isInvestments = transaction.isInvestments
                    isPassiveIncome = transaction.isPassiveIncome
                    transactionDate = transaction.date
                    amount = transaction.amount
                    memo = transaction.memo
                    transactionToEdit = transaction
                    showEditTransactionForm.toggle()
                },
                       label: {
                    Image(systemName: "pencil")
                        .tint(Color.orange)
                })
            }
        }
        .listStyle(.plain)
    }
    
    func sumOfTransactions(model: [Transactions]) -> Double {
        
        let sum = model.reduce(0) { result, item in
            return result + item.amount
        }
        return sum
    }
        
        
    func periodTotalView() -> some View {
        
        return Group {
            ZStack {
                if operationCategory == "Income" {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.green.gradient.opacity(0.6))
                        .frame(maxWidth: .infinity / 2, maxHeight: 50)
                        .font(.title2)
                }
                if operationCategory == "Expense" {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.red.gradient.opacity(0.6))
                        .frame(maxWidth: .infinity / 2, maxHeight: 50)
                        .font(.title2)
                }
                if operationCategory == "Transfer" {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.gray.gradient.opacity(0.6))
                        .frame(maxWidth: .infinity / 2, maxHeight: 50)
                        .font(.title2)
                }

                VStack {
                    Text("За период:")
                        .font(.caption)
                    Group {
                        // MARK: - Операции за предыдущий месяц
                        
                        if operationCategory == "Income" && selectedPeriodSlice == "PreviousMonth" {
                            Text(sumOfTransactions(model: incomeTransactionsPreviousMonth).formatted())
                        }
                        
                        if operationCategory == "Expense" && selectedPeriodSlice == "PreviousMonth" {
                            Text(sumOfTransactions(model: expenseTransactionsPreviousMonth).formatted())
                        }
                        
                        if operationCategory == "Transfer" && selectedPeriodSlice == "PreviousMonth" {
                            Text(sumOfTransactions(model: transferTransactionsPreviousMonth).formatted())
                        }
                        
                        // MARK: - Операции за предыдущий день
                        
                        if operationCategory == "Income" && selectedPeriodSlice == "Yesterday" {
                            Text(sumOfTransactions(model: incomeTransactionsPreviousDay).formatted())
                        }
                        
                        if operationCategory == "Expense" && selectedPeriodSlice == "Yesterday" {
                            Text(sumOfTransactions(model: expenseTransactionsPreviousDay).formatted())
                        }
                        
                        if operationCategory == "Transfer" && selectedPeriodSlice == "Yesterday" {
                            Text(sumOfTransactions(model: transferTransactionsPreviousDay).formatted())
                        }
                        
                        // MARK: - Операции за текущий день
                        
                        if operationCategory == "Income" && selectedPeriodSlice == "Today" {
                            Text(sumOfTransactions(model: incomeTransactionsCurrentDay).formatted())
                        }
                        
                        if operationCategory == "Expense" && selectedPeriodSlice == "Today" {
                            Text(sumOfTransactions(model: expenseTransactionsCurrentDay).formatted())
                        }
                        
                        if operationCategory == "Transfer" && selectedPeriodSlice == "Today" {
                            Text(sumOfTransactions(model: transferTransactionsCurrentDay).formatted())
                        }
                        
                        // MARK: - Операции за текущий месяц
                        
                        if operationCategory == "Income" && selectedPeriodSlice == "ThisMonth" {
                            Text(sumOfTransactions(model: incomeTransactionsCurrentMonth).formatted())
                        }
                        
                        if operationCategory == "Expense" && selectedPeriodSlice == "ThisMonth" {
                            Text(sumOfTransactions(model: expenseTransactionsCurrentMonth).formatted())
                        }
                        
                        if operationCategory == "Transfer" && selectedPeriodSlice == "ThisMonth" {
                            Text(sumOfTransactions(model: transferTransactionsCurrentMonth).formatted())
                        }
                        
                        // MARK: - Операции за текущий год
                        
                        if operationCategory == "Income" && selectedPeriodSlice == "ThisYear" {
                            Text(sumOfTransactions(model: incomeTransactionsCurrentYear).formatted())
                        }
                        
                        if operationCategory == "Expense" && selectedPeriodSlice == "ThisYear" {
                            Text(sumOfTransactions(model: expenseTransactionsCurrentYear).formatted())
                        }
                        
                        if operationCategory == "Transfer" && selectedPeriodSlice == "ThisYear" {
                            Text(sumOfTransactions(model: transferTransactionsCurrentYear).formatted())
                        }
                        
                        // MARK: - Все операции
                        
                        if operationCategory == "Income" && selectedPeriodSlice == "AllData" {
                            Text(sumOfTransactions(model: incomeTransactions).formatted())
                        }
                        
                        if operationCategory == "Expense" && selectedPeriodSlice == "AllData" {
                            Text(sumOfTransactions(model: expenseTransactions).formatted())
                        }
                        
                        if operationCategory == "Transfer" && selectedPeriodSlice == "AllData" {
                            Text(sumOfTransactions(model: transferTransactions).formatted())
                        }
                    }
                    .font(.title3)
                    .bold()
                }
                .scaledToFit()
                .padding(.horizontal)
            }
            
        }
    }
    
    
}
