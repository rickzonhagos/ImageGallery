//
//  ImageGalleryInteractor.swift
//  UnsplashImageGallery
//
//  Created by Rickzon Hagos on 26/11/2018.
//  Copyright © 2018 RickzonHagos. All rights reserved.
//

import UIKit
import Alamofire
class ImageGalleryInteractor: NSObject {
    
    weak var callBackProtocol : ImageGalleryCallbackProtocol!
    public private(set) var isRefreshing : Bool = false
    public private(set) var page : Int = 1
    struct Contants  {
        struct URL {
            static let IMAGE_GALLERY : String = "https://api.unsplash.com/photos/"
            static let AUTH : String = "https://unsplash.com/oauth/authorize"
            
        }
        
        static let AccessKey : String = "27ebf8c6ae5eea7b483b47ffe155cf476d5962036a708fc27b209df66fd2850b"
        static let RequestHeader : [String : String] = ["Accept-Version":"v1"]
        static let AuthorizationHeader : [String  : String] = ["Authorization":""]
        static let SecretKey : String = "103caa1820b6ff0b494cd074d1f1bc02ec2eb36f1df3c3b8cb8cdf0b56c7e02a"
        
    }
    
}
extension ImageGalleryInteractor : ImageGalleryInteractorProtocol {
   
    func doGetImage(){
        guard let url = URL(string: ImageGalleryInteractor.Contants.URL.IMAGE_GALLERY) else {
            return
        }
        
        if isRefreshing == true {
            return
        }
        
        isRefreshing = true
        
        let params = ["client_id":ImageGalleryInteractor.Contants.AccessKey,
                      "per_page":"10",
                      "page" : "\(page)",
                      "order_by":"popular"]
        Alamofire.request(url,
                          method: .get,
                          parameters: params)
            .validate()
            .responseJSON {
                [weak weakSelf = self] response in
                
                guard let weakSelf = weakSelf else {
                    return
                }
                
                guard response.result.isSuccess else {
                    return
                }
                
                guard let dictionaryArrayData = response.result.value as? [NSDictionary] else {
                        return
                }
                weakSelf.page += 1
                weakSelf.isRefreshing = false
                var imageList = [Image]()
                for dictionary in dictionaryArrayData {
                    let item = Image(dictionaryData: dictionary)
                    imageList.append(item)
                }
                
                weakSelf.callBackProtocol.doShowImageList(imageList)
        }
    }
}
