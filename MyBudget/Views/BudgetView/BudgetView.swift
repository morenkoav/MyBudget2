//
//  BudgetView.swift
//  MyBudget
//
//  Created by Anton Morenko on 03.12.2023.
//

import SwiftUI
import SwiftData

struct BudgetView: View {
    
    @Environment(\.modelContext) var budgetContext
    
    @State var showEditBudgetForm = false
    @State var isUpdatingMode = false
    @State var showEditTransactionForm = false
    
    @State var limit: Double = 0
    @State var newLimit: Double = 0
    @State var limitMinus: Double = 0
    @State var limitPlus: Double = 0
    @State var transferLimit: Double? = nil
    @State var category: Categories?
    
    @State var budgetFrom: Budgets?
    
    @State var budgetToEdit: Budgets?
    
    @State var assignationType = "Direct"
    
    @Query(filter: #Predicate<Categories> {$0.operation == "Expense"}) let categorySet: [Categories]
    
    @Query let budgets: [Budgets]
    
//    @Query(filter: #Predicate<Budgets> {$0.category != nil}, sort: \.limit, order: .reverse) let sortedBudgets: [Budgets]
    
    @Query let transactions: [Transactions]
    
    @Query(filter: #Predicate<Accaunts> {$0.isTrackingAccaunt == true}) let trackingAccaunts: [Accaunts]
    
    var body: some View {
        
        NavigationStack {
            VStack{
                
                budgetStatus()
                
                budgetList()

            }
            .overlay {
                if budgets.isEmpty {
                    ContentUnavailableView {
                        Label("У Вас нет бюджетов", systemImage: "tray.fill")
                    }
                }
                VStack {
                    Spacer()
                    RoundAddButton(action: {
                        showEditTransactionForm.toggle()
                    })
                }
            }
            .navigationTitle("Мой бюджет")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing,
                            content: {
                    Button {
                        showEditBudgetForm.toggle()
                    } label: {
                        Image(systemName: "bag.fill.badge.plus")
                            .font(.title)
                    }
                    .foregroundStyle(.blue.gradient.opacity(0.6))

                })
            }
        }
        
        .sheet(isPresented: $showEditBudgetForm) {
            
        } content: {
            editBudgetForm()
        }
        .sheet(isPresented: $isUpdatingMode) {
            
        } content: {
            assignMoneyToBudget()
        }
        .sheet(isPresented: $showEditTransactionForm) {
            
        } content: {
            TransactionCommonForm()
        }
        
    }
}

#Preview {
    BudgetView()
        .modelContainer(for: [Accaunts.self, Categories.self, Transactions.self, Budgets.self])
}
