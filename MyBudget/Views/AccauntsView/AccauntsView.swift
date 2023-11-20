//
//  AccauntsView.swift
//  MyBudget
//
//  Created by Anton Morenko on 20.11.2023.
//

import SwiftUI
import SwiftData

struct AccauntsView: View {
    
    @Query var accaunts: [Accaunts]
    @State private var showAddAccauntDialog = false
    @Environment(\.modelContext) private var accauntContext
    
    @State private var accauntName: String = ""
    @State private var srartBalance: Double = 0
    @State private var isTrackingAccaunt = true
    

    
    var body: some View {
        NavigationStack {
            List(accaunts) { accaunt in
                
                let sum = accaunt.transactions?.reduce(0) {
                    result, item in
                    return result + item.amount
                }
                
                HStack {
                    Text(accaunt.accauntName)
                    Text((accaunt.startBalance + (sum ?? 0)).formatted())
                }
                
            }
            .navigationTitle("Мои счета")
            .overlay {
                if accaunts.isEmpty {
                    ContentUnavailableView {
                        Label("У Вас нет счетов", systemImage: "tray.fill")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing,
                            content: {
                    Button {
                        showAddAccauntDialog.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }

                })
            }
        }
        .sheet(isPresented: $showAddAccauntDialog) {
            
        } content: {
            NavigationStack {
                List {
                    
                }
                .navigationTitle("Добавить счет")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Отмена") {
                            showAddAccauntDialog = false
                        }
                        .tint(.red)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Добавить") {
                            showAddAccauntDialog = false
                        }
                        .disabled(accauntName.isEmpty)
                    }
                }
            }
        }
    }
}

#Preview {
    AccauntsView()
}
