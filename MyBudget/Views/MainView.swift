//
//  MainView.swift
//  MyBudget
//
//  Created by Anton Morenko on 20.11.2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var currentTab = "Accaunts"
    
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
            SummaryView()
                .tag("Summary")
                .tabItem {
                    Image(systemName: "s.circle.fill")
                        .font(.title)
                    Text("Обзор")
                }
        }
    }
}

#Preview {
    MainView()
}
