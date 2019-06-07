//
//  ViewController.swift
//  TestImageList
//
//  Created by Trainee on 6/7/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var CurrentData: DataModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = URL(string: "http://sd2-hiring.herokuapp.com/api/users?offset=10&limit=10")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let httpResponce = response as? HTTPURLResponse{
                    print(httpResponce.statusCode)
                }
                
                if error != nil {
                    print(error)
                } else {
                    if let usableData = data {
                        print(usableData)
                        self.CurrentData = self.parse(data: usableData)
                    }
                }
            }
            task.resume()
        }
        
        
    }
    
    
    
    private func parse(data: Data) -> DataModel?
    {
        do
        {
            let decoder = JSONDecoder()
            let result = try decoder.decode(DataModel.self, from: data)
            return result
        }
        catch
        {
            print("JSON Error: \(error)")
            return nil
        }
    }
    
    
    

}

