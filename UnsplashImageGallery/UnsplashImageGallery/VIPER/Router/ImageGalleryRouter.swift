//
//  ImageGalleryRouter.swift
//  UnsplashImageGallery
//
//  Created by Rickzon Hagos on 26/11/2018.
//  Copyright © 2018 RickzonHagos. All rights reserved.
//

import UIKit

class ImageGalleryRouter: NSObject {
    var presentingView : UIViewController!
    
    func doNavigateToDetailsPage(_ image : Image) {
        let router = ImageGalleryDetailsRouter()
        router.doNavigateToDetailsPage(presentingView, imageData: image)
    }
}
