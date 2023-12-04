//
//  BudgetsListView.swift
//  MyBudget
//
//  Created by Anton Morenko on 03.12.2023.
//

import SwiftUI

extension BudgetView {
    
    func budgetList() -> some View {
        
        return List(sortedBudgets) { budget in
            HStack(spacing:10) {
                Image(budget.category?.image ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30, maxHeight: 30)
                Text(budget.category?.category ?? "")
                    .font(.subheadline)
                    .lineLimit(2)
                    .frame(maxWidth: 110, alignment: .leading)
//                Spacer()
                VStack(alignment: .leading) {
                    Text("Бюджет: \(budget.limit.formatted())")
                    Text("Расход: \(budget.category?.absCategorySum.formatted() ?? "")")
                }
                .font(.caption)
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
//                Spacer()
                Text(budget.budgetRemain.formatted())
                    .foregroundStyle(budget.budgetRemain >= 0 ? .green : .red)
                    .bold()
                    .font(.subheadline)
                    .frame(maxWidth: 80, alignment: .trailing)
            }
            .background(budget.budgetRemain < 0 ? .red.opacity(0.2) : .clear)
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                
                Button(role: .destructive, action: {budgetContext.delete(budget)}, label: {
                    Image(systemName: "trash.fill")
                })
                
                Button(action: {
                    isUpdatingMode.toggle()
                    category = budget.category
                    limit = budget.limit
                    budgetToEdit = budget
                    showEditBudgetForm.toggle()
                },
                       label: {
                    Image(systemName: "pencil")
                        .tint(Color.orange)
                })
            }
            
        }
        .listStyle(.plain)
    }
    
    
}
