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

    private func fetchData<T: Decodable>(urlString: String, success: @escaping (T) -> Void, failure: @escaping (Error) -> Void) {
        guard let url = URL(string: urlString) else {
            failure(NSError(domain: "Invalid URL", code: 400, userInfo: nil))
            return
        }

        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            if let error = error {
                print("Failed to get data...", error.localizedDescription)
                failure(error)
                return
            }
            guard let data = data else {
                failure(NSError(domain: "No Data", code: 500, userInfo: nil))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    success(decodedData)
                }
            } catch let error {
                print("Failed to decode data", error.localizedDescription)
                failure(error)
            }
        }.resume()
    }

    func getUserList(success: @escaping ([UserListModel]) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/users"
        fetchData(urlString: url, success: success, failure: failure)
    }

    func getUserDetail(id: Int, success: @escaping (UserListModel) -> Void, failure: @escaping (Error) -> Void) {
        let url = "https://jsonplaceholder.typicode.com/users/\(id)"
        fetchData(urlString: url, success: success, failure: failure)
    }
}
