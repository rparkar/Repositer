//
//  Repo.swift
//  Repositer-Rx
//
//  Created by Rehan Parkar on 2018-06-26.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit

class Repo {
    
    public private (set) var name: String
    public private (set) var descripton: String
    public private (set) var image: UIImage
    public private (set) var numberOfForks: Int
    public private (set) var language : String
    public private (set) var numberOfContributers: Int
    public private (set) var repoUrl: String
    
    init(name: String, description: String, image: UIImage, noOfForks: Int, language: String, noOfContributer: Int, repoUrl: String ) {
        
        self.name = name
        self.descripton = description
        self.image = image
        self.numberOfForks = noOfForks
        self.language = language
        self.numberOfContributers = noOfContributer
        self.repoUrl = repoUrl
        
    }
}
