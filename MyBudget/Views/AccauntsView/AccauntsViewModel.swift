//
//  AccauntsViewModel.swift
//  MyBudget
//
//  Created by Anton Morenko on 03.12.2023.
//

import SwiftUI

extension AccauntsView {
    
    func updateAccauntData() {
        accauntToEdit?.accauntName = accauntName
        accauntToEdit?.startBalance = startBalance
        accauntToEdit?.isTrackingAccaunt = isTrackingAccaunt
    }
    
    func addAccaunt() {
        let accaunt = Accaunts(accauntName: accauntName, startBalance: startBalance, isTrackingAccaunt: isTrackingAccaunt)
        accauntContext.insert(accaunt)
    }
    
    func clearAndCloseAccauntForm() {
        isUpdatingMode = false
        showAddAccauntDialog = false
        accauntName = ""
        startBalance = 0
    }
    
}
