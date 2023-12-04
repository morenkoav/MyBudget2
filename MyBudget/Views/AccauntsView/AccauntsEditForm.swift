//
//  AccauntsLists.swift
//  MyBudget
//
//  Created by Anton Morenko on 21.11.2023.
//

import SwiftUI


extension AccauntsView {
    
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
