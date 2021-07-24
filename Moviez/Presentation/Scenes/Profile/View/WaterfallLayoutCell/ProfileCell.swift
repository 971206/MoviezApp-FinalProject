//
//  WaterfallLayoutCell.swift
//  Moviez
//
//  Created by MacBook  on 20.07.21.
//

import UIKit


protocol ProfileCellDelegate: AnyObject {
    func delete(cell: ProfileCell)
}

class ProfileCell: UICollectionViewCell {
    @IBOutlet weak var imagePoster: UIImageView!

    @IBOutlet weak var buttonDeleteView: UIButton!
    @IBOutlet weak var buttonDelete: UIButton!
    
    weak var delegate : ProfileCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imagePoster.layer.cornerRadius = 20
        imagePoster.layer.masksToBounds = true
        buttonDeleteView.layer.cornerRadius = 10
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imagePoster.image = nil
       
    }

    func configure(with item: FirebaseModel?) {
        let posterURL = URL(string:  BaseURL.imageBaseURL + "\(item?.imageURL ?? "")")
        imagePoster.kf.setImage(with: posterURL)
    }
    @IBAction func onRemove(_ sender: Any) {
        delegate?.delete(cell: self)
    }
}

