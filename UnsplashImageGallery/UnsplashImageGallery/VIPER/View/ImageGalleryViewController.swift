//
//  ImageGalleryViewController.swift
//  UnsplashImageGallery
//
//  Created by Rickzon Hagos on 26/11/2018.
//  Copyright © 2018 RickzonHagos. All rights reserved.
//

import UIKit
import SDWebImage

private let reuseIdentifier = "ImageCollectionViewCellIdentifier"
private let footerReuseIdentifier = "FooterCollectionViewCell"
private let headerReuseIdentifier = "HeaderCollectionViewCell"
class ImageGalleryViewController: UICollectionViewController {
    
    var presenter : ImageGalleryPresenterProtocol!
    var imageList : [Image]?
    
    fileprivate let itemsPerRow: CGFloat = 3
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let interactor = ImageGalleryInteractor()
        let router = ImageGalleryRouter()
        let presenter = ImageGalleryPresenter(viewProtocol: self, interactor: interactor, router: router)
        self.presenter = presenter
        interactor.callBackProtocol = presenter
        router.presentingView = self
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView.register(FooterCollectionViewCell.self, forCellWithReuseIdentifier: footerReuseIdentifier)
        self.collectionView.register(HeaderCollectionViewCell.self, forCellWithReuseIdentifier: headerReuseIdentifier)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.doGetImage()
    }
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let imageList = self.imageList else {
            return 0
        }
        return imageList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ImageGalleryCollectionViewCell
        
        if let imageList = self.imageList,
            let imageItem = imageList[indexPath.row] as? Image,
            let thumbNailSTRURL = imageItem.imageURL?.thumb,
            let url = URL(string: thumbNailSTRURL) {
            
            cell.galleryImageView.sd_setImage(with: url, placeholderImage: nil, options: .cacheMemoryOnly) {
                [weak weakSelf = self](image, error, cacheType, url) in
                cell.galleryImageView.image = image
            }
        }
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let imageList = self.imageList else {
            return
        }
        if indexPath.row == imageList.count - 1 {
            presenter.doGetImage()
        }
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reusableView : UICollectionReusableView?
        if kind == UICollectionView.elementKindSectionFooter {
            let footerView  = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerReuseIdentifier, for: indexPath) as! FooterCollectionViewCell
            footerView.activityIndicator.startAnimating()
            reusableView = footerView
        }else {
            reusableView  = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
        }
        return reusableView!
    }
    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        if let imageList = self.imageList,
            let imageItem = imageList[indexPath.row] as? Image {
            self.presenter.doNavigateToDetailsPage(imageItem)
        }
    }
    
    
}
extension ImageGalleryViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout
                collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  50
        let collectionViewSize = collectionView.frame.size.width - padding
   
        let width = collectionViewSize/2
        let height = collectionViewSize/2
        if let imageList = self.imageList,
            let imageItem = imageList[indexPath.row] as? Image
            {
                let actualheight = imageItem.height
                let actualwidth = imageItem.width
                let aspectRatio = Double(actualwidth.intValue) / Double(actualheight.intValue)
                let newHeight = Double(width) / aspectRatio
                let newWidth = newHeight * aspectRatio
                return CGSize(width: CGFloat(Float(newWidth)), height: CGFloat(Float(newHeight)))
        }
        
        return CGSize(width: width, height: height)
    }
}
extension ImageGalleryViewController : ImageGalleryViewProtocol {
    func doShowImageList(_ list: [Image]) {
        if self.imageList == nil {
            self.imageList = list
            self.collectionView.reloadData()
        }else {
            do {
                self.collectionView.performBatchUpdates({
                    let previousCount = self.imageList!.count - 1
                    self.imageList!.append(contentsOf: list)
                    
                    var indexPathArray : [IndexPath] = [IndexPath]()
                    
                    for i in stride(from: previousCount, to: previousCount + list.count, by: 1) {
                        indexPathArray.append(IndexPath(row: i, section: 0))
                    }
                    self.collectionView.insertItems(at: indexPathArray)
                }, completion : nil)
            }catch let e {
                print(e)
            }
            
        }
        
    }
}
