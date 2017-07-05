//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Claire Chen on 7/5/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

protocol ComposeViewControllerDelegate: class{
    func did(post: Tweet)
    
}

class ComposeViewController: UIViewController{

    
    //Variables
    weak var delegate: ComposeViewControllerDelegate?
    
    //Outlets
    @IBOutlet var composeTextView: UITextView!
    
    
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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
