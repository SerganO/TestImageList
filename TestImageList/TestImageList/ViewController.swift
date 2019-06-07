//
//  ViewController.swift
//  TestImageList
//
//  Created by Trainee on 6/7/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let tableView = UITableView()
    var CurrentData: DataModel?
    let urlString = URL(string: "http://sd2-hiring.herokuapp.com/api/users?offset=10&limit=10")
    typealias SearchComplete = (Bool) -> Void
    let cellIdentifier = "userInfo"
    override func viewDidLoad() {
        super.viewDidLoad()
        getData(urlString) { (success) in
            
        }
        
        
    }
    
    
    public func getData(_ url : URL?, completion: @escaping SearchComplete ) {
        if let url = url {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                var success = false
                if let httpResponce = response as? HTTPURLResponse{
                    print(httpResponce.statusCode)
                }
                
                if error != nil {
                    print(error)
                } else {
                    if let usableData = data {
                        print(usableData)
                        self.CurrentData = self.parse(data: usableData)
                        if self.CurrentData != nil {
                            success = true
                        }
                        completion(success)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrentData?.data.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        return cell
    }
    
    
    func configureTableView() {
        //tableView.register(AmslerTestDefectTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 94
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    

}

