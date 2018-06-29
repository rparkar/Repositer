//
//  UIViewController.swift
//  Repositer-Rx
//
//  Created by Rehan Parkar on 2018-06-28.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentSFSafariVCFor(url: String) {
        let readMeUrl = URL(string: url + readmeSegment)
        let safariVC = SFSafariViewController(url: readMeUrl!)
        
        present(safariVC, animated: true, completion: nil)
    }
}
