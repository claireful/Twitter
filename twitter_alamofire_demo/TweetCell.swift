//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import AlamofireImage

protocol TweetCellDelegate: class {
    // TODO: Add required methods the delegate needs to implement
    func tweetCell(_ tweetCell: TweetCell, didTap user: User)
}

class TweetCell: UITableViewCell {
    
    //Variables
    weak var delegate: TweetCellDelegate?
    
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
            print("hi")
            retweetButton.setTitle(String(tweet.retweetCount), for: .normal)
            print("ok")
            APIManager.shared.retweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
            print("hey")
            
        } else {
            tweet.retweetCount -= 1
            retweetButton.setTitle(String(tweet.retweetCount), for: .normal)
            APIManager.shared.unretweet(tweet) { (tweet: Tweet?, error: Error?) in
                if let  error = error {
                    print("Error unretweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully unretweeted the following Tweet: \n\(tweet.text)")
                }
            }
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
            let profURL = URL(string: tweet.user.profilePicString!)
            profileImageView.af_setImage(withURL: profURL!)
            //make circular image
            profileImageView.layer.masksToBounds = false
            profileImageView.layer.cornerRadius = profileImageView.frame.height/2
            profileImageView.clipsToBounds = true
            handleTextLabel.text = "@\(tweet.user.screenName!)"
                retweetButton.isSelected = tweet.retweeted
                favButton.isSelected = tweet.favorited!
            
            favButton.setTitle(String(tweet.favoriteCount!), for: .normal)
            retweetButton.setTitle(String(tweet.retweetCount), for: .normal)
            
        }
    }
    
    func didTapUserProfile(_ sender: UITapGestureRecognizer) {
        //call method on delegate
        delegate?.tweetCell(self, didTap: tweet.user)
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let profileTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.didTapUserProfile(_:)))
        profileImageView.addGestureRecognizer(profileTapGestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
