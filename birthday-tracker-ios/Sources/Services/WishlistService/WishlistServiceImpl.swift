//
//  WishlistServiceImpl.swift
//  birthday-tracker-ios
//
//  Created by Darvin on 18.03.2022.
//

import Foundation

class WishlistServiceImpl: WishlistService {
    func edit(employee _: Employee, completion _: () -> Void) {}

    func load(id: Int, completion: @escaping (Result<Wishlist, Error>) -> Void){
        let answer = NetworkService()
        answer.makeRequest(for: URL(string: "/api/present/get")!,
                              method: NetworkService.Method.get,
                              query: NetworkService.QueryType.json,
                              params: ["present_id": id],
                              success: { data in
            print(String(decoding: data!, as: UTF8.self))
            if let data = data, let wishlist = try? JSONDecoder().decode(Wishlist.self, from: data) {
                completion(.success(wishlist))
            }
        })
    }
}
