//
//  ViewController.swift
//  NewsApp
//
//  Created by MAKAN on 27.03.2021.
//

import UIKit

class SearchNewsListViewController: UIViewController {

    //MARK:Properties
    var writeText: String = ""
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewDelegate()
        setSearchBar()
        self.navigationItem.title = "NEWS"
    }
}

extension SearchNewsListViewController {
    
    func searchFilms(title: String) {
//           viewModel.homeSearchFilmsList(title: title) { [weak self] in
//               guard let self = self else {return}
//               self.tableView.reloadData()
//               if self.viewModel.homeSearchFilmsList.count < 1 {
//                   self.showAlert(title: "ERROR!", description: "NO MOVIE!")
//               }
//           }
       }
    
    private func showMovieDetail(movieId: String) {
           
           let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "NewsDetailVC") as! NewsDetailViewController
          // vc.viewModel.selectedFilmId = movieId
           self.show(vc, sender: nil)
       }
}
//MARK:- UITableViewDelegate & UITableViewDataSource!
extension SearchNewsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          //let searchFilms = viewModel.homeSearchFilmsList[indexPath.row]
          let cell = tableView.dequeueReusableCell(withIdentifier: "SearchNewsListCell", for: indexPath) as! SearchNewsListTableViewCell
          //cell.filmNameLabel.text = "Name: \(searchFilms.title ?? "")"
          //cell.filmYearLabel.text = "Year: \(searchFilms.year ?? "")"
          return cell
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          //return viewModel.homeSearchFilmsList.count
        return 10
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "NewsDetailVC") as! NewsDetailViewController
        //vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: nil)
          //guard let chooseFilmId = viewModel.homeSearchFilmsList[indexPath.row].imdbID else { return }
          //showMovieDetail(movieId: chooseFilmId)
      }
}

//MARK:UISearchBarDelegate
extension SearchNewsListViewController: UISearchBarDelegate {
    
    private func setSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = " Search to movies... "
        searchBar.showsCancelButton = false
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.writeText = searchText
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchText), object: nil)
        self.perform(#selector(self.searchText), with: nil, afterDelay: 0.5)
    }
    
    @objc private func searchText(text: String) {
        if self.writeText.count > 2 {
            searchFilms(title: self.writeText)
        }
    }
}
