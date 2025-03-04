//
//  ServiceManager.swift
//  UserList7Apps
//
//  Created by Murat Ceyhun Korpeoglu on 4.03.2025.
//

import Foundation

final class ServiceManager {

    static let shared = ServiceManager()
    
    private init() {}

    func getUserList(url: String, success: @escaping([UserListModel]) -> Void, failure: @escaping(Error) -> Void) {

        let urlString = url

        URLSession.shared.dataTask(with: URLRequest(url: .init(string: urlString)!)) { data, _, error in
            if let error = error {
                print("Failed to get data...", error.localizedDescription)
                failure(error)
            }
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([UserListModel].self, from: data)
                    decodedData.forEach{print($0.name ?? "")}
                    success(decodedData)
                } catch let error {
                    print("Failed to decode data", error.localizedDescription)
                    failure(error)
                }
            }
        }.resume()
    }
}
