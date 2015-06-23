//
//  ConnectViewController.swift
//  Climbing App
//
//  Created by Min Hu on 6/12/15.
//  Copyright (c) 2015 Min Hu. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var connectTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connectTableView.rowHeight = UITableViewAutomaticDimension
        connectTableView.estimatedRowHeight = 126
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Post.posts.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell") as! PostCell
        cell.titleLabel.text = Post.posts[indexPath.row].title
        cell.authorLabel.text = Post.posts[indexPath.row].author
        cell.profpicView.image = UIImage(named: Post.posts[indexPath.row].photo!)
        return cell
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class Post {
    
    
    var author: String?
    var title: String?
    var photo: String?
    
    static var posts: [Post] {
        var _posts = [Post]()
        
        let postOne = Post()
        postOne.title = "Best outdoor crags for beginners"
        postOne.author = "ahonnold"
        postOne.photo = "prof-honnold-small"
        _posts.append(postOne)
        
        let post2 = Post()
        post2.title = "Women: Do you wear women’s climbing shoes?"
        post2.author = "sashadg"
        post2.photo = "prof-sasha-small"
        _posts.append(post2)
        
        let post3 = Post()
        post3.title = "Going to Bishop… who's in?"
        post3.author = "puccio"
        post3.photo = "prof-puccio-small"
        _posts.append(post3)
        
        let post4 = Post()
        post4.title = "Deep-water solo in Thailand"
        post4.author = "cragman"
        post4.photo = "prof-puccio-small"
        _posts.append(post4)
        
        let post5 = Post()
        post5.title = "Best bouldering in Bay Area?"
        post5.author = "cscharma"
        post5.photo = "prof-puccio-small"
        _posts.append(post5)
        
        return _posts
    }
}

class PostCell: UITableViewCell {
    
    @IBOutlet weak var profpicView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
}