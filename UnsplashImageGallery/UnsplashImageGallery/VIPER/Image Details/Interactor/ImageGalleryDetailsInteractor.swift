//
//  ImageGalleryDetailsInteractor.swift
//  UnsplashImageGallery
//
//  Created by Rickzon Hagos on 11/27/18.
//  Copyright © 2018 RickzonHagos. All rights reserved.
//

import UIKit
import SDWebImage
import UIColor_Hex_Swift
import Photos
class ImageGalleryDetailsInteractor: NSObject {
    var page : Int = 1
    var imageDetails : Image!
    weak var callBackHandler : ImageGalleryDetailsCallBackProtocol!
}

extension ImageGalleryDetailsInteractor : ImageGalleryDetailsInteractorProtocol {
    func doRenderBGColor(){
        guard let imageDetails = imageDetails else {
            return
        }
        if let bgColor = imageDetails.color  {
            let backgroundColor = UIColor(bgColor)
            self.callBackHandler.doRenderBGColor(backgroundColor)
        }
    }
    func doDownloadImage(){
        guard let imageDetails = imageDetails else {
            return
        }
        
        if let imageURLInfo = imageDetails.imageURL?.full,
            let url = URL(string: imageURLInfo)
        {
            SDWebImageManager.shared().imageDownloader?.downloadImage(with: url, options: .highPriority, progress: nil, completed: {
                [weak weakSelf = self](image, data, error, success) in
                guard let weakSelf = weakSelf else {
                    return
                }
                guard let image = image else {
                    return
                }
                PHPhotoLibrary.shared().performChanges({
                    PHAssetChangeRequest.creationRequestForAsset(from: image)
                }, completionHandler: {
                    [weak weakSelf = self](success, error) in
                    guard let weakSelf = weakSelf else {
                        return
                    }
                    if success {
                        weakSelf.callBackHandler.doShowImageDownloadSuccess("Image successfully downloaded!")
                        return
                    }
                    else if let error = error {
                        weakSelf.callBackHandler.doShowImageDownloadFailed(error.localizedDescription)
                    }
                    else {
                        weakSelf.callBackHandler.doShowImageDownloadSuccess("Failed to save photo")
                    }
                })
            })
        }
    }
    func doShowDetails(){
        guard let imageDetails = imageDetails else {
            return
        }
        if let name = imageDetails.name {
            self.callBackHandler.doShowUserName(name)
        }
        
        self.callBackHandler.doShowImageDimension(imageDetails.imageDimension)
        self.callBackHandler.doShowNumberOfViews(imageDetails.numberOfViews)
        self.callBackHandler.doShowNumberOfDownloads(imageDetails.numberOfDownloads)
        self.callBackHandler.doShowNumberOfLikes(imageDetails.numberOfLikes)
        
        if let desc = imageDetails.desc {
            self.callBackHandler.doShowImageDescription(desc)
        }
        
        self.callBackHandler.doShowUploadedOn(imageDetails.uploadedOn)
        
        if let imageURLInfo = imageDetails.imageURL?.regular,
            let url = URL(string: imageURLInfo)
            {
                SDWebImageManager.shared().imageDownloader?.downloadImage(with: url, options: .highPriority, progress: nil, completed: {
                    [weak weakSelf = self](image, data, error, success) in
                    guard let weakSelf = weakSelf else {
                        return
                    }
                    if let image = image {
                        weakSelf.callBackHandler.doShowImageBanner(image)
                    }else {
                        weakSelf.callBackHandler.doShowImageBanner(UIImage(named: "PLACEHOLDER")!)
                    }
                })
        }
        
    }
}
