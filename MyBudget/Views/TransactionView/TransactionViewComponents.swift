//
//  TransactionViewComponents.swift
//  MyBudget
//
//  Created by Anton Morenko on 21.11.2023.
//

import SwiftUI

extension TransactionView {
    
    func updateTransactionData() {
        
    }
    
    func addTranaction() {
        
    }
    
    func clearAndCloseTransactionForm() {
        
    }
    
    func formIsValid() -> Bool {
        amount != .zero && accaunt != nil && category != nil
    }
    
    
    var editTransactionForm: some View {
        NavigationStack {
            List {
                HStack{
                    Text("Счет")
                    
                    Spacer()
                    
                    Menu {
                        ForEach(allAccaunts) { acc in
                            Button(acc.accauntName) {
                                self.accaunt = acc
                            }
                        }
                    } label: {
                        if let accaunt = accaunt?.accauntName {
                            Text(accaunt)
                        } else {
                            Text("Счет отсутствует")
                        }
                    }
                    

                }
            }
            .navigationTitle("Добавить счет")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Отмена") {
                        showEditTransactionForm = false
                        isUpdatingMode = false
                    }
                    .tint(.red)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Добавить") {
                        if isUpdatingMode {
                            updateTransactionData()
                            clearAndCloseTransactionForm()
                        } else {
                            addTranaction()
                            clearAndCloseTransactionForm()
                        }
                    }
                    .disabled(!formIsValid())
                }
            }
        }
        .presentationDetents([.height(280)])
        .presentationCornerRadius(25)
        .interactiveDismissDisabled()
    }
}
