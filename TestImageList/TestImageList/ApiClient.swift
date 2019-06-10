//
//  ApiClient.swift
//  TestImageList
//
//  Created by Trainee on 6/10/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit
import Alamofire.Swift
import AlamofireImage
class ApiClient {
    static var CurrentData: DataModel?
    static public func getData(_ url : URL?, completion: @escaping SearchComplete ) {
        
        if let url = url {
            
            Alamofire.request(url).responseData { (response) in
                if let data = parse(data: response.result.value)  {
                    CurrentData = data
                    completion(true)
                }
                
            }
            
            //            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            //                var success = false
            //                if let httpResponce = response as? HTTPURLResponse{
            //                    print(httpResponce.statusCode)
            //                }
            //
            //                if error != nil {
            //                    print(error)
            //                } else {
            //                    if let usableData = data {
            //                        print(usableData)
            //                        CurrentData = parse(data: usableData)
            //                        if CurrentData != nil {
            //                            success = true
            //                        }
            //                        completion(success)
            //                    }
            //                }
            //            }
            //            task.resume()
            //        }
            
        }
     }
    
    
       static func parse(data: Data?) -> DataModel? {
            guard let data = data else {  return nil }
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(DataModel.self, from: data)
                return result
            }
            catch {
                print("JSON Error: \(error)")
                return nil
            }
        }
    
    static func downloadImage(from url: URL) -> UIImage? {
        /*print("Download Started")
         getData(url) { data, response, error in
         guard let data = data, error == nil else { return }
         print(response?.suggestedFilename ?? url.lastPathComponent)
         print("Download Finished")
         DispatchQueue.main.async() {
         self.imageView.image = UIImage(data: data)
         }
         }*/
        
        
        
        let data = try? Data(contentsOf: url)
        guard let imageData = data else {
            return nil
        }
        return UIImage(data: imageData)
        
        
     
        
       
    }
}

extension UIImageView {
    func loadImage(url: URL?) {
        guard let url = url else { return }
        Alamofire.request(url).responseImage { (response) in
            if let image = response.result.value {
                self.image = image
            }
        }
    }
}
