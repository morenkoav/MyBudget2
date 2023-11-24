//
//  CategoriesViewComponents.swift
//  MyBudget
//
//  Created by Anton Morenko on 21.11.2023.
//

import SwiftUI

extension CategoriesView {
    
    func updateCategoryData() {
        categorieToEdit?.operation = operationName
        categorieToEdit?.category = categoryName
        categorieToEdit?.image = categoryImage
    }
    
    func addCategory() {
        let category = Categories(
            operation: operationName,
            category: categoryName,
            categoryImage: categoryImage
        )
        categoryContext.insert(category)
    }
    
    func clearAndCloseCategoryForm() {
        categoryName = ""
        categoryImage = ""
        isUpdatingMode = false
        showEditCategoryForm = false
    }
    
    func formIsValid() -> Bool {
        !categoryName.isEmptyOrWhiteSpace && !categoryImage.isEmpty
    }
    
    var editCategoryForm: some View {
        NavigationStack {
            List {
                Picker("", selection: $operationName, content: {
                    Text("Доход")
                        .tag("Income")
                    Text("Расход")
                        .tag("Expense")
                    Text("Перевод")
                        .tag("Transfer")
                })
                .pickerStyle(.segmented)
                TextField("Название категории", text: $categoryName)
                HStack(alignment: .center) {
                    Spacer()
                    Image(categoryImage)
                    Button("Выбрать иконку", action: {
                        showIconPicker.toggle()
                    })
                    Spacer()
                }
            }
            .navigationTitle(isUpdatingMode ? "Изменить категорию" : "Добавить категорию")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Отмена") {
                        showEditCategoryForm = false
                        isUpdatingMode = false
                    }
                    .tint(.red)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(isUpdatingMode ? "Изменить" : "Добавить") {
                        if isUpdatingMode {
                            updateCategoryData()
                            clearAndCloseCategoryForm()
                        } else {
                            addCategory()
                            clearAndCloseCategoryForm()
                        }
                    }
                    .disabled(!formIsValid())
                }
            }
        }
        .presentationDetents([.height(280)])
        .presentationCornerRadius(25)
        .interactiveDismissDisabled()
        .sheet(isPresented: $showIconPicker, content: {
            iconPicker
        })
               
    }
    
        var iconPicker: some View {
            
            VStack {
                          
                if operationName ==  "Income" {
                    imagePicker(imageSet: incomeImages)
                }
                
                if operationName ==  "Expense" {
                    imagePicker(imageSet: expenseImages)
                }
                
                if operationName ==  "Transfer" {
                    imagePicker(imageSet: transferImages)
                }
            }
        }
        
    func imagePicker(imageSet: [String]) -> some View {
        
        let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
        return NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(imageSet, id: \.self) {
                        iconName in
                        Button(action: {
                            categoryImage = iconName
                            showIconPicker = false
                        }) {
                            VStack {
                                Image(iconName)
                                    .font(.system(size: 48))
                            }
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Выберите иконку")
            .toolbar(content: {
                Button(action: {
                    showIconPicker = false
                }) {
                    Text("Отмена")
                }
            })
        }
    }
    
    
    func categoriesList(model: [Categories]) -> some View {
        return List(model) { categorie in
            
            HStack {
                Image(categorie.image)
                Text(categorie.category)
                Spacer()
                Text(categorie.categorySum.formatted())
                    .bold()
                    .multilineTextAlignment(.trailing)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                
                Button(role: .destructive, action: {categoryContext.delete(categorie)}, label: {
                    Image(systemName: "trash.fill")
                })
                
                Button(action: {
                    isUpdatingMode.toggle()
                    operationName = categorie.operation
                    categoryName = categorie.category
                    categoryImage = categorie.image
                    categorieToEdit = categorie
                    showEditCategoryForm.toggle()
               },
                       label: {
                    Image(systemName: "pencil")
                        .tint(Color.orange)
                })
            }
            
        }
    }
    
    
}

extension String {
    
    var isEmptyOrWhiteSpace: Bool {
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
