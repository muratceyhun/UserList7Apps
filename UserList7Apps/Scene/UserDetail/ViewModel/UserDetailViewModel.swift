//
//  UserDetailViewModel.swift
//  UserList7Apps
//
//  Created by Murat Ceyhun Korpeoglu on 4.03.2025.
//

import Foundation

final class UserDetailViewModel {

    var userDetailModel: UserListModel?

    func getUserDetail(id: Int, completionSuccess: @escaping completionBlock, completionFailure: @escaping completionBlock) {
        ServiceManager.shared.getUserDetail(id: id) { [weak self] userDetail in
            guard let self else { return }
            self.userDetailModel = userDetail
            completionSuccess()
        } failure: { [weak self] error in
            guard let self else { return }
            completionFailure()
        }
    }
}
