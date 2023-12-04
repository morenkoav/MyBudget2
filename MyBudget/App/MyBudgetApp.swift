//
//  MyBudgetApp.swift
//  MyBudget
//
//  Created by Anton Morenko on 20.11.2023.
//

import SwiftUI
import SwiftData

@main
struct MyBudgetApp: App {
    var body: some Scene {
        WindowGroup {
            MainView()
        }
        .modelContainer(for: [Accaunts.self, Categories.self, Transactions.self, Budgets.self])
        
        
    }
}
