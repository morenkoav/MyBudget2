//
//  BudgetViewModel.swift
//  MyBudget
//
//  Created by Anton Morenko on 03.12.2023.
//

import SwiftUI

extension BudgetView {
    
//    MARK: - Обновление данных бюджета
        
        func updateBudgeteData() {
            newLimit = limit + limitPlus - limitMinus
            budgetToEdit?.category = category
            budgetToEdit?.limit = newLimit
        }
        
//    MARK: - Создание бюджета
        
        func addBudget() {

            let budget = Budgets(limit: limit)
                
                budgetContext.insert(budget)
                category?.budgets.append(budget)
        }
        
//    MARK: - Очистка полей формы и закрытие диалогового окна
        
        func clearAndCloseBudgetForm() {
            category = nil
            limit = 0
            newLimit = 0
            transferLimit = nil
            budgetToEdit = nil
            budgetFrom = nil
            isUpdatingMode = false
            showEditBudgetForm = false
        }
        
//    MARK: - Проверка валидности формы создания / обновления бюджета
        
    func formIsValid() -> Bool {
        category != nil
    }
    
    func transferFormisValid() -> Bool {
        budgetToEdit != nil && budgetFrom != nil && transferLimit != nil
    }

    
//    MARK: - Вычисление суммы входящих остатков
    
    func startBalance() -> Double {
        
        let initialBalance = trackingAccaunts.reduce(0) { result, item in
            return result + item.startBalance
        }
        
        return initialBalance
    }
    
//    MARK: - Вычисление суммы операций по отслеживаемым счетам
        
        func operationsSum() -> Double {
            let incomeTransactions = transactions.filter {
                $0.category?.operation == "Income" &&
                $0.accaunt?.isTrackingAccaunt == true
            }
            let transactionsSum = incomeTransactions.reduce(0) { result, item in

                return result + item.amount
            }
            return transactionsSum
        }
 
//    MARK: - Вычисление суммы забюджетированных средств
    
    func budgetedMoney() -> Double {
        
        let budgetedMoney = budgets.reduce(0) { result, item in
            return result + item.limit
        }

       return budgetedMoney
    }
    
    func moneyToAssign() -> Double {

        return startBalance() + operationsSum() - budgetedMoney()
        
        
    }
    
//    MARK: - Перенос средств между бюджетами
            
            func transferBudgets() {
                budgetFrom?.limit -= transferLimit!
                budgetToEdit?.limit += transferLimit!
            }
    
}
