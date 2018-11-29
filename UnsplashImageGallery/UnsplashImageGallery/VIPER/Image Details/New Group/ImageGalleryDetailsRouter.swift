//
//  ImageGalleryDetailsRouter.swift
//  UnsplashImageGallery
//
//  Created by Rickzon Hagos on 11/27/18.
//  Copyright © 2018 RickzonHagos. All rights reserved.
//

import UIKit

class ImageGalleryDetailsRouter: NSObject {
    
    func doNavigateToDetailsPage(_ presentingView : UIViewController! , imageData : Image) {
        let interactor = ImageGalleryDetailsInteractor()
        interactor.imageDetails = imageData
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ImageGalleryDetailsViewController") as! ImageGalleryDetailsViewController
        let presenter = ImageGalleryDetailsPresenter(viewProtocol: viewController, router: self, interactor: interactor)
        
        viewController.presenter = presenter
        interactor.callBackHandler = presenter
        presentingView.navigationController?.pushViewController(viewController, animated: true)
    }
}
