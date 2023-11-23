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
    @Query(filter: #Predicate<Transactions> {$0.category?.operation == "Income"}, sort: \Transactions.date, order: .reverse) let incomeTransactions: [Transactions]
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
    
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $operationCategory, content: {
                    Text("Доходы")
                        .tag("Income")
                    Text("Расходы")
                        .tag("Expense")
                    Text("Переводы")
                        .tag("Transfer")
                })
                .pickerStyle(.palette)
                .padding()
            }
            Group {
                if operationCategory == "Income" {
                    transactionsList(model: incomeTransactions)
                }
                if operationCategory == "Expense" {
                    transactionsList(model: expenseTransactions)
                }
                if operationCategory == "Transfer" {
                    transactionsList(model: transferTransactions)
                }
            }
            .navigationTitle("Мои операции")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing,
                            content: {
                    Button {
                        showEditTransactionForm.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }

                })
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
