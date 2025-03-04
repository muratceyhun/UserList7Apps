//
//  UserDetailViewController.swift
//  UserList7Apps
//
//  Created by Murat Ceyhun Korpeoglu on 4.03.2025.
//

import UIKit

class UserDetailViewController: UIViewController, LoadingDisplayable {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var userInfoView: UIView!
    @IBOutlet private weak var phoneNumberLabel: UILabel!
    @IBOutlet private weak var websiteLabel: UILabel!
    @IBOutlet private weak var companyNameLabel: UILabel!

    private let viewModel = UserDetailViewModel()
    private let id: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        userInfoView.layer.borderWidth = 1
        userInfoView.layer.borderColor = UIColor.black.cgColor
        userInfoView.layer.cornerRadius = 8
        self.view.backgroundColor = .softWhiteColor
        getUserDetail { [weak self] in
            DispatchQueue.main.async {
                self?.hideLoading()
                self?.configure()
            }
        }
    }

    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.id = nil
        super.init(coder: coder)
    }

    private func setNavigation() {
        self.navigationItem.title = "User Detail"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func getUserDetail(completion: @escaping completionBlock) {
        guard let id else { return }
        showLoading()
        viewModel.getUserDetail(id: id) { [weak self] in
            guard let self else { return }
            completion()
        } completionFailure: { [weak self] in
            guard let self else { return }
            print("Failed to get data")
        }
    }

    func configure() {
        if let userDetail = viewModel.userDetailModel {
            nameLabel.text = userDetail.name ?? ""
            phoneNumberLabel.text = userDetail.phone ?? ""
            websiteLabel.text = userDetail.website ?? ""
            companyNameLabel.text = userDetail.company?.name ?? ""
        }
    }
}
