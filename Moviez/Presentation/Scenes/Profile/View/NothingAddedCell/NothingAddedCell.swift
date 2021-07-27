//
//  NothingAddedCell.swift
//  Moviez
//
//  Created by MacBook  on 27.07.21.
//

import UIKit

class NothingAddedCell: UICollectionViewCell {

    @IBOutlet weak var labelNothingAdded: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureEmptyWatchlist() {
        self.labelNothingAdded.text = "Your watchlist is empty. Add movies and Tv shows and keep track of what you want to watch."
    }
    
    func configureEmptyFavorites() {
        self.labelNothingAdded.text = "Your favorites list is empty. Mark movies and Tv shows as favorite and get personalized recommendations."
    }

}
