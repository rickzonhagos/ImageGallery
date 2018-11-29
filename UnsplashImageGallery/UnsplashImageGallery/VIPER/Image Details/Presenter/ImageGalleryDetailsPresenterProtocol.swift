//
//  ImageGalleryDetailsPresenterProtocol.swift
//  UnsplashImageGallery
//
//  Created by Rickzon Hagos on 11/27/18.
//  Copyright © 2018 RickzonHagos. All rights reserved.
//

import UIKit

protocol ImageGalleryDetailsPresenterProtocol: class {
    func doShowDetails()
    func doRenderBGColor()
    func doDownloadImage()
    func doShowAlertController(_ message : String)
}
