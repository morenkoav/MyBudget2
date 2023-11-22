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
    @Query var allTransactions: [Transactions]
    
    @State var transactionDate = Date()
    @State var accaunt: Accaunts?
    @State var category: Categories?
    @State var isPassiveIncome: Bool = false
    @State var isInvestments: Bool = false
    @State var amount: Double = 0
    @State var memo: String = ""
    
    @State var showEditTransactionForm = false
    @State var isUpdatingMode = false
    
    
    var body: some View {
        NavigationStack {
            List {
                
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

//#Preview {
//    TransactionView()
//}
