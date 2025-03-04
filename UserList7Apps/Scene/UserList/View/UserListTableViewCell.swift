//
//  UserListTableViewCell.swift
//  UserList7Apps
//
//  Created by Murat Ceyhun Korpeoglu on 4.03.2025.
//

import UIKit

final class UserListTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .white
    }

    func configure(model: UserListModel) {
        nameLabel.text = model.name ?? ""
        emailLabel.text = model.email ?? ""
    }
}
