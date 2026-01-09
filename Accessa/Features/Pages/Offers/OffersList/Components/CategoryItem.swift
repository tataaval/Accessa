//
//  CategoryItem.swift
//  Accessa
//
//  Created by Tatarella on 09.01.26.
//

import SwiftUI

struct CategoryItem: View {
    //MARK: - Properties
    let title: String
    let isSelected: Bool

    //MARK: - Body
    var body: some View {
        Text(title)
            .font(.app(size: .sm, weight: .semibold))
            .foregroundColor(isSelected ? .white : .colorGray900)
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .background(
                isSelected ? .colorPrimary : .colorGray300.opacity(0.5)
            )
            .cornerRadius(20)
    }
}
