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
    
    @State var limit: Double = 0
    @State var category: Categories?
    @State var budgetToEdit: Budgets?
    
    @Query(filter: #Predicate<Categories> {$0.operation == "Expense"}) let categorySet: [Categories]
    
    @Query let budgets: [Budgets]
    
    @Query let transactions: [Transactions]
    
    @Query(filter: #Predicate<Accaunts> {$0.isTrackingAccaunt == true}) let trackingAccaunts: [Accaunts]
    
    var body: some View {
        
        NavigationStack {
            VStack{
                
                budgetStatus()
                // Прямоугольное поле со скругленными углами, показывающее сумму к распределению, дефицит бюджет, цвет меняется на красный (дефицит) и зеленый - ненулевая сумма к распределению
                
                budgetList()
                // Лист с выводом категорий, лимита, остатка с возможностью удалить
            }
            .overlay {
                if budgets.isEmpty {
                    ContentUnavailableView {
                        Label("У Вас нет бюджетов", systemImage: "tray.fill")
                    }
                }
            }
            .navigationTitle("Мой бюджет")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing,
                            content: {
                    Button {
                        showEditBudgetForm.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
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
    }
}

#Preview {
    BudgetView()
}
