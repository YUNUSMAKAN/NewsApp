//
//  FavoritesNewsListBuilder.swift
//  NewsApp
//
//  Created by MAKAN on 28.03.2021.
//

import UIKit

final class FavoritesNewsListBuilder {
    static func build() -> FavoritesNewsListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "FavoritesNewsListVC") as! FavoritesNewsListViewController
        return vc
    }
}
