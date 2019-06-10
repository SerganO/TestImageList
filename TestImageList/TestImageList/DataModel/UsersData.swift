//
//  UserData.swift
//  TestImageList
//
//  Created by Trainee on 6/10/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import Foundation

class UsersData: Codable {
    var users = [User]()
    var has_more:Bool = false
}
