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
            
            let incomeArray = categories.filter {
                $0.operation == "Income"
            }
            
            return Group {
                if selectedPeriodSlice == "PreviousMonth" {
                    let sortedIncomeArray = incomeArray
                        .sorted(by: {$0.sumPreviousMonth > $1.sumPreviousMonth})
                    
                    Chart(sortedIncomeArray) { category in
                        BarMark(
                            x: .value("Сумма", category.absSumPreviousMonth),
                            y: .value("Категория", category.category)
                        )
                        .foregroundStyle(.green)
                    }
                    .padding()
                }
                
                if selectedPeriodSlice == "ThisMonth" {
                    let sortedIncomeArray = incomeArray
                        .sorted(by: {$0.sumThisMonth > $1.sumThisMonth})
                    
                    Chart(sortedIncomeArray) { category in
                        BarMark(
                            x: .value("Сумма", category.absSumThisMonth),
                            y: .value("Категория", category.category)
                        )
                        .foregroundStyle(.green)
                    }
                    .padding()
                }
                
                if selectedPeriodSlice == "ThisYear" {
                    let sortedIncomeArray = incomeArray
                        .sorted(by: {$0.sumThisYear > $1.sumThisYear})
                    
                    Chart(sortedIncomeArray) { category in
                        BarMark(
                            x: .value("Сумма", category.absSumThisYear),
                            y: .value("Категория", category.category)
                        )
                        .foregroundStyle(.green)
                    }
                    .padding()
                }
                
                if selectedPeriodSlice == "PreviousYear" {
                    let sortedIncomeArray = incomeArray
                        .sorted(by: {$0.sumPreviousYear > $1.sumPreviousYear})
                    
                    Chart(sortedIncomeArray) { category in
                        BarMark(
                            x: .value("Сумма", category.absSumPreviousYear),
                            y: .value("Категория", category.category)
                        )
                        .foregroundStyle(.green)
                    }
                    .padding()
                }
                
                if selectedPeriodSlice == "AllData" {
                    let sortedIncomeArray = incomeArray
                        .sorted(by: {$0.categorySum > $1.categorySum})
                    
                    Chart(sortedIncomeArray) { category in
                        BarMark(
                            x: .value("Сумма", category.absCategorySum),
                            y: .value("Категория", category.category)
                        )
                        .foregroundStyle(.green)
                    }
                    .padding()
                }
            }
            
        }
    
    
//    MARK: - Гистограмма категорий расходов
            
            func expenseCategoriesBarChart() -> some View {
                
                let expenseArray = categories.filter {
                    $0.operation == "Expense"
                }

                return Group {
                    if selectedPeriodSlice == "PreviousMonth" {
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
