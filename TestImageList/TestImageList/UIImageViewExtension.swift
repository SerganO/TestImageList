//
//  UIImageViewExtension.swift
//  TestImageList
//
//  Created by Trainee on 6/10/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

extension UIImageView {
    
    
    func loadImage(url: URL?) {
        guard let url = url else { return }
        if let imageFromCache = CacheManager.imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = imageFromCache
            return
        }
        Alamofire.request(url).responseImage { (response) in
            if let image = response.result.value {
                CacheManager.imageCache.setObject(image, forKey: url as AnyObject)
                self.image = image
            }
        }
    }
    
    
    
    
}
