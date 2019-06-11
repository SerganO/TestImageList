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
    /*static public func getData(_ url : URL?, completion: @escaping SearchComplete ) {
        
        if let url = url {
            
            Alamofire.request(url).responseData { (response) in
                if let data = parse(data: response.result.value)  {
                    completion(data)
                }
                
            }
        }
     }*/
    
    static public func getData(_ url : URL?, completion: @escaping SearchComplete) {
        if let url = url {
            
            Alamofire.request(url).validate(statusCode: 200...300).responseData { (response) in
                switch response.result {
                    
                case .success(_):
                    completion(response.result.value as Any)
                case .failure(_):
                    completion(response.result.value as Any)
                }
                
                
                
            }
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
    
}


