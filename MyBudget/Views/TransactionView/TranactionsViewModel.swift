//
//  TranactionsModel.swift
//  MyBudget
//
//  Created by Anton Morenko on 03.12.2023.
//

import SwiftUI

extension TransactionCommonForm {
   
    
//    MARK: - Создание транзакции
    
    func addTransaction() {
        
        if operationCategory == "Income" {
            let incomeTransaction = Transactions(
                date: transactionDate,
                isPassiveIncome: isPassiveIncome,
                isInvestments: isInvestments,
                amount: amount!,
                memo: memo
            )
            
            transactionContext.insert(incomeTransaction)
            
            accaunt?.transactions.append(incomeTransaction)
            category?.transactions.append(incomeTransaction)
            
            
        }
        
        if operationCategory == "Expense" {
            let expenseTransaction = Transactions(
                date: transactionDate,
                isPassiveIncome: isPassiveIncome,
                isInvestments: isInvestments,
                amount: -amount!,
                memo: memo
            )
            transactionContext.insert(expenseTransaction)
            
            accaunt?.transactions.append(expenseTransaction)
            category?.transactions.append(expenseTransaction)
        }
        
        if operationCategory == "Transfer" {
            let transactionFrom = Transactions(
                date: transactionDate,
                isPassiveIncome: false,
                isInvestments: false,
                amount: -amount!,
                memo: memo
            )
            let transactionTo = Transactions(
                date: transactionDate,
                isPassiveIncome: false,
                isInvestments: false,
                amount: amount!,
                memo: memo
            )
            
            transactionContext.insert(transactionFrom)
            transactionContext.insert(transactionTo)
            
            accaunt?.transactions.append(transactionFrom)
            category?.transactions.append(transactionFrom)
            
            transferToAccaunt?.transactions.append(transactionTo)
            category?.transactions.append(transactionTo)
        }
    }
    
//    MARK: - Очистка полей формы и закрытие диалогового окна
    
    func clearAndCloseTransactionForm() {
        dismiss()
        category = nil
        accaunt = nil
        transferToAccaunt = nil
        transactionDate = Date()
        amount = nil
        memo = ""
    }
    
//    MARK: - Проверка валидности формы создания / обновления трпанзакции
    
    func formIsValid() -> Bool {
        if operationCategory != "Transfer" {
            amount != nil && accaunt != nil && category != nil
        } else {
            amount != nil && accaunt != nil && transferToAccaunt != nil && category != nil
        }
        
    }

//    MARK: - Функция суммирования транзакций за период
    
    func sumOfTransactions(model: [Transactions]) -> Double {
        
        let sum = model.reduce(0) { result, item in
            return result + item.amount
        }
        return sum
    }
    
    
}
