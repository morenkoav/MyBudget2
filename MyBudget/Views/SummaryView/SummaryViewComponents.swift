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
                        VStack(alignment: .center){
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
    
    
    //    MARK: - Диаграммы категорий расходов и доходов
    
    func categoryStructureChart() -> some View {
        
        let expenseArray = categories.filter {
            $0.operation == "Expense"
        }
        
        let incomeArray = categories.filter {
            $0.operation == "Income"
        }
        
        return Chart(operationCategory == "Expense" ? expenseArray : incomeArray) { categorie in
            SectorMark(
                angle: .value("Cумма",
                              selectedPeriodSlice == "PreviousMonth" ? categorie.absSumPreviousMonth :
                                selectedPeriodSlice == "ThisMonth" ? categorie.absSumThisMonth :
                                selectedPeriodSlice == "ThisYear" ? categorie.absSumThisYear :
                                selectedPeriodSlice == "PreviousYear" ? categorie.absSumPreviousYear :
                                categorie.absCategorySum),
                innerRadius: .ratio(0.620),
                outerRadius: categorySelection == categorie.category ? 130 : 120,
                angularInset: 1.5
            )
            .cornerRadius(5.0)
            .foregroundStyle(by: .value("Категория", categorie.category))
            .opacity(categorySelection == nil ? 1: (categorySelection == categorie.category ? 1 : 0.5))
        }
        .chartAngleSelection(value: $selectedSector)
        .chartLegend(position: .bottom, alignment: .center, spacing: 10)
        .chartLegend(.hidden)
        .scaledToFit()
        .onChange(of: selectedSector, initial: false) {oldValue, newValue in
            if let newValue {
                getSelectedCategory(Int(newValue))
            } else {
                categorySelection = nil
            }
        }
        .chartBackground { chartProxy in
            GeometryReader { geometry in
                let frame = geometry[chartProxy.plotFrame!]
                VStack {
                    Text(categorySelection ?? "")
                        .font(.title)
                    Text(getCategoryAmount(categorySelection ?? "")?.formatted() ?? "")
                        .foregroundStyle(operationCategory == "Expense" ? .red : .green)
                        .bold()
                        .font(.title2)
                    Text(getCategoryAmount(categorySelection ?? "") != nil ? "\(getShareAmount()?.rounded(toPosition: 2).formatted() ?? "")%" : "")
                }
                .position(x: frame.midX, y: frame.midY)
            }
        }
    }
   
    
    func incomeDynamicChart() -> some View {
        let incomeTransactions = transactions.filter {
            $0.category?.operation == "Income"
        }
        
        let monthlyIncome = incomeTransactions.reduce(into: [Date: Double]()) {
            result, income in
            let components = Calendar.current.dateComponents([.month, .year], from: income.date)
            let month = calendar.date(from: components)!
            result[month, default: 0] += income.absAmount
        }.map {
            MonthlyIncome(id: UUID(), month: $0.key, sum: $0.value)
        }
        
        return VStack {
            HStack {
                Text("Доходы")
                    .font(.headline.bold())
                Spacer()
            }
            Chart(monthlyIncome, id: \.month) { income in
                BarMark(
                    x: .value("Месяц", income.month, unit: .month),
                    y: .value("Сумма", income.sum)
                )
                .foregroundStyle(.green)
            }
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 3600 * 24 * 30 * 12)
            .chartScrollTargetBehavior(
                .valueAligned(
                    matching: .init(month: 0),
                    majorAlignment: .matching(.init(month: 12))))
            .chartXAxis {
                AxisMarks(values: .stride(by: .month)) { _ in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.month(.abbreviated), centered: true)
                }
            }
        }
        .padding()
            
    }
    
    func expenseDynamicChart() -> some View {
        let expenseTransactions = transactions.filter {
            $0.category?.operation == "Expense"
        }
        
        let monthlyExpense = expenseTransactions.reduce(into: [Date: Double]()) {
            result, expense in
            let components = Calendar.current.dateComponents([.month, .year], from: expense.date)
            let month = calendar.date(from: components)!
            result[month, default: 0] += expense.absAmount
        }.map {
            MonthlyExpense(id: UUID(), month: $0.key, sum: $0.value)
        }
        
        return VStack {
            HStack {
                Text("Расходы")
                    .font(.headline.bold())
                Spacer()
            }
            Chart(monthlyExpense, id: \.month) { expense in
                BarMark(
                    x: .value("Месяц", expense.month, unit: .month),
                    y: .value("Сумма", expense.sum)
                )
                .foregroundStyle(.red)
            }
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 3600 * 24 * 30 * 12)
            .chartScrollTargetBehavior(.valueAligned(unit: 1))
            .chartXAxis {
                AxisMarks(values: .stride(by: .month)) { _ in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.month(.abbreviated), centered: true)
                }
            }
        }
        .padding()
            
    }
    
    func cashFlowDynamicChart() -> some View {
        let incomeTransactions = transactions.filter {
            $0.category?.operation == "Income"
        }
        
        let monthlyIncome = incomeTransactions.reduce(into: [Date: Double]()) {
            result, income in
            let components = Calendar.current.dateComponents([.month, .year], from: income.date)
            let month = calendar.date(from: components)!
            result[month, default: 0] += income.absAmount
        }.map {
            MonthlyIncome(id: UUID(), month: $0.key, sum: $0.value)
        }

        let expenseTransactions = transactions.filter {
            $0.category?.operation == "Expense"
        }
        
        let monthlyExpense = expenseTransactions.reduce(into: [Date: Double]()) {
            result, expense in
            let components = Calendar.current.dateComponents([.month, .year], from: expense.date)
            let month = calendar.date(from: components)!
            result[month, default: 0] += expense.absAmount
        }.map {
            MonthlyExpense(id: UUID(), month: $0.key, sum: $0.value)
        }
        
        return VStack {
            HStack {
                Text("Денежный поток")
                    .font(.headline.bold())
                Spacer()
            }
            Chart {
                ForEach(monthlyIncome, id: \.month) { income in
                    LineMark(
                        x: .value("Дата", income.month, unit: .month),
                        y: .value("Доход", income.sum),
                        series: .value("Месяц",  "Доход")
                    )
                    
                }
                .foregroundStyle(.green)
                .interpolationMethod(.cardinal)
                .lineStyle(StrokeStyle(lineWidth: 3))
                .symbolSize(100)
                
                ForEach(monthlyExpense, id: \.month) { expense in
                    LineMark(
                        x: .value("Дата", expense.month, unit: .month),
                        y: .value("Расход", expense.sum),
                        series: .value("Месяц",  "Расход")
                    )
                    
                }
                .foregroundStyle(.red)
                .interpolationMethod(.cardinal)
                .lineStyle(StrokeStyle(lineWidth: 3))
                .symbolSize(100)
                
            }
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 3600 * 24 * 30 * 12)
            .chartScrollTargetBehavior(.valueAligned(unit: 1))
            .chartXAxis {
                AxisMarks(values: .stride(by: .month)) { _ in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.month(.abbreviated), centered: true)
                }
            }
        }
        .padding()
    }
    
    func cashFlowChart() -> some View {
        
        
        let monthlyCF = transactions.reduce(into: [Date: Double]()) {
            result, cashFlow in
            let components = Calendar.current.dateComponents([.month, .year], from: cashFlow.date)
            let month = calendar.date(from: components)!
            result[month, default: 0] += cashFlow.amount
        }.map {
            MonthlyCashFlow(id: UUID(), month: $0.key, sum: $0.value)
        }
        
        return VStack {
            HStack {
                Text("Результат")
                    .font(.headline.bold())
                Spacer()
            }
            
            Chart(monthlyCF) { cf in
                BarMark(
                    x: .value("Месяц", cf.month, unit: .month),
                    y: .value("Результат", cf.sum)
                )
                .foregroundStyle(cf.sum < 0 ? .red : .green)
            }
            .chartScrollableAxes(.horizontal)
            .chartXVisibleDomain(length: 3600 * 24 * 30 * 12)
            .chartScrollTargetBehavior(.valueAligned(unit: 1))
            .chartXAxis {
                AxisMarks(values: .stride(by: .month)) { _ in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.month(.abbreviated), centered: true)
                }
            }
        }
        .padding()
    }

}
