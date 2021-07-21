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
    var news: Articles?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonSeeFullArticle.layer.cornerRadius = 8
        configure(with: news)
    }
    
    func configure(with item: Articles?) {
        self.labelContent.text = item?.content
        self.labelDate.text = "\(item?.publishedAt?.dropLast(10) ?? "")"
        self.labelSource.text = "\(item?.author ?? ""),  \(item?.source?.name ?? "")"
        self.labelTitle.text = item?.title
        let imageURL = URL(string: item?.urlToImage ?? "")
        imageCover.kf.setImage(with: imageURL)
    }
    

    @IBAction func onSeeFullArticle(_ sender: Any) {
        if let articleURL = URL(string: news?.url ?? "") {
            UIApplication.shared.open(articleURL)
        }
    }
    
}
