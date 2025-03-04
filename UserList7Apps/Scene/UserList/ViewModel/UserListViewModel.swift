//
//  UserListViewModel.swift
//  UserList7Apps
//
//  Created by Murat Ceyhun Korpeoglu on 4.03.2025.
//

import Foundation

typealias completionBlock = (() -> Void)

final class UserListViewModel {

    var userListModel: [UserListModel]?

    func getUserList(completionSuccess: @escaping completionBlock, completionFailure: @escaping completionBlock) {
        ServiceManager.shared.getUserList { userListModel in
            self.userListModel = userListModel
            completionSuccess()
        } failure: { error in
            completionFailure()
        }
    }

    func getTheNumberOfUserList() -> Int {
        userListModel?.count ?? .zero
    }
}
