//
//  MainView.swift
//  MyBudget
//
//  Created by Anton Morenko on 20.11.2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var currentTab = "Transactions"
    
    var body: some View {
        TabView(selection: $currentTab) {
            AccauntsView()
                .tag("Accaunts")
                .tabItem {
                    Image(systemName: "creditcard.fill")
                        .font(.title)
                    Text("Счета")
                }
            CategoriesView()
                .tag("Categories")
                .tabItem {
                    Image(systemName: "envelope.open.fill")
                        .font(.title)
                    Text("Категории")
                }
            TransactionView()
                .tag("Transactions")
                .tabItem {
                    Image(systemName: "basket.fill")
                        .font(.title)
                    Text("Операции")
                }
            BudgetView()
                .tag("Budget")
                .tabItem {
                    Image(systemName: "briefcase.fill")
                        .font(.title)
                    Text("Бюджет")
                }
            SummaryView()
                .tag("Summary")
                .tabItem {
                    Image(systemName: "chart.pie.fill")
                        .font(.title)
                    Text("Обзор")
                }
        }
    }
}

#Preview {
    MainView()
        .modelContainer(for: [Accaunts.self, Categories.self, Transactions.self])
}
