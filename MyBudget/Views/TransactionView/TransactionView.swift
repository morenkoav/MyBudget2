//
//  TransactionView.swift
//  MyBudget
//
//  Created by Anton Morenko on 20.11.2023.
//

import SwiftUI
import SwiftData

struct TransactionView: View {
    
    @Environment(\.modelContext) var transactionContext
    @Query var allAccaunts: [Accaunts]
    
    @Query var allCategories: [Categories]
    @Query(filter: #Predicate<Categories> {$0.operation == "Income"}) let incomeCategories: [Categories]
    @Query(filter: #Predicate<Categories> {$0.operation == "Expense"}) let expenseCategories: [Categories]
    @Query(filter: #Predicate<Categories> {$0.operation == "Transfer"}) let transferCategories: [Categories]
    
    
    @Query let allTransactions: [Transactions]
    
// MARK: - Операции за предыдущий месяц
        
        @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Income" && $0.date >= startOfPreviousMonth && $0.date <= endOfPreviousMonth}, sort: \Transactions.date, order: .reverse) let incomeTransactionsPreviousMonth: [Transactions]
        
        @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Expense" && $0.date >= startOfPreviousMonth && $0.date <= endOfPreviousMonth}, sort: \Transactions.date, order: .reverse) let expenseTransactionsPreviousMonth: [Transactions]
        
        @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Transfer" && $0.date >= startOfPreviousMonth && $0.date <= endOfPreviousMonth}, sort: \Transactions.date, order: .reverse) let transferTransactionsPreviousMonth: [Transactions]
    
// MARK: - Операции за предыдущий день
    
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Income" && $0.date >= startOfPreviousDay && $0.date <= endOfPreviousDay}, sort: \Transactions.date, order: .reverse) let incomeTransactionsPreviousDay: [Transactions]
    
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Expense" && $0.date >= startOfPreviousDay && $0.date <= endOfPreviousDay}, sort: \Transactions.date, order: .reverse) let expenseTransactionsPreviousDay: [Transactions]
    
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Transfer" && $0.date >= startOfPreviousDay && $0.date <= endOfPreviousDay}, sort: \Transactions.date, order: .reverse) let transferTransactionsPreviousDay: [Transactions]
    
// MARK: - Операции за текущий день
    
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Income" && $0.date >= dayOfToday}, sort: \Transactions.date, order: .reverse) let incomeTransactionsCurrentDay: [Transactions]
    
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Expense" && $0.date >= dayOfToday}, sort: \Transactions.date, order: .reverse) let expenseTransactionsCurrentDay: [Transactions]
    
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Transfer" && $0.date >= dayOfToday}, sort: \Transactions.date, order: .reverse) let transferTransactionsCurrentDay: [Transactions]
    
// MARK: - Операции за текущий месяц
    
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Income" && $0.date >= startOfCurrentMonth2 && $0.date <= endOfCurrentMonth}, sort: \Transactions.date, order: .reverse) let incomeTransactionsCurrentMonth: [Transactions]
    
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Expense" && $0.date >= startOfCurrentMonth2 && $0.date <= endOfCurrentMonth}, sort: \Transactions.date, order: .reverse) let expenseTransactionsCurrentMonth: [Transactions]
    
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Transfer" && $0.date >= startOfCurrentMonth2 && $0.date <= endOfCurrentMonth}, sort: \Transactions.date, order: .reverse) let transferTransactionsCurrentMonth: [Transactions]
    
// MARK: - Операции за текущий год
    
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Income" && $0.date >= startOfYear!}, sort: \Transactions.date, order: .reverse) let incomeTransactionsCurrentYear: [Transactions]
    
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Expense" && $0.date >= startOfYear!}, sort: \Transactions.date, order: .reverse) let expenseTransactionsCurrentYear: [Transactions]
    
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Transfer" && $0.date >= startOfYear!}, sort: \Transactions.date, order: .reverse) let transferTransactionsCurrentYear: [Transactions]
    
// MARK: - Все операции
    
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Income" }, sort: \Transactions.date, order: .reverse) let incomeTransactions: [Transactions]
    
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Expense"}, sort: \Transactions.date, order: .reverse) let expenseTransactions: [Transactions]
    
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Transfer"}, sort: \Transactions.date, order: .reverse) let transferTransactions: [Transactions]
    
    @State var transactionDate = Date()
    @State var accaunt: Accaunts?
    @State var category: Categories?
    @State var isPassiveIncome: Bool = false
    @State var isInvestments: Bool = false
    @State var amount: Double = 0
    @State var memo: String = ""
    
    @State var showEditTransactionForm = false
    @State var isUpdatingMode = false
    @State var operationCategory = "Expense"
    
    @State var transferToAccaunt: Accaunts?
    @State var transactionToEdit: Transactions?
    
    @State var selectedPeriodSlice = "ThisMonth"
    @State var startPeriod = Date()
    @State var endPeriod = Date()
    
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Picker("", selection: $selectedPeriodSlice, content: {
                        Text("< Месяц")
                            .tag("PreviousMonth")
                        Text("Вчера")
                            .tag("Yesterday")
                        Text("Сегодня")
                            .tag("Today")
                        Text("Этот месяц")
                            .tag("ThisMonth")
                        Text("Год")
                            .tag("ThisYear")
                        Text("Все время")
                            .tag("AllData")
                    })
                    .pickerStyle(.menu)
                    .frame(maxWidth: .infinity / 2, maxHeight: 50)
                    .background(.blue.gradient.opacity(0.6), in: .rect(cornerRadius: 20))
                    .bold()
                    .tint(.white)
                    periodTotalView()
                }
                .padding()
                Picker("", selection: $operationCategory, content: {
                    Text("Доходы")
                        .tag("Income")
                    Text("Расходы")
                        .tag("Expense")
                    Text("Переводы")
                        .tag("Transfer")
                })
                .pickerStyle(.palette)
                .padding(.horizontal)
            }
            Group {
// MARK: - Операции за предыдущий месяц
                
                if operationCategory == "Income" && selectedPeriodSlice == "PreviousMonth" {
                    transactionsList(model: incomeTransactionsPreviousMonth)
                }
                
                if operationCategory == "Expense" && selectedPeriodSlice == "PreviousMonth" {
                    transactionsList(model: expenseTransactionsPreviousMonth)
                }
                
                if operationCategory == "Transfer" && selectedPeriodSlice == "PreviousMonth" {
                    transactionsList(model: transferTransactionsPreviousMonth)
                }
                
// MARK: - Операции за предыдущий день
                
                if operationCategory == "Income" && selectedPeriodSlice == "Yesterday" {
                    transactionsList(model: incomeTransactionsPreviousDay)
                }
                
                if operationCategory == "Expense" && selectedPeriodSlice == "Yesterday" {
                    transactionsList(model: expenseTransactionsPreviousDay)
                }
                
                if operationCategory == "Transfer" && selectedPeriodSlice == "Yesterday" {
                    transactionsList(model: transferTransactionsPreviousDay)
                }
                
// MARK: - Операции за текущий день
                
                if operationCategory == "Income" && selectedPeriodSlice == "Today" {
                    transactionsList(model: incomeTransactionsCurrentDay)
                }
                
                if operationCategory == "Expense" && selectedPeriodSlice == "Today" {
                    transactionsList(model: expenseTransactionsCurrentDay)
                }
                
                if operationCategory == "Transfer" && selectedPeriodSlice == "Today" {
                    transactionsList(model: transferTransactionsCurrentDay)
                }
                
// MARK: - Операции за текущий месяц
                
                if operationCategory == "Income" && selectedPeriodSlice == "ThisMonth" {
                    transactionsList(model: incomeTransactionsCurrentMonth)
                }
                
                if operationCategory == "Expense" && selectedPeriodSlice == "ThisMonth" {
                    transactionsList(model: expenseTransactionsCurrentMonth)
                }
                
                if operationCategory == "Transfer" && selectedPeriodSlice == "ThisMonth" {
                    transactionsList(model: transferTransactionsCurrentMonth)
                }
                
// MARK: - Операции за текущий год
                
                if operationCategory == "Income" && selectedPeriodSlice == "ThisYear" {
                    transactionsList(model: incomeTransactionsCurrentYear)
                }
                
                if operationCategory == "Expense" && selectedPeriodSlice == "ThisYear" {
                    transactionsList(model: expenseTransactionsCurrentYear)
                }
                
                if operationCategory == "Transfer" && selectedPeriodSlice == "ThisYear" {
                    transactionsList(model: transferTransactionsCurrentYear)
                }
              
// MARK: - Все операции
                
                if operationCategory == "Income" && selectedPeriodSlice == "AllData" {
                    transactionsList(model: incomeTransactions)
                }
                
                if operationCategory == "Expense" && selectedPeriodSlice == "AllData" {
                    transactionsList(model: expenseTransactions)
                }
                
                if operationCategory == "Transfer" && selectedPeriodSlice == "AllData" {
                    transactionsList(model: transferTransactions)
                }
//                RoundAddButton(action: {
//                    category = nil
//                    accaunt = nil
//                    isPassiveIncome = false
//                    isInvestments = false
//                    amount = 0
//                    memo = ""
//                    showEditTransactionForm.toggle()
//                })

            }
            .navigationTitle("Мои операции")
            .overlay {
                if allTransactions.isEmpty {
                    ContentUnavailableView {
                        Label("Пока здесь пусто", systemImage: "tray.fill")
                    }
                }
                VStack {
                    Spacer()
                    RoundAddButton(action: {
                        category = nil
                        accaunt = nil
                        isPassiveIncome = false
                        isInvestments = false
                        amount = 0
                        memo = ""
                        showEditTransactionForm.toggle()
                    })
                }
            }
        }
        .sheet(isPresented: $showEditTransactionForm) {
            
        } content: {
            editTransactionForm
        }
    }
}

#Preview {
    TransactionView()
        .modelContainer(for: [Accaunts.self, Categories.self, Transactions.self])
}
