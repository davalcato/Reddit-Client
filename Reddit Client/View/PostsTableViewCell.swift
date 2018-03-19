//
//  PostsTableViewCell.swift
//  Reddit Client
//
//  Created by Daval Cato on 3/18/18.
//  Copyright © 2018 Daval Cato. All rights reserved.
//

import UIKit

class PostsTableViewCell: UITableViewCell {
    
    //MARK: Entities do not have values in nil. An entity initializes itself if or if with some value even though the parameters are optional.
    
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postAuthorLabel: UILabel!
    @IBOutlet weak var numberOfCommentsLabel: UILabel!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
}

/**
 self.imgViewThumbnail.updateImage(withSource: thumbnailSourceValue, andId: idValue)
 
 lblTitle?.text = titleValue
 
 updateInfo(withCreatedUtc: createdUtcValue, authorValue: authorValue, andSubredditNamePrefixedValue: subredditNamePrefixedValue)
 
 lblCommentsCount?.text = "\(numCommentsValue) comentarios"
 }
 
 func updateInfo(withCreatedUtc createdUtcValue: Double,
 authorValue: String,
 andSubredditNamePrefixedValue subredditNamePrefixedValue: String) {
 let blackFont = [ NSAttributedStringKey.foregroundColor: UIColor.black ]
 let blueFont = [ NSAttributedStringKey.foregroundColor: UIColor.blue ]
 
 let firstStr: NSMutableAttributedString = NSMutableAttributedString(string:"Enviado \(Date().getFriedlyTime(fromUtc:createdUtcValue)) por ", attributes: blackFont)
 
 let secondStr: NSMutableAttributedString = NSMutableAttributedString(string: "\(authorValue) ", attributes: blueFont)
 
 let thirthStr: NSMutableAttributedString = NSMutableAttributedString(string: "\(subredditNamePrefixedValue))", attributes: blueFont)
 
 secondStr.append(NSAttributedString(string: "a "))
 secondStr.append(thirthStr)
 firstStr.append(secondStr)
 
 lblInfo?.attributedText = firstStr
 }
 }
 
 */
