//
//  NewsDetailViewController.swift
//  Moviez
//
//  Created by MacBook  on 21.07.21.
//

import UIKit

class NewsDetailViewController: BaseViewController {

    @IBOutlet weak var labelContent: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelSource: UILabel!
    @IBOutlet weak var imageCover: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var buttonSeeFullArticle: UIButton!
    var news: ArticleViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSeeFullArticle.layer.cornerRadius = 8
        configure(with: news)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = UIColor(named: "lightBackground")
        navigationController?.navigationBar.tintColor = UIColor(named: "textColor")
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    func configure(with item: ArticleViewModel?) {
        self.labelContent.text = item?.content
        self.labelDate.text = item?.publishDate
        self.labelSource.text = item?.fullSourceName
        self.labelTitle.text = item?.title
        imageCover.kf.setImage(with: item?.imageURL)
    }
    

    @IBAction func onSeeFullArticle(_ sender: Any) {
        if let sourceURL = news?.sourceURL {
            UIApplication.shared.open(sourceURL)
        }
    }
    
}
