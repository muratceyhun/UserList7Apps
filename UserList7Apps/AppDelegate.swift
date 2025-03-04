//
//  AppDelegate.swift
//  UserList7Apps
//
//  Created by Murat Ceyhun Korpeoglu on 4.03.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)

        let userListViewController = UserListViewController()
        let navUserListViewController = BaseNavigationController(rootViewController: userListViewController)

        window?.rootViewController = navUserListViewController
        window?.makeKeyAndVisible()

        return true
    }
}
