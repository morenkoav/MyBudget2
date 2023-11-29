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
    
//    MARK: - Диаграммы категорий расходов
    
    func expenseThisMonthChart() -> some View {
            let expenseArray = categories.filter {
                $0.operation == "Expense"
            }
        
            return Chart(expenseArray) { category in
                SectorMark(
                    angle: .value("Cумма", -category.sumThisMonth),
                    innerRadius: .ratio(0.620),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Категория", category.category))
//                .opacity(category.category == selectedName ? 1.0 : 0.3)
            }
            .frame(maxWidth: .infinity)
            .padding()
    }
    
    func expensePreviousMonthChart() -> some View {
            let expenseArray = categories.filter {
                $0.operation == "Expense"
            }
        
            return Chart(expenseArray) { category in
                SectorMark(
                    angle: .value("Cумма", -category.sumPreviousMonth),
                    innerRadius: .ratio(0.620),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Категория", category.category))
            }
            .frame(maxWidth: .infinity)
            .padding()
    }
    
    func expenseCurrentYearChart() -> some View {
            let expenseArray = categories.filter {
                $0.operation == "Expense"
            }
        
            return Chart(expenseArray) { category in
                SectorMark(
                    angle: .value("Cумма", -category.sumThisYear),
                    innerRadius: .ratio(0.620),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Категория", category.category))
            }
            .frame(maxWidth: .infinity)
            .padding()
    }
    
    func expensePreviousYearChart() -> some View {
            let expenseArray = categories.filter {
                $0.operation == "Expense"
            }
        
            return Chart(expenseArray) { category in
                SectorMark(
                    angle: .value("Cумма", -category.sumPreviousYear),
                    innerRadius: .ratio(0.620),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Категория", category.category))
            }
            .frame(maxWidth: .infinity)
            .padding()
    }
    
    func expenseAllDataChart() -> some View {
            let expenseArray = categories.filter {
                $0.operation == "Expense"
            }
        
            return Chart(expenseArray) { category in
                SectorMark(
                    angle: .value("Cумма", -category.categorySum),
                    innerRadius: .ratio(0.620),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Категория", category.category))
            }
            .frame(maxWidth: .infinity)
            .padding()
    }
    
    
    func expenseChart() -> some View {
        return Group {
            if selectedPeriodSlice == "PreviousMonth" {
                expensePreviousMonthChart()
            }
            if selectedPeriodSlice == "ThisMonth" {
                expenseThisMonthChart()
            }
            if selectedPeriodSlice == "ThisYear" {
                expenseCurrentYearChart()
            }
            if selectedPeriodSlice == "PreviousYear" {
                expensePreviousYearChart()
            }
            if selectedPeriodSlice == "AllData" {
                expenseAllDataChart()
            }
        }
    }
    
//    MARK: - Диаграммы категорий доходов
    
    func incomeThisMonthChart() -> some View {
            let expenseArray = categories.filter {
                $0.operation == "Income"
            }
        
            return Chart(expenseArray) { category in
                SectorMark(
                    angle: .value("Cумма", -category.sumThisMonth),
                    innerRadius: .ratio(0.620),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Категория", category.category))
            }
            .frame(maxWidth: .infinity)
            .padding()
    }
    
    func incomePreviousMonthChart() -> some View {
            let expenseArray = categories.filter {
                $0.operation == "Income"
            }
        
            return Chart(expenseArray) { category in
                SectorMark(
                    angle: .value("Cумма", -category.sumPreviousMonth),
                    innerRadius: .ratio(0.620),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Категория", category.category))
            }
            .frame(maxWidth: .infinity)
            .padding()
    }
    
    func incomeCurrentYearChart() -> some View {
            let expenseArray = categories.filter {
                $0.operation == "Income"
            }
        
            return Chart(expenseArray) { category in
                SectorMark(
                    angle: .value("Cумма", -category.sumThisYear),
                    innerRadius: .ratio(0.620),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Категория", category.category))
            }
            .frame(maxWidth: .infinity)
            .padding()
    }
    
    func incomePreviousYearChart() -> some View {
            let expenseArray = categories.filter {
                $0.operation == "Income"
            }
        
            return Chart(expenseArray) { category in
                SectorMark(
                    angle: .value("Cумма", -category.sumPreviousYear),
                    innerRadius: .ratio(0.620),
                    angularInset: 1.5
                )
                .cornerRadius(5)
                .foregroundStyle(by: .value("Категория", category.category))
            }
            .frame(maxWidth: .infinity)
            .padding()
    }
    
    func incomeAllDataChart() -> some View {
            let expenseArray = categories.filter {
                $0.operation == "Income"
            }
        
            return Chart(expenseArray) { category in
                SectorMark(
                    angle: .value("Cумма", -category.categorySum),
                    innerRadius: .ratio(0.620),
                    angularInset: 1.5
                )
                .annotation(position: .overlay) {
                    Text(category.categorySum.formatted())
                }
                .cornerRadius(5)
                .foregroundStyle(by: .value("Категория", category.category))
            }
            .frame(maxWidth: .infinity)
            .padding()
    }
    
    
    func incomeChart() -> some View {
        return Group {
            if selectedPeriodSlice == "PreviousMonth" {
                incomePreviousMonthChart()
            }
            if selectedPeriodSlice == "ThisMonth" {
                incomeThisMonthChart()
            }
            if selectedPeriodSlice == "ThisYear" {
                incomeCurrentYearChart()
            }
            if selectedPeriodSlice == "PreviousYear" {
                incomePreviousYearChart()
            }
            if selectedPeriodSlice == "AllData" {
                incomeAllDataChart()
            }
        }
    }

    func findSelectedSector(value: Int) -> String? {
        var accumalatedCount = 0
        
        let category = categories.first { (_, count) in
            accumalatedCount += count
            return value <= accumalatedCount
        }
        
        return category?.category
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
