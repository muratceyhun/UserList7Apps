//
//  UserListViewController.swift
//  UserList7Apps
//
//  Created by Murat Ceyhun Korpeoglu on 4.03.2025.
//

import UIKit

final class UserListViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    private let viewModel = UserListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigation()
        setupTableView()
        registerCell()
        getUserList()
    }
    
    private func registerCell() {
        tableView.register(UINib(nibName: "UserListTableViewCell", bundle: nil), forCellReuseIdentifier: "UserListTableViewCell")
    }

    private func getUserList() {
        viewModel.getUserList { [weak self] in
            guard let self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print("DATA SUCCESS")
        } completionFailure: { [weak self] in
            guard let self else { return }
            print("DATA FAILURE")
        }
    }

    private func setNavigation() {
        self.navigationItem.title = "User List"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupTableView() {
        tableView.backgroundColor = .brown
    }
}

extension UserListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getTheNumberOfUserList()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell") as? UserListTableViewCell else { return UITableViewCell() }
        if let model = viewModel.userListModel?[indexPath.row] {
            cell.configure(model: model)
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let model = viewModel.userListModel?[indexPath.row] {
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }

}
