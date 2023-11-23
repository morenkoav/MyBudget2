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
    
    let incomeImages = ["BankInterests", "Investments", "LoveMoney",
                                       "Profit", "Rent", "Salary", "Savings"]
    
    let expenseImages = ["Apartments1", "Bus", "Bus2",
                                         "Buying", "Car", "Car2",
                                         "Cash", "Digital1", "Digital2",
                                         "Grocery1", "Hamper", "Home",
                                         "Home2", "iMac", "Meal",
                                         "Meal2", "Meal3", "Phone1",
                                         "Phone2", "Smartphone", "Taxi",
                                         "Wallet"]
    
    let transferImages = ["Transfer",  "Transfer2", "Transfer3"]
    
    
    
    var body: some View {
        NavigationStack {
            VStack {
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
            .overlay {
                if categories.isEmpty {
                    ContentUnavailableView {
                        Label("У Вас нет категорий", systemImage: "tray.fill")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing,
                            content: {
                    Button {
                        showEditCategoryForm.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }

                })
            }
        }
        .sheet(isPresented: $showEditCategoryForm) {
            
        } content: {
            editCategoryForm
        }    
    }
}

#Preview {
    CategoriesView()
        .modelContainer(for: [Accaunts.self, Categories.self, Transactions.self])
}
