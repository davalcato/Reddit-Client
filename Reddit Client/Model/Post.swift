//
//  Post.swift
//  Reddit Client
//
//  Created by Daval Cato on 3/18/18.
//  Copyright © 2018 Daval Cato. All rights reserved.
//

import Foundation

struct Post {
    
    var title: String?
    var author: String?
    var postDate: Int?
    var thumbnameImage: String?
    var sumofComments: Int?
    
    init?(jsonDict: [String: AnyObject]) {
        guard let thumbnameImage = jsonDict["thumbnail"] as? String,
            let title = jsonDict["title"] as? String,
            let author = jsonDict["author"] as? String,
            let sumofComments = jsonDict["num_comments"] as? Int,
            let postDate = jsonDict["created_utc"] as? Int  else {
                return nil
        }
        
        self.thumbnameImage = thumbnameImage
        self.title = title
        self.author = author
        self.sumofComments = sumofComments
        self.postDate = postDate
    }
}
