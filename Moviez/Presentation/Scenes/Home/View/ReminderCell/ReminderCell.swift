//
//  EmptyWatchlist.swift
//  Moviez
//
//  Created by MacBook  on 26.07.21.
//

import UIKit

class ReminderCell: UITableViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    //MARK: - Configure
    func configure(with text: String, title: String, image: String) {
        self.labelText.text = text
        self.labelTitle.text = title
        imageIcon.image = UIImage(named: image)
    }
    
}
