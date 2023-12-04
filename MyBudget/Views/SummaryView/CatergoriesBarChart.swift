//
//  CatergoriesBarChart.swift
//  MyBudget
//
//  Created by Anton Morenko on 02.12.2023.
//

import SwiftUI
import Charts

extension SummaryView {
    
//    MARK: - Гистограмма категорий доходов
        
        func incomeCategoriesBarChart() -> some View {
            
            return Group {
                if selectedPeriodSlice == "PreviousMonth" {
                    let incomeArray = categories.filter {
                        $0.operation == "Income" && $0.sumPreviousMonth > 0
                    }
                    let sortedIncomeArray = incomeArray
                        .sorted(by: {$0.sumPreviousMonth > $1.sumPreviousMonth})
                    
                    Chart(sortedIncomeArray) { category in
                        BarMark(
                            x: .value("Сумма", category.absSumPreviousMonth),
                            y: .value("Категория", category.category),
                            width: MarkDimension.fixed(100)
                        )
                        .foregroundStyle(.green)
                    }
                    
                    .padding()
                }
                
                if selectedPeriodSlice == "ThisMonth" {
                    let incomeArray = categories.filter {
                        $0.operation == "Income" && $0.sumThisMonth > 0
                    }
                    let sortedIncomeArray = incomeArray
                        .sorted(by: {$0.sumThisMonth > $1.sumThisMonth})
                    
                    Chart(sortedIncomeArray) { category in
                        BarMark(
                            x: .value("Сумма", category.absSumThisMonth),
                            y: .value("Категория", category.category),
                            width: MarkDimension.fixed(100)
                        )
                        .foregroundStyle(.green)
                    }
                    .padding()
                }
                
                if selectedPeriodSlice == "ThisYear" {
                    let incomeArray = categories.filter {
                        $0.operation == "Income" && $0.absSumThisYear > 0
                    }
                    let sortedIncomeArray = incomeArray
                        .sorted(by: {$0.sumThisYear > $1.sumThisYear})
                    
                    Chart(sortedIncomeArray) { category in
                        BarMark(
                            x: .value("Сумма", category.absSumThisYear),
                            y: .value("Категория", category.category),
                            width: MarkDimension.fixed(100)
                        )
                        .foregroundStyle(.green)
                    }
                    .padding()
                }
                
                if selectedPeriodSlice == "PreviousYear" {
                    let incomeArray = categories.filter {
                        $0.operation == "Income" && $0.sumPreviousYear > 0
                    }
                    let sortedIncomeArray = incomeArray
                        .sorted(by: {$0.sumPreviousYear > $1.sumPreviousYear})
                    
                    Chart(sortedIncomeArray) { category in
                        BarMark(
                            x: .value("Сумма", category.absSumPreviousYear),
                            y: .value("Категория", category.category),
                            width: MarkDimension.fixed(100)
                        )
                        .foregroundStyle(.green)
                    }
                    .padding()
                }
                
                if selectedPeriodSlice == "AllData" {
                    let incomeArray = categories.filter {
                        $0.operation == "Income" && $0.categorySum > 0
                    }
                    let sortedIncomeArray = incomeArray
                        .sorted(by: {$0.categorySum > $1.categorySum})
                    
                    Chart(sortedIncomeArray) { category in
                        BarMark(
                            x: .value("Сумма", category.absCategorySum),
                            y: .value("Категория", category.category),
                            width: MarkDimension.fixed(100)
                        )
                        .foregroundStyle(.green)
                    }
                    .padding()
                }
            }
            
        }
    
    
//    MARK: - Гистограмма категорий расходов
            
            func expenseCategoriesBarChart() -> some View {
                


                return Group {
                    if selectedPeriodSlice == "PreviousMonth" {
                        let expenseArray = categories.filter {
                            $0.operation == "Expense" && $0.absSumPreviousMonth > 0
                        }
                        let sortedExpenseArray = expenseArray
                            .sorted(by: { $0.absSumPreviousMonth > $1.absSumPreviousMonth })
                        
                        Chart(sortedExpenseArray) { category in
                                BarMark(
                                    x: .value("Сумма", category.absSumPreviousMonth),
                                    y: .value("Категория", category.category)
                                )
                                .foregroundStyle(.red)
                            }
                            .padding()
                    }
                    
                    if selectedPeriodSlice == "ThisMonth" {
                        let expenseArray = categories.filter {
                            $0.operation == "Expense" && $0.absSumThisMonth > 0
                        }
                        let sortedExpenseArray = expenseArray
                            .sorted(by: { $0.absSumThisMonth > $1.absSumThisMonth })
                        
                        Chart(sortedExpenseArray) { category in
                                BarMark(
                                    x: .value("Сумма", category.absSumThisMonth),
                                    y: .value("Категория", category.category)
                                )
                                .foregroundStyle(.red)
                            }
                            .padding()
                    }
                    
                    if selectedPeriodSlice == "ThisYear" {
                        let expenseArray = categories.filter {
                            $0.operation == "Expense" && $0.absSumThisYear > 0
                        }
                        let sortedExpenseArray = expenseArray
                            .sorted(by: { $0.absSumThisYear > $1.absSumThisYear })
                        
                        Chart(sortedExpenseArray) { category in
                                BarMark(
                                    x: .value("Сумма", category.absSumThisYear),
                                    y: .value("Категория", category.category)
                                )
                                .foregroundStyle(.red)
                            }
                            .padding()
                    }
                    
                    if selectedPeriodSlice == "PreviousYear" {
                        let expenseArray = categories.filter {
                            $0.operation == "Expense" && $0.absSumPreviousYear > 0
                        }
                        let sortedExpenseArray = expenseArray
                            .sorted(by: { $0.absSumPreviousYear > $1.absSumPreviousYear })
                        
                        Chart(sortedExpenseArray) { category in
                                BarMark(
                                    x: .value("Сумма", category.absSumPreviousYear),
                                    y: .value("Категория", category.category)
                                )
                                .foregroundStyle(.red)
                            }
                            .padding()
                    }
                    
                    if selectedPeriodSlice == "AllData" {
                        let expenseArray = categories.filter {
                            $0.operation == "Expense" && $0.absCategorySum > 0
                        }
                        let sortedExpenseArray = expenseArray
                            .sorted(by: { $0.absCategorySum > $1.absCategorySum })
                        
                        Chart(sortedExpenseArray) { category in
                                BarMark(
                                    x: .value("Сумма", category.absCategorySum),
                                    y: .value("Категория", category.category)
                                )
                                .foregroundStyle(.red)
                            }
                            .padding()
                    }
                }
            }
    
}
