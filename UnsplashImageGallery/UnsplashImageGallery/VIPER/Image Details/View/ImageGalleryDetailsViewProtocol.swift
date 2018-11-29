//
//  ImageGalleryDetailsViewProtocol.swift
//  UnsplashImageGallery
//
//  Created by Rickzon Hagos on 11/27/18.
//  Copyright © 2018 RickzonHagos. All rights reserved.
//

import UIKit

protocol ImageGalleryDetailsViewProtocol: class {
    func doShowUserName(_ info : String)
    func doShowImageDimension(_ info : String)
    func doShowNumberOfViews(_ info : String)
    func doShowNumberOfDownloads(_ info : String)
    func doShowNumberOfLikes(_ info : String)
    func doShowImageDescription(_ info : String)
    func doShowUploadedOn( _ info : String)
    func doShowImageBanner(_ image : UIImage)
    func doShowLoadingIndicator()
    func doShideLoadingIndicator()
    
    func doRenderBGColor(_ color : UIColor)
    func doShowImageDownloadSuccess(_ message: String)
    func doShowImageDownloadFailed(_ message: String)
}
