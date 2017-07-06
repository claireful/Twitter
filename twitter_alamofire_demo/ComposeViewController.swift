//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Claire Chen on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

protocol ComposeViewControllerDelegate: class{
    func did(post: Tweet)
    
}

class ComposeViewController: UIViewController, UITextViewDelegate{

    
    //Variables
    weak var delegate: ComposeViewControllerDelegate?
    
    //Outlets
    
    @IBOutlet var composeTextView: RSKPlaceholderTextView!
    
    @IBOutlet var countLabel: UILabel!

    @IBOutlet var tweetButton: UIButton!
    
    //Action
    
    
    @IBAction func onClose(_ sender: Any) {
        self.dismiss(animated: true) { 
            //lol do nothing because you close it, ask to save???
        }
    }
    
    @IBAction func didTapPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: composeTextView.text) { (tweet, error) in
            if let error = error {
                print("Error composing tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("successfully composed tweet!")
            }
        }
        self.dismiss(animated: true) { 
            //lmao did dismiss
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.composeTextView = RSKPlaceholderTextView(frame: CGRect(x: 16, y: 87, width: self.view.frame.width - (16*2), height: self.view.frame.height/3))
        self.composeTextView.placeholder = "What's happening?"
        
        self.view.addSubview(self.composeTextView)
        let initialCount = composeTextView.text!.characters.count
        countLabel.text = "\(initialCount)"
        
        composeTextView.becomeFirstResponder()
        composeTextView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func textViewDidChange(_ textView: UITextView) {
        countLabel.text = "\(140-composeTextView.text!.characters.count)"
        if (composeTextView.text!.characters.count > 140) {
            countLabel.textColor = UIColor.red
            self.tweetButton.titleLabel?.textColor = UIColor.lightGray
            //countLabel.text = "\(140-composeTextView.text!.characters.count)"
            self.tweetButton.isEnabled = false
            
        } else {
            countLabel.textColor = UIColor.darkGray
            self.tweetButton.isEnabled = true
            self.tweetButton.titleLabel?.textColor = UIColor(red: 0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    */
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
 */
    

}
