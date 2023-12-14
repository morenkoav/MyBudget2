//
//  BudgetViewComponents.swift
//  MyBudget
//
//  Created by Anton Morenko on 03.12.2023.
//

import SwiftUI

extension BudgetView {
    
//    MARK: - Выбор категории для бюджета
    
    func categoryPicker() -> some View {
        
        return HStack{
            Text("Категория")
            
            Spacer()
            Image(category?.image ?? "")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 30, maxHeight: 30)
            Menu {
                ForEach(categorySet) { cat in
                    Button(action: {self.category = cat}, label: {
                        Image(cat.image)
                        Text(cat.category)
                            .lineLimit(1)
                    })
                }
            } label: {
                if let category = category?.category {
                    Text(category)
                }
                else {
                    Text("Выбрать категорию")
                }
            }
        }
    }
    
//    MARK: - Информационное поле со статусом бюджета
    
    func budgetStatus() -> some View {
        
        return ZStack {
            if moneyToAssign() < 0 {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.red.opacity(0.6))
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 80)
                .font(.title2)
                
                VStack {
                    Text(moneyToAssign().formatted())
                        .bold()
                        .font(.title)
                    Text("Дефицит бюджета")
                        .font(.title3)
                }

            }
            
            if moneyToAssign() >= 0 {
            RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
                .foregroundStyle(.green.opacity(0.6))
                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: 80)
                .font(.title2)
                
                VStack {
                    Text(moneyToAssign().formatted())
                        .bold()
                        .font(.title)
                    Text("Средства к распределению")
                        .font(.subheadline)
                }

            }
            
        }
        .padding()
    }
    
    //    MARK: - Выбор типа назначения бюджета
        
        func assignationTypePicker() -> some View {
            return Picker("", selection: $assignationType, content: {
                Text("Корректировка")
                    .tag("Direct")
                Text("Перенос")
                    .tag("Transfer")
            })
            .pickerStyle(.segmented)
        }
    
//    MARK: - Выбор категории для переноса бюджета С
        
    func budgetPickerTransferFrom() -> some View {
        
        return HStack{
            Text("C ")
            Spacer()

            Menu {
                ForEach(budgets) { bud in
                    Button(action: {self.budgetFrom = bud}, label: {
                        Image(bud.category?.image ?? "")
                        Text("\(bud.category?.category ?? ""): \(bud.budgetRemain.formatted())")
                            .lineLimit(1)
                    })
                }
            } label: {
                if let budgetFrom = budgetFrom?.category?.category {
                    Text(budgetFrom)
                } else {
                    Text("Выбрать бюджет")
                }
            }
        }
    }

    //    MARK: - Выбор категории для переноса бюджета НА
            
        func budgetPickerTransferTo() -> some View {
            
            return HStack {
                Text("На ")
                Spacer()

                Menu {
                    ForEach(budgets) { bud in
                        Button(action: {self.budgetToEdit = bud}, label: {
                            Image(bud.category?.image ?? "")
                            Text("\(bud.category?.category ?? ""): \(bud.budgetRemain.formatted())")
                                .lineLimit(1)
                        })
                    }
                } label: {
                    if let budgetToEdit = budgetToEdit?.category?.category {
                        Text(budgetToEdit)
                    } else {
                        Text("Выбрать бюджет")
                    }
                }
            }
        }
    
    
    
}
