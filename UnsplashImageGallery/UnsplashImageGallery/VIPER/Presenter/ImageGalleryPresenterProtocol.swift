//
//  ImageGalleryPresenterProtocol.swift
//  UnsplashImageGallery
//
//  Created by Rickzon Hagos on 26/11/2018.
//  Copyright © 2018 RickzonHagos. All rights reserved.
//

import UIKit

protocol ImageGalleryPresenterProtocol: class {
    func doNavigateToDetailsPage(_ image : Image)
    func doGetImage()
}
