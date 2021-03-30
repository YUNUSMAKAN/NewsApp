//
//  ServiceManager.swift
//  NewsApp
//
//  Created by MAKAN on 27.03.2021.
//

import Foundation
import Alamofire

class ServiceManager {
    public static let shared: ServiceManager = ServiceManager()
}

extension ServiceManager {
    
    func sendRequest<T:Codable>(request:RequestModel, completion: @escaping(Swift.Result<T, AFError>)-> Void) {
        AF.request(request.urlRequest()).validate().responseJSON { (response) in
            guard let data = response.data else {
                if let error = response.error {
                    completion(Result.failure(error))
                }
                return
            }
            guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                print("Decode Error")
                return
            }
            completion(Result.success(decodedResponse))
        }
    }
}
