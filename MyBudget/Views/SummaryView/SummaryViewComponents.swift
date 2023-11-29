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
                              selectedPeriodSlice == "PreviousMonth" ? categorie.sumPreviousMonth :
                                selectedPeriodSlice == "ThisMonth" ? categorie.sumThisMonth :
                                selectedPeriodSlice == "ThisYear" ? categorie.sumThisYear :
                                selectedPeriodSlice == "PreviousYear" ? categorie.sumPreviousYear :
                                categorie.categorySum),
                innerRadius: .ratio(0.620),
                outerRadius: categorySelection == categorie.category ? 130 : 120,
                angularInset: -10
            )
            .cornerRadius(5)
            .foregroundStyle(by: .value("Категория", categorie.category))
            .opacity(categorySelection == nil ? 1: (categorySelection == categorie.category ? 1 : 0.5))
        }
        .chartAngleSelection(value: $selectedSector)
        .chartLegend(position: .bottom, alignment: .center, spacing: 10)
        .onChange(of: selectedSector, initial: false) {oldValue, newValue in
            if let newValue {
                getSelectedCategory(newValue)
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
}

