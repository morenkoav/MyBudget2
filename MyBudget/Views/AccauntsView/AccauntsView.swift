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
    @Query(filter: #Predicate<Accaunts> {$0.isTrackingAccaunt == true}, sort: \Accaunts.accauntName) let trackingAccaunts: [Accaunts]
    @Query(filter: #Predicate<Accaunts> {$0.isTrackingAccaunt == false}, sort: \Accaunts.accauntName) let notTrackingAccaunts: [Accaunts]
    
    @State var showAddAccauntDialog = false
    @Environment(\.modelContext) var accauntContext
    
    @State var accauntName: String = ""
    @State var startBalance: Double = 0
    @State var isTrackingAccaunt = true
    
    @State var isUpdatingMode = false
    @State var accauntToEdit: Accaunts?
    
    @State private var trackingSelection: String = "Tracking"
    
    var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    private func accauntBalance(model: [Accaunts]) -> Double {
        
        let startAmount = model.reduce(0) {
            result, item in
            return result + item.startBalance
        }
  
        
//        let transactionSum = model.reduce(0) {
//            result, item in
//            return result + (item.transactions?.reduce(0) {
//                result, item in
//                return result + item.amount
//            } ?? 0)
//        }
        return startAmount
    }
    
    var body: some View {
        NavigationStack {
             
            VStack {
                Picker("", selection: $trackingSelection, content: {
                    Text("В балансе")
                        .tag("Tracking")
                    Text("За балансом")
                        .tag("NotTracking")
                    Text("Все счета")
                        .tag("All")
                })
                .pickerStyle(.segmented)
                .padding()
                
                ZStack {
                    RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.blue.opacity(0.5))
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 100)
                        .font(.title2)
                    VStack {
                        Text("Доступно средств:")
                            .font(.headline)
                        if trackingSelection == "Tracking" {
                            Text(accauntBalance(model: trackingAccaunts).formatted())
                                .font(.title)
                                .bold()
                        }
                        if trackingSelection == "NotTracking" {
                            Text((accauntBalance(model: accaunts)-accauntBalance(model: trackingAccaunts)).formatted())
                                .font(.title)
                                .bold()
                        }
                        if trackingSelection == "All" {
                            Text(accauntBalance(model: accaunts).formatted())
                                .font(.title)
                                .bold()
                        }
                    }
                }
                .padding()
            }
            
            Group {
                if trackingSelection == "Tracking" {
                    accauntList(model: trackingAccaunts)
                }
                if trackingSelection == "NotTracking" {
                    accauntList(model: notTrackingAccaunts)
                }
                if trackingSelection == "All" {
                    accauntList(model: accaunts)
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
            editAccauntView
        }
    }
}

#Preview {
    AccauntsView()
        .modelContainer(for: [Accaunts.self, Categories.self, Transactions.self])
}
