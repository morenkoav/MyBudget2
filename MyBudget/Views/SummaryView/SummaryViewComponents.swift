//
//  SummaryViewComponents.swift
//  MyBudget
//
//  Created by Anton Morenko on 27.11.2023.
//

import SwiftUI
import Charts
import SwiftData

extension SummaryView {
    
    func periodPicker() -> some View {
        return Picker("", selection: $selectedPeriodSlice, content: {
            Text("< Месяц")
                .tag("PreviousMonth")
            Text("Этот месяц")
                .tag("ThisMonth")
            Text("Год")
                .tag("ThisYear")
            Text("<Год")
                .tag("PreviousYear")
            Text("Все время")
                .tag("AllData")
        })
        .pickerStyle(.menu)
        .frame(maxWidth: .infinity / 2, maxHeight: 50)
        .background(.blue.gradient.opacity(0.6), in: .rect(cornerRadius: 20))
        .padding(.horizontal)
        .tint(.white)
    }
    
    func incomeExpenseBalanceView() -> some View {
        return Group {
            VStack {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.green.gradient.opacity(0.6))
                            .frame(maxWidth: .infinity / 2, maxHeight: 120)
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                            Text("Доход")
                                .font(.headline)
                            Text(totalIncome().rounded().formatted())
                                .bold()
                                .font(.title)
                                .scaledToFit()
                            Text("в том числе")
                                .font(.subheadline)
                            Text(passiveIncome().rounded().formatted())
                                .bold()
                            Text("пассивный доход")
                                .font(.footnote)
                        }
                        .scaledToFit()
                    }
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundStyle(.red.gradient.opacity(0.6))
                            .frame(maxWidth: .infinity / 2, maxHeight: 120)
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                            Text("Расход")
                                .font(.headline)
                            Text(totalExpense().rounded().formatted())
                                .bold()
                                .font(.title)
                                .scaledToFit()
                            Text("в том числе")
                                .font(.subheadline)
                            Text(investExpense().rounded().formatted())
                                .bold()
                            Text("инвестиции")
                                .font(.footnote)
                        }
                        .scaledToFit()
                    }
                    
                }
                .padding(.horizontal)
                
                ZStack {
                    Group {
                        if cashFlow() >= 0 {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.green.gradient.opacity(0.6))
                                .frame(maxWidth: .infinity, maxHeight: 60)
                        } else {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundStyle(.red.gradient.opacity(0.6))
                                .frame(maxWidth: .infinity, maxHeight: 60)
                        }
                    }
                    VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                        Text("Баланс")
                            .font(.headline)
                        Text(cashFlow().rounded().formatted())
                            .bold()
                            .font(.title)
                            .scaledToFit()
                    }
                    .scaledToFit()
                }
                .padding(.horizontal)
            }
        }
    }
    
    func totalIncome() -> Double {
        
        var income: Double = 0
        
        
        if selectedPeriodSlice == "PreviousMonth" {
            let filteredArray = transactions.filter {
                $0.date >= startOfPreviousMonth &&
                $0.date <= endOfPreviousMonth &&
                $0.category?.operation == "Income"
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            income = sum
            }
        
        if selectedPeriodSlice == "ThisMonth" {
            let filteredArray = transactions.filter {
                $0.date >= startOfCurrentMonth &&
                $0.date <= endOfCurrentMonth &&
                $0.category?.operation == "Income"
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            income = sum
        }
        
        if selectedPeriodSlice == "ThisYear" {
            let filteredArray = transactions.filter {
                $0.date >= startOfYear! &&
                $0.category?.operation == "Income"
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            income = sum
        }
        
        if selectedPeriodSlice == "PreviousYear" {
            let filteredArray = transactions.filter {
                $0.date >= startOfPreviousYear &&
                $0.date <= endOfPreviousYear &&
                $0.category?.operation == "Income"
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            income = sum
        }
        
        if selectedPeriodSlice == "AllData" {
            let filteredArray = transactions.filter {
                $0.category?.operation == "Income"
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            income = sum
        }

        return income
    }
    
    func passiveIncome() -> Double {
        
        var passiveIncome: Double = 0
        
        if selectedPeriodSlice == "PreviousMonth" {
            let filteredArray = transactions.filter {
                $0.date >= startOfPreviousMonth &&
                $0.date <= endOfPreviousMonth &&
                $0.category?.operation == "Income" &&
                $0.isPassiveIncome == true
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            passiveIncome = sum
            }
        
        if selectedPeriodSlice == "ThisMonth" {
            let filteredArray = transactions.filter {
                $0.date >= startOfCurrentMonth &&
                $0.date <= endOfCurrentMonth &&
                $0.category?.operation == "Income" &&
                $0.isPassiveIncome == true
                
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            passiveIncome = sum
        }
        
        if selectedPeriodSlice == "ThisYear" {
            let filteredArray = transactions.filter {
                $0.date >= startOfYear! &&
                $0.category?.operation == "Income" &&
                $0.isPassiveIncome == true
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            passiveIncome = sum
        }
        
        if selectedPeriodSlice == "PreviousYear" {
            let filteredArray = transactions.filter {
                $0.date >= startOfPreviousYear &&
                $0.date <= endOfPreviousYear &&
                $0.category?.operation == "Income" &&
                $0.isPassiveIncome == true
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            passiveIncome = sum
        }
        
        if selectedPeriodSlice == "AllData" {
            let filteredArray = transactions.filter {
                $0.category?.operation == "Income" &&
                $0.isPassiveIncome == true
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            passiveIncome = sum
        }

        return passiveIncome
    }
    
    func totalExpense() -> Double {
        var expense: Double = 0
        
        if selectedPeriodSlice == "PreviousMonth" {
            let filteredArray = transactions.filter {
                $0.date >= startOfPreviousMonth &&
                $0.date <= endOfPreviousMonth &&
                $0.category?.operation == "Expense"
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            expense = sum
            }
        
        if selectedPeriodSlice == "ThisMonth" {
            let filteredArray = transactions.filter {
                $0.date >= startOfCurrentMonth &&
                $0.date <= endOfCurrentMonth &&
                $0.category?.operation == "Expense"
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            expense = sum
        }
        
        if selectedPeriodSlice == "ThisYear" {
            let filteredArray = transactions.filter {
                $0.date >= startOfYear! &&
                $0.category?.operation == "Expense"
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            expense = sum
        }
        
        if selectedPeriodSlice == "PreviousYear" {
            let filteredArray = transactions.filter {
                $0.date >= startOfPreviousYear &&
                $0.date <= endOfPreviousYear &&
                $0.category?.operation == "Expense"
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            expense = sum
        }
        
        if selectedPeriodSlice == "AllData" {
            let filteredArray = transactions.filter {
                $0.category?.operation == "Expense"
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            expense = sum
        }
        
        return expense
    }
    
    func investExpense() -> Double {
        var investExpense: Double = 0
        
        if selectedPeriodSlice == "PreviousMonth" {
            let filteredArray = transactions.filter {
                $0.date >= startOfPreviousMonth &&
                $0.date <= endOfPreviousMonth &&
                $0.category?.operation == "Expense" &&
                $0.isInvestments == true
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            investExpense = sum
            }
        
        if selectedPeriodSlice == "ThisMonth" {
            let filteredArray = transactions.filter {
                $0.date >= startOfCurrentMonth &&
                $0.date <= endOfCurrentMonth &&
                $0.category?.operation == "Expense" &&
                $0.isInvestments == true
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            investExpense = sum
        }
        
        if selectedPeriodSlice == "ThisYear" {
            let filteredArray = transactions.filter {
                $0.date >= startOfYear! &&
                $0.category?.operation == "Expense" &&
                $0.isInvestments == true
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            investExpense = sum
        }
        
        if selectedPeriodSlice == "PreviousYear" {
            let filteredArray = transactions.filter {
                $0.date >= startOfPreviousYear &&
                $0.date <= endOfPreviousYear &&
                $0.category?.operation == "Expense" &&
                $0.isInvestments == true
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            investExpense = sum
        }
        
        if selectedPeriodSlice == "AllData" {
            let filteredArray = transactions.filter {
                $0.category?.operation == "Expense" &&
                $0.isInvestments == true
            }
            
            let sum = filteredArray.reduce(0) { result, item in
                return result + item.amount}
            investExpense = sum
        }
        
        return investExpense
    }
    
    func cashFlow() -> Double {
        totalIncome() + totalExpense()
    }
    
    func expenseBarChart() -> some View {
        
        let expenseArray = categories.filter {
            $0.operation == "Expense"
        }
       
        
        return Chart(expenseArray) { category in
            BarMark(
                x: .value("Сумма", -category.sumThisMonth),
                y: .value("Категория", category.category)
            )
            .foregroundStyle(.red)
        }
        .frame(maxWidth: 150)
        .padding()
    }
    
    func operationCategoryPicker() -> some View {
        return Picker("", selection: $operationCategory, content: {
            Text("Доходы")
                .tag("Income")
            Text("Расходы")
                .tag("Expense")
        })
        .pickerStyle(.segmented)
        .padding(.horizontal)
    }
    
    
}
