//
//  NewsDetailViewModel.swift
//  NewsApp
//
//  Created by MAKAN on 28.03.2021.
//

import UIKit

protocol ArticleDetail: class {
    func refresh(title:String , image: String , content: String , author: String ,description : String, date: String)
}

class NewsDetailViewModel {
    weak var delegate: ArticleDetail?
    var data: Article? {
        didSet {
            delegate?.refresh(title: data?.title ?? "", image: data?.urlToImage ?? "", content: data?.content ?? "",author: data?.author ?? "", description: data?.articleDescription ?? "", date: data?.publishedAt ?? "")
        }
    }
}
