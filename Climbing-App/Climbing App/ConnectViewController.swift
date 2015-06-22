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

        // Do any additional setup after loading the view.
        
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
        postOne.title = "I'm such a macho guy"
        postOne.author = "Justin Aschenbener"
        _posts.append(postOne)
        
        let post2 = Post()
        post2.title = "I'm a pansy"
        post2.author = "Jeremy Cox"
        _posts.append(post2)
        
        let post3 = Post()
        post3.title = "Xcode can suck it"
        post3.author = "Marissa Washington"
        _posts.append(post3)
        
        let post4 = Post()
        post4.title = "I have no idea"
        post4.author = "Molly Jones"
        _posts.append(post4)
        
        let post5 = Post()
        post5.title = "Documentation documentation documentation"
        post5.author = "MC Happer"
        _posts.append(post5)
        
        return _posts
    }
}

class PostCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
}