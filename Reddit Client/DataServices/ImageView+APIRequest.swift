//
//  ImageView+APIRequest.swift
//  Reddit Client
//
//  Created by Daval Cato on 3/18/18.
//  Copyright © 2018 Daval Cato. All rights reserved.
//

import UIKit

extension UIImageView {
    public func imageFromServerURL(urlString: String, defaultImage : String?) {
        if let myDefaultImage = defaultImage {
            self.image = UIImage(named: myDefaultImage)
        }
        
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error ?? "error")
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}
