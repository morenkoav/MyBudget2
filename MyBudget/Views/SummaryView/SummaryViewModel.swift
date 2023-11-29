//
//  SummaryViewModel.swift
//  MyBudget
//
//  Created by Anton Morenko on 29.11.2023.
//

import SwiftUI
import Charts


extension SummaryView {
    
//    MARK: - Расчет общего дохода
    
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
    
    // MARK: - Расчет пассивного дохода
    
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
    
// MARK: - Расчет общего расхода
    
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
    
// MARK: - Расчет инвестиционных расходов
    
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
    
// MARK: - Расчет денежного потока (Доходы - Расходы)
    
    func cashFlow() -> Double {
        totalIncome() + totalExpense()
    }
    
// MARK: - Функция определения выбранной категории
        
        func getSelectedCategory(_ value: Double) {
            var initialValue = 0.0
            let expenseArray = categories.filter {
                $0.operation == "Expense"
            }
            let incomeArray = categories.filter {
                $0.operation == "Income"
            }
            
            if operationCategory == "Expense" {
                
                if selectedPeriodSlice == "PreviousMonth" {
                    let convertedArray = expenseArray
                        .sorted(by: { $1.sumPreviousMonth > $0.sumPreviousMonth })
                        .compactMap { categorie -> (String, Range<Double>)
                            in
                            let rangeEnd = initialValue + categorie.sumPreviousMonth
                            let tuple = (categorie.category, rangeEnd..<initialValue)
                            initialValue = rangeEnd
                            return tuple
                        }
                    
                    if let categorie = convertedArray.first(where: { $0.1.contains(value)}) {
                        categorySelection = categorie.0
                    }
                }
                
                if selectedPeriodSlice == "ThisMonth" {
                    let convertedArray = expenseArray
                        .sorted(by: { $1.sumThisMonth > $0.sumThisMonth })
                        .compactMap { categorie -> (String, Range<Double>)
                            in
                            let rangeEnd = initialValue + categorie.sumThisMonth
                            let tuple = (categorie.category, rangeEnd..<initialValue)
                            initialValue = rangeEnd
                            return tuple
                        }
                    
                    if let categorie = convertedArray.first(where: { $0.1.contains(value)}) {
                        categorySelection = categorie.0
                    }
                }
                
                if selectedPeriodSlice == "ThisYear" {
                    let convertedArray = expenseArray
                        .sorted(by: { $1.sumThisYear > $0.sumThisYear })
                        .compactMap { categorie -> (String, Range<Double>)
                            in
                            let rangeEnd = initialValue + categorie.sumThisYear
                            let tuple = (categorie.category, rangeEnd..<initialValue)
                            initialValue = rangeEnd
                            return tuple
                        }
                    
                    if let categorie = convertedArray.first(where: { $0.1.contains(value)}) {
                        categorySelection = categorie.0
                    }
                }
                
                if selectedPeriodSlice == "PreviousYear" {
                    let convertedArray = expenseArray
                        .sorted(by: { $1.sumPreviousYear > $0.sumPreviousYear })
                        .compactMap { categorie -> (String, Range<Double>)
                            in
                            let rangeEnd = initialValue + categorie.sumPreviousYear
                            let tuple = (categorie.category, rangeEnd..<initialValue)
                            initialValue = rangeEnd
                            return tuple
                        }
                    
                    if let categorie = convertedArray.first(where: { $0.1.contains(value)}) {
                        categorySelection = categorie.0
                    }
                }
                
                if selectedPeriodSlice == "AllData" {
                    let convertedArray = expenseArray
                        .sorted(by: { $1.categorySum > $0.categorySum })
                        .compactMap { categorie -> (String, Range<Double>)
                            in
                            let rangeEnd = initialValue + categorie.categorySum
                            let tuple = (categorie.category, rangeEnd..<initialValue)
                            initialValue = rangeEnd
                            return tuple
                        }
                    
                    if let categorie = convertedArray.first(where: { $0.1.contains(value)}) {
                        categorySelection = categorie.0
                    }
                }
            } else {
                
                if selectedPeriodSlice == "PreviousMonth" {
                    let convertedArray = incomeArray
                        .sorted(by: { $0.sumPreviousMonth > $1.sumPreviousMonth })
                        .compactMap { categorie -> (String, Range<Double>)
                            in
                            let rangeEnd = initialValue + categorie.sumPreviousMonth
                            let tuple = (categorie.category, initialValue..<rangeEnd)
                            initialValue = rangeEnd
                            return tuple
                        }
                    
                    if let categorie = convertedArray.first(where: { $0.1.contains(value)}) {
                        categorySelection = categorie.0
                    }
                }
                
                if selectedPeriodSlice == "ThisMonth" {
                    let convertedArray = incomeArray
                        .sorted(by: { $0.sumThisMonth > $1.sumThisMonth })
                        .compactMap { categorie -> (String, Range<Double>)
                            in
                            let rangeEnd = initialValue + categorie.sumThisMonth
                            let tuple = (categorie.category, initialValue..<rangeEnd)
                            initialValue = rangeEnd
                            return tuple
                        }
                    
                    if let categorie = convertedArray.first(where: { $0.1.contains(value)}) {
                        categorySelection = categorie.0
                    }
                }
                
                if selectedPeriodSlice == "ThisYear" {
                    let convertedArray = incomeArray
                        .sorted(by: { $0.sumThisYear > $1.sumThisYear })
                        .compactMap { categorie -> (String, Range<Double>)
                            in
                            let rangeEnd = initialValue + categorie.sumThisYear
                            let tuple = (categorie.category, initialValue..<rangeEnd)
                            initialValue = rangeEnd
                            return tuple
                        }
                    
                    if let categorie = convertedArray.first(where: { $0.1.contains(value)}) {
                        categorySelection = categorie.0
                    }
                }
                
                if selectedPeriodSlice == "PreviousYear" {
                    let convertedArray = incomeArray
                        .sorted(by: { $0.sumPreviousYear > $1.sumPreviousYear })
                        .compactMap { categorie -> (String, Range<Double>)
                            in
                            let rangeEnd = initialValue + categorie.sumPreviousYear
                            let tuple = (categorie.category, initialValue..<rangeEnd)
                            initialValue = rangeEnd
                            return tuple
                        }
                    
                    if let categorie = convertedArray.first(where: { $0.1.contains(value)}) {
                        categorySelection = categorie.0
                    }
                }
                
                if selectedPeriodSlice == "AllData" {
                    let convertedArray = incomeArray
                        .sorted(by: { $0.categorySum > $1.categorySum })
                        .compactMap { categorie -> (String, Range<Double>)
                            in
                            let rangeEnd = initialValue + categorie.categorySum
                            let tuple = (categorie.category, initialValue..<rangeEnd)
                            initialValue = rangeEnd
                            return tuple
                        }
                    
                    if let categorie = convertedArray.first(where: { $0.1.contains(value)}) {
                        categorySelection = categorie.0
                    }
                }
            }
        }
        
// MARK: - Функция получения значения выбранной на диаграмме категории
        
