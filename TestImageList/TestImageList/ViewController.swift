//
//  ViewController.swift
//  TestImageList
//
//  Created by Trainee on 6/7/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import UIKit
typealias SearchComplete = (Any) -> Void

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    let limit = 10
    var offset = 0
    
    var hasMore = false
    var loadMoreStatus = true
    
    let cellIdentifier = "userInfo"
    let tableView = UITableView()
    
    var allUsersData:[User] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
                make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading)
                make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
                make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing)
            } else {
                make.top.equalTo(topLayoutGuide.snp.bottom)
                make.leading.equalToSuperview()
                make.bottom.equalTo(bottomLayoutGuide.snp.top)
                make.trailing.equalToSuperview()
            }
        }
        configureTableView()
        loadMoreBegin()
        
    }
    
   
    func configureTableView() {
        tableView.register(UserCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.contentMode = .scaleAspectFill
        tableView.estimatedRowHeight = 300
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
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
        cell.configureCell()
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset
        
        if deltaOffset <= 0 {
            loadMore()
        }
    }
    
    
    // MARK: - Load Data
    
    func loadMore() {
        if !loadMoreStatus && hasMore {
            offset = offset + limit
            loadMoreBegin()
        }
    }
    
    func loadMoreBegin() {
        loadMoreStatus = true
        ApiClient.getData(URLManager.getURL(offset, limit: limit)) { (result) in
            
            if let error = result as? Error {
                let alert = UIAlertController(title: "Alert", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                self.loadMoreStatus = false
                return
            }
            
            if let dataModel = ApiClient.parse(data: result as? Data) {
                for (_,elem) in (dataModel.data.users.enumerated()) {
                    self.allUsersData.append(elem)
                }
                self.hasMore = dataModel.data.has_more
                
                self.reloadTableView()
            }
            self.loadMoreStatus = false
        }
    }
    
    
}
   
    
    



