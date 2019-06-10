//
//  ViewController.swift
//  TestImageList
//
//  Created by Trainee on 6/7/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let limit = 10
    let offset = 0
    let tableView = UITableView()
    var CurrentData: DataModel?
    var urlString:URL {
        get {
            return URL(string: "http://sd2-hiring.herokuapp.com/api/users?offset=\(offset)&limit=\(limit)")!
        }
    }
    
    let cellIdentifier = "userInfo"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        configureTableView()
        DispatchQueue.main.async {
            ApiClient.getData(self.urlString) { (success) in
                self.CurrentData = ApiClient.CurrentData
                self.reloadTableView()
            }
        }
    }
   
    func reloadTableView() {
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CurrentData?.data.users.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UserCell
        
        if let data = CurrentData {
            let user = data.data.users[indexPath.row]
            cell.userImage.loadImage(url: URL(string: user.image))
            cell.userName.text = data.data.users[indexPath.row].name
            cell.imagesView.subviews.forEach({ $0.removeFromSuperview() }) // this gets things done
            //cell.imagesView.subviews.map({ $0.removeFromSuperview() }) // this returns modified array
            for (i, _) in user.items.enumerated() {
                //cell.imagesView.addSubview(UIImageView(image: UrlManager.downloadImage(from: URL(string: data.data.users[indexPath.row].items[i]))))
                let imageView = UIImageView()
                imageView.loadImage(url: URL(string: user.items[i]))
                cell.imagesView.addSubview(imageView)
        }
            cell.configureImages()
        }
        
        return cell
    }
    
    
    func configureTableView() {
        tableView.register(UserCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.contentMode = .scaleAspectFill
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
   
    
    

}

