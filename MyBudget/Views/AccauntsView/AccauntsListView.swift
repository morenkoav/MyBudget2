//
//  AccauntsListView.swift
//  MyBudget
//
//  Created by Anton Morenko on 03.12.2023.
//

import SwiftUI

extension AccauntsView {
    
    func accauntList(model: [Accaunts]) -> some View {
        return List(model) { accaunt in
                   
            HStack {
                VStack(alignment: .leading){
                    Text(accaunt.accauntName)
                    if accaunt.isTrackingAccaunt {
                        Text("В балансе")
                            .font(.caption2)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 4)
                            .background(.green.gradient, in: .capsule)
                    } else {
                        Text("За балансом")
                            .font(.caption2)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 4)
                            .background(.red.gradient, in: .capsule)
                    }
                    
                }
                .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                Spacer()
                Text(accaunt.currentBalance.formatted())
                    .bold()
                    .multilineTextAlignment(.trailing)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                
                Button(role: .destructive, action: {accauntContext.delete(accaunt)}, label: {
                    Image(systemName: "trash.fill")
                })
                
                Button(action: {
                    isUpdatingMode.toggle()
                    accauntName = accaunt.accauntName
                    startBalance = accaunt.startBalance
                    isTrackingAccaunt = accaunt.isTrackingAccaunt
                    accauntToEdit = accaunt
                    showAddAccauntDialog.toggle()},
                       label: {
                    Image(systemName: "pencil")
                        .tint(Color.orange)
                })
            }
            
        }
    }
    
}
