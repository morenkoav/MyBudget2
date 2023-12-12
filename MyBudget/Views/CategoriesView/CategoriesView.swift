//
//  CategoriesView.swift
//  MyBudget
//
//  Created by Anton Morenko on 20.11.2023.
//

import SwiftUI
import SwiftData

struct CategoriesView: View {
 
    @Environment(\.modelContext) var categoryContext
    @Query var categories: [Categories]
    
    @Query(filter: #Predicate<Categories> {$0.operation == "Income"}) let incomeCategories: [Categories]
    @Query(filter: #Predicate<Categories> {$0.operation == "Expense"}) let expenseCategories: [Categories]
    
    @State var showEditCategoryForm = false
    @State var isUpdatingMode = false
    @State var showIconPicker = false
    
    @State var operationName = "Expense"
    @State var categoryName = ""
    @State var categoryImage = ""
    
    @State var categorieToEdit: Categories?
    @State var showEditTransactionForm = false
    
    let incomeImages = ["BankInterests", "Investments", "LoveMoney",
                        "Profit", "Percent2","Rent", "Salary", "Savings"]
    
    let expenseImages = ["Accounting", "Airplane", "AirplaneWindow","Apartments1", "Barber", "Beach", "Bill","Bus", "Bus2",
                        "Buying", "Cello", "Charity", "Charity2","Car", "Car2", "Cash", "Digital1", "Digital2", "Festival",
                         "Fitness", "Fitness1", "Fun", "Gift", "Grocery1", "Hamper", "Health", "Health2","Home","Home2",
                         "iMac", "Meal", "Meal2", "Meal3", "Percent", "Pharma", "Phone1", "Phone2", "Renovation", "Repair",
                         "Shopping", "Shopping2", "Smartphone", "Taxi", "Travel", "Vacation", "Wallet"]
    
    let transferImages = ["Transfer",  "Transfer2", "Transfer3"]
    
    @State var selectedPeriodSlice = "ThisMonth"
        
    var body: some View {
        NavigationStack {
            VStack {
                Picker("", selection: $selectedPeriodSlice, content: {
                    Text("< Месяц")
                        .tag("PreviousMonth")
                    Text("Этот месяц")
                        .tag("ThisMonth")
                    Text("Год")
                        .tag("ThisYear")
                    Text("Все время")
                        .tag("AllData")
                })
                .pickerStyle(.menu)
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 50)
                .background(.blue.gradient.opacity(0.6), in: .rect(cornerRadius: 15))
                .tint(.white)
                .padding(.horizontal)
                
                Picker("", selection: $operationName, content: {
                    Text("Доходы")
                        .tag("Income")
                    Text("Расходы")
                        .tag("Expense")
                })
                .pickerStyle(.palette)
                .padding()
            }
            Group {
                if operationName == "Income" {
                    categoriesList(model: incomeCategories)
                }
                if operationName == "Expense" {
                    categoriesList(model: expenseCategories)
                }
            }
            .navigationTitle("Мои категории")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing,
                            content: {
                    Button {
                        showEditCategoryForm.toggle()
                    } label: {
                        Image(systemName: "rectangle.stack.fill.badge.plus")
                            .font(.title2)
                    }
                    .foregroundStyle(.blue.gradient.opacity(0.6))

                })
            }
            .overlay {
                if categories.isEmpty {
                    ContentUnavailableView {
                        Label("У Вас нет категорий", systemImage: "tray.fill")
                    }
                }
                
                VStack {
                    Spacer()
                    RoundAddButton(action: {
                        showEditTransactionForm.toggle()
                    })
                }
                
            }
        }
        .sheet(isPresented: $showEditCategoryForm) {
            
        } content: {
            editCategoryForm
        }
        .sheet(isPresented: $showEditTransactionForm) {
            
        } content: {
            TransactionCommonForm()
        }
    }
}

#Preview {
    CategoriesView()
        .modelContainer(for: [Accaunts.self, Categories.self, Transactions.self])
}
