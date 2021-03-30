//
//  FavoritesNewsListViewController.swift
//  NewsApp
//
//  Created by MAKAN on 28.03.2021.
//

import UIKit
import CoreData

class FavoritesNewsListViewController: UIViewController {

    //MARK:Properties!
    var selectedNewsId : UUID?
    var imageArr = [Data]()
    var titleArr = [String]()
    var authorArr = [String]()
    var dateArr = [String]()
    var idArr = [UUID]()
    
    //MARK:Outlets!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableViewDelegate()
        setNavigationTitle()
        getData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "addedNewFavorite"), object: nil)
    }
}

extension FavoritesNewsListViewController {
    
    private func setNavigationTitle() {
        self.navigationItem.title = "FAVORITES"
    }
    
    @objc func getData() {
        titleArr.removeAll(keepingCapacity: false)
        imageArr.removeAll(keepingCapacity: false)
        authorArr.removeAll(keepingCapacity: false)
        dateArr.removeAll(keepingCapacity: false)
        idArr.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritesNews")
        fetchRequest.returnsObjectsAsFaults = false 
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let title = result.value(forKey: "title") as? String {
                        self.titleArr.append(title)
                    }
                    
                    if let image = result.value(forKey: "image") as? Data {
                        self.imageArr.append(image)
                    }
                    
                    if let author = result.value(forKey: "author") as? String {
                        self.authorArr.append(author)
                    }
                    
                    if let date = result.value(forKey: "date") as? String {
                        self.dateArr.append(date)
                    }
                    
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArr.append(id)
                    }
                    self.tableView.reloadData()
                }
            }
        }catch {
            print("error")
        }
    }
}

//MARK:- UITableViewDelegate & UITableViewDataSource!
extension FavoritesNewsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    private func setTableViewDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoritesNewsListCell", for: indexPath) as! FavoritesNewsListTableViewCell
        cell.newsImageView.layer.cornerRadius = 12
        cell.newsTitleLabel.text = titleArr[indexPath.row]
        cell.newsImageView.image = UIImage(data: imageArr[indexPath.row])
        cell.newsAuthorLabel.text = authorArr[indexPath.row]
        cell.newsDateLabel.text = dateArr[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NewsDetailBuilder.build()
        vc.chosenNews = "FavoriteNews"
        vc.chosenNewsId = idArr[indexPath.row]
        self.show(vc, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritesNews")
            let idString = idArr[indexPath.row].uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            do {
                let results = try context.fetch(fetchRequest)
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let id = result.value(forKey: "id") as? UUID {
                            if id == idArr[indexPath.row] {
                                context.delete(result)
                                titleArr.remove(at: indexPath.row)
                                authorArr.remove(at: indexPath.row)
                                dateArr.remove(at: indexPath.row)
                                imageArr.remove(at: indexPath.row)
                                idArr.remove(at: indexPath.row)
                                self.tableView.reloadData()
                                
                                do {
                                    try context.save()
                                }catch {
                                    print("error")
                                }
                                break
                            }
                        }
                    }
                }
            }catch {
                print("error")
            }
        }
    }
}
