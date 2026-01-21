//
//  ProfileService.swift
//  Accessa
//
//  Created by Tatarella on 21.01.26.
//

protocol ProfileServiceProtocol {
    func changePassword(current: String, new: String, confirm: String) async throws

    func fetchUserInfo() async throws -> UserProfileModel
    func updateMobile(mobile: String) async throws
    func verifyMobile(mobile: String, code: String) async throws

    func fetchCardInfo() async throws -> CardInfoModel
    func deleteAccount() async throws
}

final class ProfileService: ProfileServiceProtocol {
    private let network: NetworkServiceProtocol

    init(network: NetworkServiceProtocol = NetworkService.shared) {
        self.network = network
    }

    func changePassword(current: String, new: String, confirm: String) async throws {
        let _: ChangePasswordResponseModel = try await network.fetch(
            from: ProfileAPI.resetPassword(
                curentPassword: current,
                password: new,
                repeatPassword: confirm
            )
        )
    }

    func fetchUserInfo() async throws -> UserProfileModel {
        try await network.fetch(from: ProfileAPI.profileInfo)
    }

    func updateMobile(mobile: String) async throws {
        let _: UpdateMobileResponseModel = try await network.fetch(from: ProfileAPI.updateMobile(mobile: mobile))
    }

    func verifyMobile(mobile: String, code: String) async throws {
        let _: VerifyMobileResponseModel = try await network.fetch(from: ProfileAPI.verifyMobile(mobile: mobile, code: code))
    }

    func fetchCardInfo() async throws -> CardInfoModel {
        try await network.fetch(from: CardAPI.cardInfo)
    }

    func deleteAccount() async throws {
        let _: DeleteProfileResponseModel = try await network.fetch(from: ProfileAPI.deleteProfile)
    }
}
