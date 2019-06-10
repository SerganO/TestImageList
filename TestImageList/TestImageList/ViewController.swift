//
//  ViewController.swift
//  TestImageList
//
//  Created by Trainee on 6/7/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit
typealias SearchComplete = (Bool) -> Void

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    var loadMoreStatus = true
    let limit = 10
    var offset = 0
    let tableView = UITableView()
    var CurrentData: DataModel?
    var allUsersData: [user]?
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
                self.allUsersData = self.CurrentData?.data.users
                self.reloadTableView()
                self.loadMoreStatus = false
            }
        }
        
    }
   
    func reloadTableView() {
        tableView.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allUsersData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! UserCell
        
        //let cell = UserCell()
        
        if let data = allUsersData {
            let user = data[indexPath.row]
            cell.userImage.loadImage(url: URL(string: user.image))
            cell.userName.text = user.name
            cell.imagesView.subviews.forEach({ $0.removeFromSuperview() })
            for (i, _) in user.items.enumerated() {
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
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 0 {
            loadMore()
        }
    }
    
    func loadMore() {
        if !loadMoreStatus && CurrentData?.data.has_more ?? false {
            offset = offset + limit
            loadMoreBegin()
        }
    }
    
    func loadMoreBegin() {
        loadMoreStatus = true
        DispatchQueue.main.async {
            ApiClient.getData(self.urlString) { (success) in
                self.CurrentData = ApiClient.CurrentData
                for (_,elem) in (self.CurrentData?.data.users.enumerated())! {
                    self.allUsersData?.append(elem)
                }
                self.loadMoreStatus = false
                self.reloadTableView()
            }
        }
    }
   
    
    

}

