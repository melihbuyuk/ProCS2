//
//  ListCollCell.swift
//  ProCS2
//
//  Created by Serhat Akkurt on 17.02.2020.
//  Copyright © 2020 Serhat Akkurt. All rights reserved.
//

import UIKit
import Kingfisher

class ListCollCell: UICollectionViewCell {

    @IBOutlet weak var imgTV: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var imgLike: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCellData(_ m:TVSeriesListData) {
        lblName.text = m.title
        lblRating.text = String(m.rating)
        imgTV.kf.setImage(with: URL(string: m.imagePath))
        imgTV.heroID = String(m.id)
        imgLike.isHidden = !DBManager.shared.isLiked(m.id)
    }
}
