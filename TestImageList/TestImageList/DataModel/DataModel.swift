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
    var data = UsersData()
}
