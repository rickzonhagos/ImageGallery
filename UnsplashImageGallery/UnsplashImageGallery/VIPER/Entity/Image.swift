//
//  Image.swift
//  UnsplashImageGallery
//
//  Created by Rickzon Hagos on 26/11/2018.
//  Copyright © 2018 RickzonHagos. All rights reserved.
//

import UIKit

class Image: NSObject {
    var created_at : String?
    var name : String?
    var likes : NSNumber = NSNumber(value: 0)
    var desc : String?
    var width : NSNumber = NSNumber(value: 0)
    var height : NSNumber = NSNumber(value: 0)
    var color : String?
    
    struct ImageURL  {
        let thumb : String
        let full : String
        let regular : String
        let small : String
        let raw : String
    }
    var imageURL : ImageURL?
    
    override init() {
        super.init()
    }
    var imageDimension : String! {
        get {
            return "\(width) x \(height)"
        }
    }
    var numberOfLikes : String {
        get {
            return "\(likes)"
        }
    }
    var numberOfDownloads : String {
        get {
            return "\(likes)"
        }
    }
    var numberOfViews: String {
        get {
            return "\(likes)"
        }
    }
    var uploadedOn : String {
        get {
            guard let created_at = created_at else {
                return ""
            }
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
            let date = dateFormatter.date(from: created_at)
            guard let convertedDate = date else{
                return ""
            }
            dateFormatter.dateFormat = "MMM d, yyyy HH:mm"
            let stringDate = dateFormatter.string(from:convertedDate)
            return "\(stringDate)"
        }
    }
    convenience init(dictionaryData dictionary : NSDictionary!) {
        self.init()
        
        if let created_at = dictionary.value(forKey: "created_at") as? String {
            self.created_at = created_at
        }
        if let user = dictionary.object(forKey: "user") as? NSDictionary {
            if let name = user.value(forKey: "name") as? String {
                self.name = name
            }
        }
        if let likes = dictionary.object(forKey: "likes") as? NSNumber {
            self.likes = likes
        }
        if let desc = dictionary.value(forKey: "description") as? String {
            self.desc = desc
        }
        if let width = dictionary.object(forKey: "width") as? NSNumber {
            self.width = width
        }
        if let height = dictionary.object(forKey: "height") as? NSNumber {
            self.height = height
        }
        if let color = dictionary.value(forKey: "color") as? String {
            self.color = color
        }
        if let imageURL = dictionary.object(forKey: "urls") as? NSDictionary ,
            let thumb = imageURL.value(forKey: "thumb") as? String,
            let full = imageURL.value(forKey: "full") as? String,
            let regular = imageURL.value(forKey: "regular") as? String,
            let raw = imageURL.value(forKey: "raw") as? String,
            let small = imageURL.value(forKey: "small") as? String{
            self.imageURL = ImageURL(thumb: thumb, full: full, regular: regular, small: small, raw: raw)
        }
    }
}