        func getCategoryAmount(_ category: String) -> Double? {

            if selectedPeriodSlice == "PreviousMonth" {
                if let amount = categories.first(where: {
                    $0.category == category
                }) {
                    return amount.sumPreviousMonth
                }
                return nil
            }
            if selectedPeriodSlice == "ThisMonth" {
                if let amount = categories.first(where: {
                    $0.category == category
                }) {
                    return amount.sumThisMonth
                }
                return nil
            }
            if selectedPeriodSlice == "ThisYear" {
                if let amount = categories.first(where: {
                    $0.category == category
                }) {
                    return amount.sumThisYear
                }
                return nil
            }
            if selectedPeriodSlice == "PreviousYear" {
                if let amount = categories.first(where: {
                    $0.category == category
                }) {
                    return amount.sumPreviousYear
                }
                return nil
            }
            if selectedPeriodSlice == "AllData" {
                if let amount = categories.first(where: {
                    $0.category == category
                }) {
                    return amount.categorySum
                }
                return nil
            } else {
                return nil
            }
        }

// MARK: - Функция расчета доли категории в общей сумме по операции
    
    func getShareAmount() -> Double? {
        
        var categoryAmount: Double
        
        if operationCategory == "Expense" {
            categoryAmount = getCategoryAmount(categorySelection ?? "") ?? 0
            guard totalExpense() != 0 else {return nil}
            return categoryAmount / totalExpense() * 100
        } else {
            categoryAmount = getCategoryAmount(categorySelection ?? "") ?? 0
            guard totalExpense() != 0 else {return nil}
            return categoryAmount / totalExpense() * 100
        }
    }
    
   
    
}

