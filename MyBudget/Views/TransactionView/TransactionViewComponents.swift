//
//  TransactionViewComponents.swift
//  MyBudget
//
//  Created by Anton Morenko on 21.11.2023.
//

import SwiftUI

extension TransactionCommonForm {
    
//    MARK: - Выбор счета для дохода / расхода
    
    func accauntPicker() -> some View {
        return HStack{
            
            if operationCategory == "Income" {
                Text("На счет")
                
                Spacer()
                
                Menu {
                    ForEach(allAccaunts) { acc in
                        Button("\(acc.accauntName): \(acc.currentBalance.formatted())") {
                            self.accaunt = acc
                        }
                    }
                } label: {
                    if let accaunt = accaunt?.accauntName {
                        Text(accaunt)
                    } else {
                        Text("Выбрать счет")
                    }
                }
            }
            
            if operationCategory == "Expense" {
                Text("Со счета")
                
                Spacer()
                
                Menu {
                    ForEach(allAccaunts) { acc in
                        Button("\(acc.accauntName): \(acc.currentBalance.formatted())") {
                            self.accaunt = acc
                        }
                    }
                } label: {
                    if let accaunt = accaunt?.accauntName {
                        Text(accaunt)
                    } else {
                        Text("Выбрать счет")
                    }
                }
            }
        }
    }
    
//    MARK: - Выбор счета для перевода С
    
    func accauntPickerForTransferFrom() -> some View {
        return HStack {
            Text("Со счета")
            
            Spacer()
            
            Menu {
                ForEach(allAccaunts) { acc in
                    Button("\(acc.accauntName): \(acc.currentBalance.formatted())") {
                        self.accaunt = acc
                    }
                }
            } label: {
                if let accaunt = accaunt?.accauntName {
                    Text(accaunt)
                } else {
                    Text("Выбрать счет")
                }
            }
        }
    }
    
//    MARK: - Выбор счета для перевода НА
    
    func accauntPickerForTransferTo() -> some View {
        return HStack {
            Text("На счет")
            
            Spacer()
            
            Menu {
                ForEach(allAccaunts) { acc in
                    Button("\(acc.accauntName): \(acc.currentBalance.formatted())") {
                        self.transferToAccaunt = acc
                    }
                }
            } label: {
                if let transferToAccaunt = transferToAccaunt?.accauntName {
                    Text(transferToAccaunt)
                } else {
                    Text("Выбрать счет")
                }
            }
        }
    }
    
//    MARK: - Выбор операции ДОХОД / РАСХОД / ПЕРЕВОД
    
    func operationPicker() -> some View {
        return Picker("", selection: $operationCategory, content: {
            Text("Доход")
                .tag("Income")
            Text("Расход")
                .tag("Expense")
            Text("Перевод")
                .tag("Transfer")
        })
        .pickerStyle(.segmented)
    }
    
//    MARK: - Выбор категории
    
    func categoryPicker(categorySet: [Categories]) -> some View {
        return HStack{
            Text("Категория")
            
            Spacer()
            Image(category?.image ?? "")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 30, maxHeight: 30)
            Menu {
                ForEach(categorySet) { cat in
                    Button(action: {self.category = cat}, label: {
                        Image(cat.image)
                        Text(cat.category)
                            .lineLimit(1)
                    })
                }
            } label: {
                if let category = category?.category {
                    Text(category)
                }
                else {
                    Text("Выбрать категорию")
                }
            }
        }
    }
    
//    MARK: - Выбор даты
    
    func datePicker() -> some View {
        return Group {
            DatePicker(selection:  $transactionDate, displayedComponents: [.date], label: {
                Text("Дата операции")
                    .datePickerStyle(.graphical)
            }
            )
        }
    }
    
//    MARK: - Переключатель инвестиционных затрат
    
    func isInvestmentsToggle() -> some View {
        
        return Toggle("Это инвестиции", isOn: $isInvestments)
        
    }
    
//    MARK: - Переключатель пассивного дохода
    
    func isPassiveIncomeToggle() -> some View {
        return Toggle("Пассивный доход", isOn: $isPassiveIncome)
    }
}

struct RoundAddButton: View {
    
    private let action: () -> Void
    
    init(action: @escaping () -> Void) {
        self.action = action
    }
    
    var body: some View {
        Group {
            Spacer()
            Button(action: action,
                   label: {
                ZStack{
                    Circle()
                        .frame(maxWidth: 70)
                        .foregroundColor(.blue.opacity(0.6))
                    Image(systemName: "plus")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .bold()
                        .foregroundColor(.white)
                }
            })
            .padding(.bottom, 20)
            .padding(.trailing, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: 70, alignment: .bottomTrailing)
    }
}
