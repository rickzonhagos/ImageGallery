//
//  ImageGalleryPresenter.swift
//  UnsplashImageGallery
//
//  Created by Rickzon Hagos on 26/11/2018.
//  Copyright © 2018 RickzonHagos. All rights reserved.
//

import UIKit

class ImageGalleryPresenter: NSObject {
    public private(set) weak var view : ImageGalleryViewProtocol!
    public private(set) var interactor : ImageGalleryInteractorProtocol!
    public private(set) var router : ImageGalleryRouter!
    
    override init(){
        super.init()
    }
    convenience init(viewProtocol view : ImageGalleryViewProtocol!,
        interactor : ImageGalleryInteractorProtocol!,
        router : ImageGalleryRouter!){
        self.init()
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}
extension ImageGalleryPresenter : ImageGalleryPresenterProtocol {
    
    func doNavigateToDetailsPage(_ image : Image){
        self.router.doNavigateToDetailsPage(image)
    }
    func doGetImage() {
        self.interactor.doGetImage()
    }
    
}
extension ImageGalleryPresenter : ImageGalleryCallbackProtocol {
    func doShowImageList(_ list: [Image]) {
        self.view.doShowImageList(list)
    }
}
