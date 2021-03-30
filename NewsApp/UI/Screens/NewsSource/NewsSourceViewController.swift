//
//  NewsSourceViewController.swift
//  NewsApp
//
//  Created by MAKAN on 28.03.2021.
//

import UIKit
import WebKit

class NewsSourceViewController: UIViewController {

    //MARK:Properties!
    var url: String = ""
    
    //MARK:Outlets!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setWebViewDelegate()
        setNavigationTitle()
        webView.load(URLRequest(url: URL(string: url)!))
    }
}

//MARK:WKNavigationDelegate
extension NewsSourceViewController: WKNavigationDelegate {
   
    private func setWebViewDelegate() {
        webView.navigationDelegate = self
    }
}

extension NewsSourceViewController {
    
    private func setNavigationTitle() {
        self.navigationItem.title = "News Source"
    }
}
