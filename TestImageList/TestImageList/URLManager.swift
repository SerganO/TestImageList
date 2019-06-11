//
//  URLManager.swift
//  TestImageList
//
//  Created by Trainee on 6/11/19.
//  Copyright © 2019 Trainee. All rights reserved.
//

import Foundation

class URLManager {
    static func getURL(_ offset: Int,limit:Int) -> URL {
        return URL(string: "http://sd2-hiring.herokuapp.com/api/users?offset=\(offset)&limit=\(limit)")!
    }
}
