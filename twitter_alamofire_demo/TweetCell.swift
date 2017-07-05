//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    //Variables
    
    //Outlets
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var handleTextLabel: UILabel!
    @IBOutlet var timeTextLabel: UILabel!
    @IBOutlet var usernameTextLabel: UILabel!
    @IBOutlet var retweetButton: UIButton!
    @IBOutlet var favButton: UIButton!
    
    //Action
    @IBAction func clickRetweet(_ sender: Any) {
        //if retweetButton.isSelected
        if retweetButton.isSelected == false {
            tweet.retweetCount += 1
            retweetButton.setTitle(String(tweet.retweetCount), for: .normal)
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweetingh tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
            
        } else {
            tweet.retweetCount -= 1
            retweetButton.setTitle(String(tweet.retweetCount), for: .normal)
        }
        retweetButton.isSelected = !retweetButton.isSelected
        tweet.retweeted = !tweet.retweeted
        
    }
    
    @IBAction func clickFav(_ sender: Any) {
        if favButton.isSelected == false {
            tweet.favoriteCount! += 1
            favButton.setTitle(String(tweet.favoriteCount!), for: .normal)
            APIManager.shared.favorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
        } else {
            tweet.favoriteCount! -= 1
            favButton.setTitle(String(tweet.favoriteCount!), for: .normal)
            APIManager.shared.unfavorite(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unfavoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unfavorited the following Tweet: \n\(tweet.text)")
                }
            }
        }
        
        favButton.isSelected = !favButton.isSelected
        tweet.favorited = !tweet.favorited!
    }
    
    
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            timeTextLabel.text = tweet.createdAtString
            usernameTextLabel.text = tweet.user.name
            handleTextLabel.text = tweet.user.screenName
                retweetButton.isSelected = tweet.retweeted
                favButton.isSelected = tweet.favorited!
            
            favButton.setTitle(String(tweet.favoriteCount!), for: .normal)
            
            retweetButton.setTitle(String(tweet.retweetCount), for: .normal)
            
            
            
            
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
