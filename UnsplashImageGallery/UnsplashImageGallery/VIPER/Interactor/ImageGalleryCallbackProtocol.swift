//
//  ImageGalleryCallbackProtocol.swift
//  UnsplashImageGallery
//
//  Created by Rickzon Hagos on 27/11/2018.
//  Copyright © 2018 RickzonHagos. All rights reserved.
//

import UIKit

protocol ImageGalleryCallbackProtocol: class {
    func doShowImageList(_ list : [Image])
}
