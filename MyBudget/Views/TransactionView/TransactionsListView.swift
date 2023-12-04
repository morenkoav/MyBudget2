//
//  TransactionsListView.swift
//  MyBudget
//
//  Created by Anton Morenko on 03.12.2023.
//

import SwiftUI

extension TransactionView {
    
//    MARK: - Формирование листа транзакций
    
    func transactionsList(model: [Transactions]) -> some View {
        return List(model) { transaction in
            HStack {
                Image(transaction.category?.image ?? "")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 30, maxHeight: 30)
                VStack(alignment: .leading) {
                    Text(transaction.category?.category ?? "")
                        .font(.subheadline)
                        .bold()
                        .lineLimit(1)
                    Text(transaction.date.formatted(date: Date.FormatStyle.DateStyle.abbreviated, time: Date.FormatStyle.TimeStyle.omitted))
                        .font(.footnote)
                    HStack {
                        Text("\(transaction.accaunt?.accauntName ?? ""):")
                            .font(.caption2)
                        if !transaction.memo.isEmpty {
                            Text("\(transaction.memo)")
                                .font(.caption)
                                .lineLimit(1)
                        }
                    }
                }
                Spacer()
                Text(transaction.amount.formatted())
                    .font(.subheadline)
                    .bold()
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(transaction.category?.operation == "Income" ? .green : transaction.category?.operation == "Expense" ? .red : .gray)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                
                Button(role: .destructive, action: {transactionContext.delete(transaction)}, label: {
                    Image(systemName: "trash.fill")
                })
                
                Button(action: {
                    isUpdatingMode.toggle()
                    category = transaction.category
                    accaunt = transaction.accaunt
                    isInvestments = transaction.isInvestments
                    isPassiveIncome = transaction.isPassiveIncome
                    transactionDate = transaction.date
                    amount = transaction.amount
                    memo = transaction.memo
                    transactionToEdit = transaction
                    showEditTransactionForm.toggle()
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
