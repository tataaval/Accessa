//
//  SearchHeaderView.swift
//  Accessa
//
//  Created by Tatarella on 11.01.26.
//

import SwiftUI

struct SearchHeaderView<Content: View>: View {
    //MARK: - Properties
    private let content: Content

    //MARK: - Init
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    //MARK: - Body
    var body: some View {
        VStack(spacing: 12) {
            content
        }
        .padding(.vertical, 12)
        .background(Color.white)
    }
}
