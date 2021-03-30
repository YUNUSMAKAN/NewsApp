//
//  NewsListResponseModel.swift
//  NewsApp
//
//  Created by MAKAN on 28.03.2021.
//

import Foundation

struct NewsListResponseModel: Codable {
    let status: String?
    let totalResults: Int?
    let articles: [Article]?
    
    enum CodingKeys: String, CodingKey {
        case status = "status"
        case totalResults = "totalResults"
        case articles = "articles"
    }
}

//MARK:Article
struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String
    let articleDescription: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    enum CodingKeys: String, CodingKey {
        case source, author, title
        case articleDescription = "description"
        case url, urlToImage, publishedAt, content
    }
}

// MARK:Source
struct Source: Codable {
    let id: String?
    let name: String
}
