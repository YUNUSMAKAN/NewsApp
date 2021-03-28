//
//  FavoritesNewsListViewController.swift
//  NewsApp
//
//  Created by MAKAN on 28.03.2021.
//

import UIKit

class FavoritesNewsListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableViewDelegate()
        self.tabBarController?.title = "Favorite"
    }

}

//MARK:- UITableViewDelegate & UITableViewDataSource!
extension FavoritesNewsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          //let searchFilms = viewModel.homeSearchFilmsList[indexPath.row]
          let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesNewsListCell", for: indexPath) as! FavoritesNewsListTableViewCell
          //cell.filmNameLabel.text = "Name: \(searchFilms.title ?? "")"
          //cell.filmYearLabel.text = "Year: \(searchFilms.year ?? "")"
          return cell
      }
      
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          //return viewModel.homeSearchFilmsList.count
        return 10
      }
      
      func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          //guard let chooseFilmId = viewModel.homeSearchFilmsList[indexPath.row].imdbID else { return }
          //showMovieDetail(movieId: chooseFilmId)
      }
}
