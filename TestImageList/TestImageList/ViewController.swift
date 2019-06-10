//
//  ViewController.swift
//  TestImageList
//
//  Created by Trainee on 6/7/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit
typealias SearchComplete = (DataModel) -> Void

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    var loadMoreStatus = true
    let limit = 10
    var offset = 0
    var hasMore = false
    let tableView = UITableView()
    var allUsersData:[User] = []
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
        ApiClient.getData(self.urlString) { (success) in
            self.allUsersData = success.data.users
            self.hasMore = success.data.has_more
            self.reloadTableView()
            self.loadMoreStatus = false
        }
        
    }
   
    func reloadTableView() {
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UserCell
        let user = allUsersData[indexPath.row]
        cell.userImage.loadImage(url: URL(string: user.image))
        cell.userName.text = user.name
        cell.imagesView.subviews.forEach({ $0.removeFromSuperview() })
        for (i, _) in user.items.enumerated() {
            let imageView = UIImageView()
            imageView.loadImage(url: URL(string: user.items[i]))
            cell.imagesView.addSubview(imageView)
        }
        cell.configureImages()
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
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 0 {
            loadMore()
        }
    }
    
    func loadMore() {
        if !loadMoreStatus && hasMore {
            offset = offset + limit
            loadMoreBegin()
        }
    }
    
    func loadMoreBegin() {
        loadMoreStatus = true
        DispatchQueue.main.async {
            ApiClient.getData(self.urlString) { (success) in
                for (_,elem) in (success.data.users.enumerated()) {
                    self.allUsersData.append(elem)
                }
                self.loadMoreStatus = false
                self.reloadTableView()
            }
        }
    }
   
    
    

}

