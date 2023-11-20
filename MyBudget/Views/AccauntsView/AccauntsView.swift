//
//  AccauntsView.swift
//  MyBudget
//
//  Created by Anton Morenko on 20.11.2023.
//

import SwiftUI

struct AccauntsView: View {
    

    
    var body: some View {
        NavigationStack {
            List {
                
            }
            .navigationTitle("Мои счета")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing,
                            content: {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    }

                })
            }
        }
    }
}

#Preview {
    AccauntsView()
}
