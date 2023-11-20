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
    
    @State private var showAddAccauntDialog = false
    @Environment(\.modelContext) private var accauntContext
    
    @State private var accauntName: String = ""
    @State private var startBalance: Double = 0
    @State private var isTrackingAccaunt = true
    
    @State private var isUpdatingMode = false
    @State private var accauntToEdit: Accaunts?
    
    var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    private func accauntBalance() -> Double {
        
        let startAmount = accaunts.reduce(0) {result, item in
            return result + item.startBalance
        }
        
//        let sum = accaunts.transactions?.reduce(0) {
//            result, item in
//            return result + item.amount
//        }
        return startAmount
    }
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.blue.opacity(0.5))
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 100)
                    .font(.title2)
                VStack {
                    Text("Доступно средств:")
                        .font(.headline)
                    Text(accauntBalance().formatted())
                        .font(.title)
                        .bold()
                }
            }
            .padding()
            
            List(accaunts) { accaunt in
                
                let sum = accaunt.transactions?.reduce(0) {
                    result, item in
                    return result + item.amount
                }
                
                HStack {
                    VStack(alignment: .leading){
                        Text(accaunt.accauntName)
                        if accaunt.isTrackingAccaunt {
                            Text("В балансе")
                                .font(.caption2)
                                .foregroundStyle(.white)
                                .padding(.horizontal,4)
                                .background(.green.gradient, in: .capsule)
                        } else {
                            Text("За балансом")
                                .font(.caption2)
                                .foregroundStyle(.white)
                                .padding(.horizontal,4)
                                .background(.red.gradient, in: .capsule)
                        }
                        
                    }
                    .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    Spacer()
                    Text((accaunt.startBalance + (sum ?? 0)).formatted())
                        .bold()
                        .multilineTextAlignment(.trailing)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                    
                    Button(role: .destructive, action: {accauntContext.delete(accaunt)}, label: {
                        Image(systemName: "trash.fill")
                    })
                    
                    Button(action: {
                        isUpdatingMode.toggle()
                        accauntName = accaunt.accauntName
                        startBalance = accaunt.startBalance
                        isTrackingAccaunt = accaunt.isTrackingAccaunt
                        accauntToEdit = accaunt
                        showAddAccauntDialog.toggle()},
                           label: {
                        Image(systemName: "pencil")
                            .tint(Color.orange)
                    })
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
                    TextField("Имя счета", text: $accauntName)
                    TextField("0", value: $startBalance, format: .number)
                        .keyboardType(.decimalPad)
                    Toggle("Учитывать в балансе", isOn: $isTrackingAccaunt)
                }
                .navigationTitle("Добавить счет")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Отмена") {
                            showAddAccauntDialog = false
                            isUpdatingMode = false
                        }
                        .tint(.red)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Добавить") {
                            
                            if isUpdatingMode {
                                
                                accauntToEdit?.accauntName = accauntName
                                accauntToEdit?.startBalance = startBalance
                                accauntToEdit?.isTrackingAccaunt = isTrackingAccaunt
                                
                                accauntName = ""
                                startBalance = 0
                                isUpdatingMode = false
                                showAddAccauntDialog = false
                                 
                            } else {
                                
                                let accaunt = Accaunts(accauntName: accauntName, startBalance: startBalance, isTrackingAccaunt: isTrackingAccaunt)
                                accauntContext.insert(accaunt)
                                
                                accauntName = ""
                                startBalance = 0
                                isUpdatingMode = false
                                showAddAccauntDialog = false
                            }
                            

                        }
                        .disabled(accauntName.isEmpty)
                    }
                }
            }
            .presentationDetents([.height(280)])
            .presentationCornerRadius(25)
            .interactiveDismissDisabled()
        }
    }
}

#Preview {
    AccauntsView()
}
