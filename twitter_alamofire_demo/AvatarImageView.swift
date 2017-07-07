//
//  AvatarImageView.swift
//  twitter_alamofire_demo
//
//  Created by Claire Chen on 7/7/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation
import UIKit

class AvatarImageView: UIImageView {
    
    override func awakeFromNib() {
        self.layer.cornerRadius = 10.0
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 3.0
    }
}
