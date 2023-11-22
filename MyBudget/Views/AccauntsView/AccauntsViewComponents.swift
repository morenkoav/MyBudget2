//
//  AccauntsLists.swift
//  MyBudget
//
//  Created by Anton Morenko on 21.11.2023.
//

import SwiftUI


extension AccauntsView {
    
    func accauntList(model: [Accaunts]) -> some View {
        return List(model) { accaunt in
                   
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
                Text(accaunt.currentBalance.formatted())
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
    }
    
    func updateAccauntData() {
        accauntToEdit?.accauntName = accauntName
        accauntToEdit?.startBalance = startBalance
        accauntToEdit?.isTrackingAccaunt = isTrackingAccaunt
    }
    
    func addAccaunt() {
        let accaunt = Accaunts(accauntName: accauntName, startBalance: startBalance, isTrackingAccaunt: isTrackingAccaunt)
        accauntContext.insert(accaunt)
    }
    
    func clearAndCloseAccauntForm() {
        accauntName = ""
        startBalance = 0
        isUpdatingMode = false
        showAddAccauntDialog = false
    }
    
    var editAccauntView: some View {
        NavigationStack {
            List {
                TextField("Имя счета", text: $accauntName)
                TextField("0", value: $startBalance, format: .number)
                    .keyboardType(.decimalPad)
                Toggle("Учитывать в балансе", isOn: $isTrackingAccaunt)
            }
            .navigationTitle(isUpdatingMode ? "Изменить счет" : "Добавить счет")
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
                    Button(isUpdatingMode ? "Изменить" : "Добавить") {
                        if isUpdatingMode {
                            updateAccauntData()
                            clearAndCloseAccauntForm()
                        } else {
                            addAccaunt()
                            clearAndCloseAccauntForm()
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
