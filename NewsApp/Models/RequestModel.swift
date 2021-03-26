//
//  RequestModel.swift
//  NewsApp
//
//  Created by MAKAN on 27.03.2021.
//

import UIKit

enum RequestHTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

class RequestModel: NSObject {
    
    // MARK: Properties
    
    var path: String {
        return ""
    }
    var parameters: [String: Any?] {
        return [:]
    }
    var headers: [String: String] {
        return [:]
    }
    var method: RequestHTTPMethod {
        return .get
    }
    var body: [String: Any?] {
        return [:]
    }
    
    // (request, response)
    var isLoggingEnabled: (Bool, Bool) {
        return (true, true)
    }
}

// MARK: - Public Functions
extension RequestModel {
    
    func urlRequest() -> URLRequest {
        var endpoint: String = path
        
        for parameter in parameters {
            if let value = parameter.value as? String {
                endpoint.append("&\(parameter.key)=\(value)")
            }
        }
        
        endpoint = endpoint.replacingOccurrences(of: " ", with: "%20")
        
        var request: URLRequest = URLRequest(url: URL(string: endpoint)!)
        
        request.httpMethod = method.rawValue
        
        for header in headers {
            request.addValue(header.value, forHTTPHeaderField: header.key)
        }
        
        if method == RequestHTTPMethod.post {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: body, options: JSONSerialization.WritingOptions.prettyPrinted)
            } catch let error {
                print(error)
            }
        }
        
        return request
    }
}
