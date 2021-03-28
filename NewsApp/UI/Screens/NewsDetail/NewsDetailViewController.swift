//
//  NewsDetailViewController.swift
//  NewsApp
//
//  Created by MAKAN on 28.03.2021.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var newsSourceButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayer()

    }

    //MARK:Action Buttons!
    @IBAction func newsSourceButton(_ sender: Any) {
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "NewsSourceVC") as! NewsSourceViewController
        //vc.modalPresentationStyle = .fullScreen
        self.show(vc, sender: nil)
    }
    @IBAction func shareLinkButton(_ sender: Any) {
    }
    @IBAction func addFavoriteButton(_ sender: Any) {
    }
}

extension NewsDetailViewController {
    private func setLayer() {
        newsSourceButton.layer.cornerRadius = 24
        shadowView.dropShadow()
    }
}
