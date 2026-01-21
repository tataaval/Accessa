//
//  ProfileView.swift
//  Accessa
//
//  Created by Tatarella on 03.01.26.
//

import SwiftUI

struct ProfileView: View {
    // MARK: - StateObject
    @StateObject private var viewModel: ProfileViewModel = ProfileViewModel()

    //MARK: - properties
    @State private var showDeleteAlert = false
    let router: ProfileRouter

    //MARK: - body
    var body: some View {
        ZStack(alignment: .top) {
            Color.colorGray200
                .ignoresSafeArea()
            if let cardInfo = viewModel.cardInfo {
                ScrollView {
                    VStack(spacing: 24) {
                        ProfileHeader()
                            .ignoresSafeArea(edges: .top)
                        MembershipCard(cardInfo: cardInfo)
                        QuickSettings(
                            onEditProfile: router.editProfile,
                            onEditPassword: router.changePassword
                        )
                        ActionButtons(
                            onLogout: router.logout,
                            onDeleteProfile: {
                                showDeleteAlert = true
                            }
                        )
                    }
                }
                .ignoresSafeArea(edges: .top)

            } else {
                LoadingOverlay(text: "Loading Profile...")
            }
        }
        .task {
            await viewModel.loadData()
        }
        .alert(
            "Error",
            isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )
        ) {
            Button("Retry") {
                Task { await viewModel.loadData() }
            }
            Button("OK", role: .cancel) {}
        } message: {
            Text(viewModel.errorMessage ?? "An unknown error occurred")
        }
        .alert("Delete Account", isPresented: $showDeleteAlert) {
            Button("Delete Account", role: .destructive) {
                Task {
                    await viewModel.deleteProfile()
                    if viewModel.errorMessage == nil {
                        router.logout()
                    }
                }
            }

            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This action is permanent and cannot be undone.")
        }
    }

}
