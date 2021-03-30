//
//  Services.swift
//  NewsApp
//
//  Created by MAKAN on 27.03.2021.
//

import Foundation
import Alamofire

public class Services {
    
    class func newsList(title: String, page: Int, completion: @escaping(Swift.Result<NewsListResponseModel,AFError>) -> Void) {
        ServiceManager.shared.sendRequest(request: NewsListRequestModel(title: title, page: page)) { (result) in
            completion(result)
        }
    }
}
