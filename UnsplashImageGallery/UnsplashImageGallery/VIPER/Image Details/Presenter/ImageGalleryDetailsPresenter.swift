//
//  ImageGalleryDetailsPresenter.swift
//  UnsplashImageGallery
//
//  Created by Rickzon Hagos on 11/27/18.
//  Copyright © 2018 RickzonHagos. All rights reserved.
//

import UIKit

class ImageGalleryDetailsPresenter: NSObject {
    public private(set) weak var view : ImageGalleryDetailsViewProtocol!
    public private(set) var router : ImageGalleryDetailsRouter!
    public private(set) var interactor : ImageGalleryDetailsInteractorProtocol!
    
    override init() {
        super.init()
    }
    convenience init(viewProtocol view : ImageGalleryDetailsViewProtocol!,
                     router : ImageGalleryDetailsRouter!,
                     interactor : ImageGalleryDetailsInteractorProtocol!) {
        self.init()
        self.view = view
        self.router = router
        self.interactor = interactor

    }
}
extension ImageGalleryDetailsPresenter : ImageGalleryDetailsPresenterProtocol {
    func doShowAlertController(_ message: String) {
        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        DispatchQueue.main.async {
            [weak weakSelf = self]() in
            guard let weakSelf = weakSelf else {
                return
            }
            (weakSelf.view as! ImageGalleryDetailsViewController).present(alert, animated: true, completion: nil)
        }
        
    }
    
    func doShowDetails(){
        self.interactor.doShowDetails()
        self.view.doShideLoadingIndicator()
    }
    func doRenderBGColor(){
        self.interactor.doRenderBGColor()
    }
    func doDownloadImage(){
        self.interactor.doDownloadImage()
    }
}
extension ImageGalleryDetailsPresenter : ImageGalleryDetailsCallBackProtocol {
    func doShowImageDownloadSuccess(_ message: String) {
        self.view.doShowImageDownloadSuccess(message)
    }
    func doShowImageDownloadFailed(_ message: String) {
        self.view.doShowImageDownloadFailed(message)
    }
    
    func doShowImageBanner(_ image: UIImage) {
        self.view.doShideLoadingIndicator()
        self.view.doShowImageBanner(image)
    }
    func doRenderBGColor(_ color : UIColor){
        self.view.doRenderBGColor(color)
    }
    func doShowUserName(_ info : String){
        self.view.doShowUserName(info)
    }
    func doShowImageDimension(_ info : String){
        self.view.doShowImageDimension(info)
    }
    func doShowNumberOfViews(_ info : String){
        self.view.doShowNumberOfViews(info)
    }
    func doShowNumberOfDownloads(_ info : String){
        self.view.doShowNumberOfDownloads(info)
    }
    func doShowNumberOfLikes(_ info : String){
        self.view.doShowNumberOfLikes(info)
    }
    func doShowImageDescription(_ info : String){
        self.view.doShowImageDescription(info)
    }
    func doShowUploadedOn( _ info : String){
        self.view.doShowUploadedOn(info)
    }
    
}
