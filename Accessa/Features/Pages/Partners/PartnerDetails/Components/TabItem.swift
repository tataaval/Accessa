//
//  TabItem.swift
//  Accessa
//
//  Created by Tatarella on 13.01.26.
//

import SwiftUI

struct TabItem: View {
    //MARK: - properties
    let id: Int
    let title: String

    @Binding var selectedTab: Int

    //MARK: - Calculated properties
    private var isSelected: Bool {
        selectedTab == id
    }

    //MARK: - Body
    var body: some View {
        Button {
            selectedTab = id
        } label: {
            Text(title)
                .font(.app(size: .sm, weight: .bold))
                .foregroundColor(isSelected ? .colorPrimary : .colorGray500)
                .padding(.bottom, 16)
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .fill(isSelected ? .colorPrimary : .clear)
                        .frame(height: 2)
                }
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}
