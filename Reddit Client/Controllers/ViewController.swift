//
//  ViewController.swift
//  Reddit Client
//
//  Created by Daval Cato on 3/18/18.
//  Copyright © 2018 Daval Cato. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: IBOutlets
    @IBOutlet weak var postsTableView: UITableView!
    
    // MARK: Global Variablea
    var posts: [Post] = []
    var postsTableViewCell = PostsTableViewCell()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postsTableView.delegate = self
        postsTableView.dataSource = self
        
        DataServices.callAPI({ posts in
            self.posts = posts
            
            DispatchQueue.main.async {
                self.postsTableView.reloadData()
            }
        }) { (errorMessage) in
            print("An error occured \(errorMessage.debugDescription)")}
    }
    
    /**
 Given a UTC value it calculates the date information in friendly format:
 
 So many hours ago
 
 Many days ago
 
 So many years ago
     
*/
     
 /**
 func getFriedlyTime(fromUtc utc: Double) -> String {
 
 let dateUtc: Date = Date(timeIntervalSince1970: TimeInterval(utc))
 
 var timeText: String = "hace "
 
 let hoursSinceUtc: Double = Date().timeIntervalSince(dateUtc)/3600.0
 
 let daysInMonthRng: NSRange = NSCalendar(calendarIdentifier:NSCalendar.Identifier.gregorian)!.range(of: NSCalendar.Unit.day, in: NSCalendar.Unit.month, for: Date())
 
 let daysInMonth: Double = Double(daysInMonthRng.length)
 
 let dateFormatter: DateFormatter = DateFormatter()
 dateFormatter.dateFormat = "yyyy"
 
 var daysInYear: Double = 0
 
 let yearStr: String = dateFormatter.string(from: dateUtc)
 
 let yearInt: Int = Int(yearStr)!
 
 if yearInt % 400 == 0  {
 daysInYear = 366;
 } // Leap Year
 else if yearInt % 100 == 0 {
 daysInYear = 365; // Non Leap Year
 }
 else if yearInt % 4 == 0 {
 daysInYear = 366; // Leap Year
 }
 else { // Non-Leap Year
 daysInYear = 365;
 }
 
 */
    
    
    
    func timeAgoSinceDate(_ date: Date) -> String {
        let calendar = NSCalendar.current
        let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
        let now = Date()
        let earliest = now < date ? now : date
        let latest = (earliest == now) ? date : now
        let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
        
        if (components.year! >= 2) {
            return "\(components.year!) years ago"
        } else if (components.year! >= 1){
            return "Last year"
        } else if (components.month! >= 2) {
            return "\(components.month!) months ago"
        } else if (components.month! >= 1){
            return "Last month"
        } else if (components.weekOfYear! >= 2) {
            return "\(components.weekOfYear!) weeks ago"
        } else if (components.weekOfYear! >= 1){
            return "Last week"
        } else if (components.day! >= 2) {
            return "\(components.day!) days ago"
        } else if (components.day! >= 1){
            return "Yesterday"
        } else if (components.hour! >= 2) {
            return "\(components.hour!) hours ago"
        } else if (components.hour! >= 1){
            return "An hour ago"
        } else if (components.minute! >= 2) {
            return "\(components.minute!) minutes ago"
        } else if (components.minute! >= 1){
            return "A minute ago"
        } else if (components.second! >= 3) {
            return "\(components.second!) seconds ago"
        } else {
            return "Just now"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SinglePostSegue" {
            let vc = segue.destination as! SinglePostVC
            let post = sender as! Post
            vc.post = post
        }
    }
}

// MARK: UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = postsTableView.indexPathForSelectedRow
        let thePost: Post
        thePost = posts[(indexPath?.row)!]
        
        performSegue(withIdentifier: "SinglePostSegue", sender: thePost)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 175.0
    }
}

/**
 This function calls the Reddits service using a paging entity that is sent in the signature through Pag.
 
 The FinishedBlock function returns an array with Reddits
 
 */

/**
 class PaginationDAO: ParentDAO {
 
 init() {
 super.init(entity: String(describing: Pagination.self))
 }
 
 func getThePagination() -> (Pagination, State)  {
 let managedPaginations: [Pagination] = get(objectsWithPredicate: nil) as! [Pagination]
 
 if managedPaginations.count > 0 {
 return (managedPaginations[0], State.existent)
 }
 
 let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName:String(describing: Pagination.self), in: persistentContainer.viewContext)!
 
 let pag: Pagination = Pagination(entity: entity, insertInto: persistentContainer.viewContext)
 
 pag.lastId = ""
 
 self.syncSave()
 
 return (pag, State.new)
 }
 }
 
 */




// MARK: UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostsTableViewCell {
            let post = posts[indexPath.row]
            cell.postTitleLabel.text = post.title
            cell.postAuthorLabel.text = "Author: " + post.author!
            cell.numberOfCommentsLabel.text = "Comments: \(String(describing: post.sumofComments!))"
            cell.thumbnailImageView.imageFromServerURL(urlString: post.thumbnameImage!, defaultImage: "NoImage")
            
            let date = Date(timeIntervalSince1970: Double(post.postDate!))
            cell.createdAtLabel.text = "Posted Time: " + timeAgoSinceDate(date)
            
        }
        return PostsTableViewCell()
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        <#code#>
//    }
}

