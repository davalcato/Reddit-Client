//
//  SinglePostVC.swift
//  Reddit Client
//
//  Created by Daval Cato on 3/18/18.
//  Copyright © 2018 Daval Cato. All rights reserved.
//

import UIKit

class SinglePostVC: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    var post: Post!
    var myViewController = ViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postImage.imageFromServerURL(urlString: post.thumbnameImage!, defaultImage: "NoImage")
        titleLabel.text = post.title
        authorLabel.text = "Author: " + post.author!
        commentLabel.text = "Comments: \(String(describing: post.sumofComments!))"
        let date = Date(timeIntervalSince1970: Double(post.postDate!))
        postDateLabel.text = "Posted Time: " + myViewController.timeAgoSinceDate(date)
    }
    
    @IBAction func saveImage(_ sender: Any) {
        let addPhotoAlert = UIAlertController(title: "Add Photo", message: "By Hitting Ok You Will Add This Thumbnail To Your Camera Roll. Select Cancel If You Do Not Want To Add This Photo To Your Camera Roll", preferredStyle: .alert)
        addPhotoAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            UIImageWriteToSavedPhotosAlbum(self.postImage.image!, nil, nil, nil)
            
        }))
        addPhotoAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(addPhotoAlert, animated: true, completion: nil)
    }
    
}
