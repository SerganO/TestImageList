//
//  DataModel.swift
//  TestImageList
//
//  Created by Trainee on 6/7/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import Foundation

class DataModel: Codable {
    var status = false
    var message: String?
    var data = usersData()
}

class usersData: Codable {
    var users = [user]()
    var has_more:Bool = false
}

class user: Codable {
    var name:String = ""
    var image:String = ""
    var items = [String]()
}

/*class item: Codable {
    let data = ""
}*/
