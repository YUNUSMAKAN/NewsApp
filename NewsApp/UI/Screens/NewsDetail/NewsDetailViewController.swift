//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by MAKAN on 28.03.2021.
//

import UIKit
import CoreData
import Kingfisher

class NewsDetailViewController: UIViewController {
    
    //MARK: Properties!
    var viewModel = NewsDetailViewModel()
    var chosenNews = ""
    var chosenNewsId : UUID?
    var url: String = ""

    //MARK: Outlets!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var newsSourceButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLayer()
        setNavigationTitle()
        viewModel.delegate = self
        if chosenNews != "" {
            self.favoriteButton.isEnabled = false
            getData()
        }
    }
    
    //MARK:Action Buttons!
    @IBAction func newsSourceButton(_ sender: Any) {
        if chosenNews != "" {
            let vc = NewsSourceBuilder.build()
            vc.url = url
            self.show(vc, sender: nil)
            
        } else {
            let vc = NewsSourceBuilder.build()
            vc.url = viewModel.data?.url ?? ""
            self.show(vc, sender: nil)
        }
    }
    
    @IBAction func shareLinkButton(_ sender: Any) {
        if chosenNews != "" {
            share(message: "News Link", link: url)
        } else {
            share(message: "News Link" , link: viewModel.data?.url ?? "")
        }
    }
    
    @IBAction func addFavoriteButton(_ sender: Any) {
        url = viewModel.data?.url ?? ""
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let favoriteNews = NSEntityDescription.insertNewObject(forEntityName: "FavoritesNews", into: context)
        favoriteNews.setValue(titleLabel.text, forKey: "title")
        favoriteNews.setValue(authorLabel.text, forKey: "author")
        favoriteNews.setValue(contentLabel.text, forKey: "content")
        favoriteNews.setValue(dateLabel.text, forKey: "date")
        favoriteNews.setValue(descriptionLabel.text, forKey: "definition")
        favoriteNews.setValue(url, forKey: "url")
        favoriteNews.setValue(UUID(), forKey: "id")
        let data = imageView.image?.jpegData(compressionQuality: 0.5)
        favoriteNews.setValue(data, forKey: "image")
        do {
            try context.save()
            print("success")
        } catch {
            print("error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("addedNewFavorite"), object: nil)
        self.showAlert(title: "INFO", description: "Added to Favorites!")
    }
}

extension NewsDetailViewController {
    
    func getData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoritesNews")
        let idString = chosenNewsId?.uuidString
        fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let title = result.value(forKey: "title") as? String {
                        titleLabel.text = title
                    }
                    if let author = result.value(forKey: "author") as? String {
                        authorLabel.text = author
                    }
                    if let definition = result.value(forKey: "definition") as? String {
                        descriptionLabel.text = definition
                    }
                    if let content = result.value(forKey: "content") as? String {
                        contentLabel.text = content
                    }
                    if let url = result.value(forKey: "url") as? String {
                        self.url = url
                    }
                    if let date = result.value(forKey: "date") as? String {
                        dateLabel.text = date
                    }
                    if let imageData = result.value(forKey: "image") as? Data {
                        let image = UIImage(data: imageData)
                        imageView.image = image
                    }
                }
            }
        }catch {
            print("error")
        }
    }
    
    private func setNavigationTitle() {
        self.navigationItem.title = "News Detail"
    }
    
    private func setLayer() {
        newsSourceButton.layer.cornerRadius = 24
        imageView.layer.cornerRadius = 24
        shadowView.dropShadow()
    }
    
    private func share(message: String, link: String) {
        if let link = NSURL(string: link) {
            let objectsToShare = [message,link] as [Any]
            let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
            self.present(activityVC, animated: true, completion: nil)
        }
    }
    
    private func showAlert(title: String, description: String) {
        DispatchQueue.main.async {
            let alertView = UIAlertController(title: title, message: description, preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            }))
            self.present(alertView, animated: true, completion: nil)
        }
    }
}

//MARK: ArticleDetail!
extension NewsDetailViewController: ArticleDetail {
    
    func refresh(title: String, image: String, content: String, author: String, description: String, date: String) {
        let url = URL(string: image)
        imageView.kf.setImage(with: url)
        titleLabel.text = title
        authorLabel.text = author
        descriptionLabel.text = description
        contentLabel.text = content
        dateLabel.text = date
    }
}
