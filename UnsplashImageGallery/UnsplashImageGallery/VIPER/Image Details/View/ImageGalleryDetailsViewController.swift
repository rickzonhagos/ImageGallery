//
//  ImageGalleryDetailsViewController.swift
//  UnsplashImageGallery
//
//  Created by Rickzon Hagos on 11/27/18.
//  Copyright © 2018 RickzonHagos. All rights reserved.
//

import UIKit


class ImageGalleryDetailsViewController: UIViewController {

    static let StoryBoardID : String = ImageGalleryDetailsViewController.self.description().description
    
    @IBOutlet weak var postedImageView: UIImageView!
    
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var imageDimensionLbl: UILabel!
    
    @IBOutlet weak var numberOfViewsLbl: UILabel!
    @IBOutlet weak var numberOfDownloadsLbl: UILabel!
    @IBOutlet weak var numberOfLikesLbl: UILabel!
    @IBOutlet weak var postedImageDescription: UITextView!
    @IBOutlet weak var uploadedOnLbl: UILabel!
    @IBOutlet weak var downloadBtn: UIButton!
    
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    
    var presenter : ImageGalleryDetailsPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.doRenderBGColor()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.presenter.doShowDetails()
    }
    @IBAction func doSaveImage(_ sender : Any) {
        self.presenter.doDownloadImage()
    }
}
extension ImageGalleryDetailsViewController  : ImageGalleryDetailsViewProtocol  {
    func doShowUserName(_ info : String){
        userNameLbl.text = info
    }
    func doShowImageDimension(_ info : String){
        imageDimensionLbl.text = info
    }
    func doRenderBGColor(_ color: UIColor) {
        self.view.backgroundColor = color
    }
    func doShowNumberOfViews(_ info : String){
        numberOfViewsLbl.text = info
    }
    func doShowNumberOfDownloads(_ info : String){
        numberOfDownloadsLbl.text = info
    }
    func doShowNumberOfLikes(_ info : String){
        numberOfLikesLbl.text = info
    }
    func doShowImageDescription(_ info : String){
        postedImageDescription.text = info
    }
    func doShowUploadedOn( _ info : String){
        uploadedOnLbl.text = info
    }
    func doShowImageBanner(_ image: UIImage) {
        postedImageView.image = image
    }
    func doShowLoadingIndicator(){
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    func doShideLoadingIndicator(){
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    func doShowImageDownloadSuccess(_ message: String){
        self.presenter.doShowAlertController(message)
    }
    func doShowImageDownloadFailed(_ message: String){
        self.presenter.doShowAlertController(message)
    }
}
