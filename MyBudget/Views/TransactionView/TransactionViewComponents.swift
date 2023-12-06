//
//  TransactionViewComponents.swift
//  MyBudget
//
//  Created by Anton Morenko on 21.11.2023.
//

import SwiftUI

extension TransactionView {
    
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
    
// MARK: - Скругленный прямоугольник для вывода итого транзакций за период
    
    func periodTotalView() -> some View {
        
        return Group {
            ZStack {
                if operationCategory == "Income" {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.green.gradient.opacity(0.6))
                        .frame(maxWidth: .infinity / 2, maxHeight: 50)
                        .font(.title2)
                }
                if operationCategory == "Expense" {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.red.gradient.opacity(0.6))
                        .frame(maxWidth: .infinity / 2, maxHeight: 50)
                        .font(.title2)
                }
                if operationCategory == "Transfer" {
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(.gray.gradient.opacity(0.6))
                        .frame(maxWidth: .infinity / 2, maxHeight: 50)
                        .font(.title2)
                }

                VStack {
                    Text("За период:")
                        .font(.caption)
                    Group {
                        // MARK: - Операции за предыдущий месяц
                        
                        if operationCategory == "Income" && selectedPeriodSlice == "PreviousMonth" {
                            Text(sumOfTransactions(model: incomeTransactionsPreviousMonth).formatted())
                        }
                        
                        if operationCategory == "Expense" && selectedPeriodSlice == "PreviousMonth" {
                            Text(sumOfTransactions(model: expenseTransactionsPreviousMonth).formatted())
                        }
                        
                        if operationCategory == "Transfer" && selectedPeriodSlice == "PreviousMonth" {
                            Text(sumOfTransactions(model: transferTransactionsPreviousMonth).formatted())
                        }
                        
                        // MARK: - Операции за предыдущий день
                        
                        if operationCategory == "Income" && selectedPeriodSlice == "Yesterday" {
                            Text(sumOfTransactions(model: incomeTransactionsPreviousDay).formatted())
                        }
                        
                        if operationCategory == "Expense" && selectedPeriodSlice == "Yesterday" {
                            Text(sumOfTransactions(model: expenseTransactionsPreviousDay).formatted())
                        }
                        
                        if operationCategory == "Transfer" && selectedPeriodSlice == "Yesterday" {
                            Text(sumOfTransactions(model: transferTransactionsPreviousDay).formatted())
                        }
                        
                        // MARK: - Операции за текущий день
                        
                        if operationCategory == "Income" && selectedPeriodSlice == "Today" {
                            Text(sumOfTransactions(model: incomeTransactionsCurrentDay).formatted())
                        }
                        
                        if operationCategory == "Expense" && selectedPeriodSlice == "Today" {
                            Text(sumOfTransactions(model: expenseTransactionsCurrentDay).formatted())
                        }
                        
                        if operationCategory == "Transfer" && selectedPeriodSlice == "Today" {
                            Text(sumOfTransactions(model: transferTransactionsCurrentDay).formatted())
                        }
                        
                        // MARK: - Операции за текущий месяц
                        
                        if operationCategory == "Income" && selectedPeriodSlice == "ThisMonth" {
                            Text(sumOfTransactions(model: incomeTransactionsCurrentMonth).formatted())
                        }
                        
                        if operationCategory == "Expense" && selectedPeriodSlice == "ThisMonth" {
                            Text(sumOfTransactions(model: expenseTransactionsCurrentMonth).formatted())
                        }
                        
                        if operationCategory == "Transfer" && selectedPeriodSlice == "ThisMonth" {
                            Text(sumOfTransactions(model: transferTransactionsCurrentMonth).formatted())
                        }
                        
                        // MARK: - Операции за текущий год
                        
                        if operationCategory == "Income" && selectedPeriodSlice == "ThisYear" {
                            Text(sumOfTransactions(model: incomeTransactionsCurrentYear).formatted())
                        }
                        
                        if operationCategory == "Expense" && selectedPeriodSlice == "ThisYear" {
                            Text(sumOfTransactions(model: expenseTransactionsCurrentYear).formatted())
                        }
                        
                        if operationCategory == "Transfer" && selectedPeriodSlice == "ThisYear" {
                            Text(sumOfTransactions(model: transferTransactionsCurrentYear).formatted())
                        }
                        
                        // MARK: - Все операции
                        
                        if operationCategory == "Income" && selectedPeriodSlice == "AllData" {
                            Text(sumOfTransactions(model: incomeTransactions).formatted())
                        }
                        
                        if operationCategory == "Expense" && selectedPeriodSlice == "AllData" {
                            Text(sumOfTransactions(model: expenseTransactions).formatted())
                        }
                        
                        if operationCategory == "Transfer" && selectedPeriodSlice == "AllData" {
                            Text(sumOfTransactions(model: transferTransactions).formatted())
                        }
                    }
                    .font(.title3)
                    .bold()
                }
                .scaledToFit()
                .padding(.horizontal)
            }
            
        }
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
