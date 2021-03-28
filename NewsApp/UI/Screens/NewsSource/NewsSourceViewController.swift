//
//  NewsSourceViewController.swift
//  NewsApp
//
//  Created by MAKAN on 28.03.2021.
//

import UIKit
import WebKit

class NewsSourceViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "Favorites"
    }
 
}
