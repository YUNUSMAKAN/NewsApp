//
//  NewsListRequestModel.swift
//  NewsApp
//
//  Created by MAKAN on 28.03.2021.
//

import Foundation

class NewsListRequestModel: RequestModel {
    
    private let title: String
    private let page: Int
    
    init(title: String,page: Int){
        self.title = title
        self.page = page
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        fatalError("init(from:) has not been implemented")
    }
    
    override var path: String {
        return "\(Constant.ServicesConstant.baseUrl)?apikey=\(Constant.ServicesConstant.apiKey)"
    }
    
    override var parameters: [String : Any?] {
        return [
            "q" : self.title,
            "page" : self.page
        ]
    }
}
