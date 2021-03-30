//
//  SearchNewsListViewModel.swift
//  NewsApp
//
//  Created by MAKAN on 28.03.2021.
//

import Foundation

class SearchNewsListViewModel {
    
    var newsList : [Article] = []
    
    func newsList(title: String, page: Int, completion: @escaping(() -> Void)) {
        Services.newsList(title: title, page: page) { (result) in
            switch result {
            case .success(let response):
                if response.articles != nil {
                    self.newsList = response.articles!
                    completion()
                } else {
                    self.newsList = []
                    completion()
                }
            case.failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
