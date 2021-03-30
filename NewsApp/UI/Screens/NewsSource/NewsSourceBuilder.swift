//
//  NewsSourceBuilder.swift
//  NewsApp
//
//  Created by MAKAN on 28.03.2021.
//

import UIKit

final class NewsSourceBuilder {
    static func build() -> NewsSourceViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "NewsSourceVC") as! NewsSourceViewController
        return vc
    }
}
