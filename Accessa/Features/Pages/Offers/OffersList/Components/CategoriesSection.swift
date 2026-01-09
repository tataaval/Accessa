//
//  CategoriesSection.swift
//  Accessa
//
//  Created by Tatarella on 09.01.26.
//

import SwiftUI

struct CategoriesSection: View {
    //MARK: - Properties
    let categories: [CategoryModel]
    let selectedCategoryId: Int?
    let onSelect: (Int) -> Void

    //MARK: - Body
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                CategoryItem(
                    title: "All",
                    isSelected: selectedCategoryId == nil
                )
                .onTapGesture { onSelect(-1) }
                ForEach(categories) { category in
                    CategoryItem(
                        title: category.title,
                        isSelected: category.id == selectedCategoryId
                    )
                    .onTapGesture {
                        onSelect(category.id)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}
