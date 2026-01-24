//
//  CategoryChip.swift
//  Accessa
//
//  Created by Tatarella on 24.01.26.
//

import SwiftUI

struct CategoryChip: View {
    //MARK: - Properties
    let title: String
    let isSelected: Bool
    let onTap: () -> Void

    //MARK: - Body
    var body: some View {
        Button(action: onTap) {
            Text(title)
                .font(.app(size: .sm, weight: .bold))
                .foregroundStyle(isSelected ? Color.white : Color.colorGray900)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 10)
                .background(isSelected ? Color.colorPrimary : Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 999)
                        .stroke(
                            isSelected ? Color.clear : Color.colorGray300,
                            lineWidth: 1
                        )
                )
                .clipShape(Capsule())
        }
        .buttonStyle(.plain)
    }
}
