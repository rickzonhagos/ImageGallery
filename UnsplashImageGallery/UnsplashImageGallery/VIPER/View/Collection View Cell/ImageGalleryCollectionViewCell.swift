//
//  ImageGalleryCollectionViewCell.swift
//  UnsplashImageGallery
//
//  Created by Rickzon Hagos on 27/11/2018.
//  Copyright © 2018 RickzonHagos. All rights reserved.
//

import UIKit

class ImageGalleryCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var galleryImageView : UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.galleryImageView.image = nil
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
