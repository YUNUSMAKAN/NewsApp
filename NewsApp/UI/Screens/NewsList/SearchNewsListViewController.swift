//
//  ViewController.swift
//  NewsApp
//
//  Created by MAKAN on 27.03.2021.
//

import UIKit
import CoreData
import Kingfisher


class SearchNewsListViewController: UIViewController {

    //MARK:Properties!
    var writeText: String = ""
    var viewModel = SearchNewsListViewModel()
    
    //MARK:Outlets!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegate()
        setSearchBar()
        setNavigationTitle()
       
        //Default value to news list!
        searchNews(title: "Fenerbahce", page: 1)
    }
}

extension SearchNewsListViewController {
    
    func searchNews(title: String, page: Int) {
        viewModel.newsList(title: title, page: page) { [weak self] in
            guard let self = self else {return}
            self.tableView.reloadData()
            if self.viewModel.newsList.count < 1 {
                self.showAlert(title: "ERROR!", description: "NO NEWS!")
            }
        }
    }
    
    private func setNavigationTitle() {
        self.navigationItem.title = "NEWS"
    }
    
    private func showAlert(title: String, description: String) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: title, message: description, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.searchBar.text = ""
            }))
            self.present(alertView, animated: true, completion: nil)
        }
    }
}

//MARK:- UITableViewDelegate & UITableViewDataSource!
extension SearchNewsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let searchNews = viewModel.newsList[indexPath.row]
        let url = URL(string: searchNews.urlToImage!)
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchNewsListCell", for: indexPath) as! SearchNewsListTableViewCell
        cell.newsTitleLabel.text = searchNews.title
        cell.newsImageView.kf.setImage(with: url)
        cell.newsImageView.layer.cornerRadius = 12
        cell.newsAuthorLabel.text = searchNews.author
        cell.newsDateLabel.text = searchNews.publishedAt
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsDetailBuilder.build()
        DispatchQueue.main.async {
            vc.viewModel.data = self.viewModel.newsList[indexPath.row]
        }
        self.show(vc, sender: nil)
    }
}

//MARK:UISearchBarDelegate!
extension SearchNewsListViewController: UISearchBarDelegate {
    
    private func setSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = " Search to news... "
        searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.writeText = searchText
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchText), object: nil)
        self.perform(#selector(self.searchText), with: nil, afterDelay: 0.5)
    }
    
    @objc private func searchText(text: String) {
        if self.writeText.count > 2 {
            searchNews(title: self.writeText, page: 1)
        }
    }
}
