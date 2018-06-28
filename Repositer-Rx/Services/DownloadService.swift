//
//  DownloadService.swift
//  Repositer-Rx
//
//  Created by Rehan Parkar on 2018-06-27.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import Foundation
import Alamofire


class DownloadService {
    
    static let instnace = DownloadService()
    
    
    func downloadTrendingRepoDictionary(completion: @escaping (_ reposDictArray: [Dictionary<String, Any>]) -> ()) {
        
        var trendingReposArray = [Dictionary<String, Any>]()
        
        Alamofire.request(trendingRepoURL).responseJSON { (response) in
            
            guard let json = response.result.value as? Dictionary<String, Any> else {return}
          
            guard let repoDictArray = json["items"] as? [Dictionary<String, Any>] else {return}
            
            for repoDict in repoDictArray {
                
                if trendingReposArray.count <= 9 {
                    trendingReposArray.append(repoDict)
                } else {
                    break
                }
            }
            completion(trendingReposArray)
        }
    }
    
    
    func downloadTrendingRepos(completion: @escaping (_ reposArray: [Repo]) -> ()) {
        
        downloadTrendingRepoDictionary { (trendingReposDictArray) in
            
            var reposArray = [Repo]()
            
            for dict in trendingReposDictArray {
                //set up each property needed for instance of repo
                let repo = self.downloadTrendingRepo(fromDict: dict)
                reposArray.append(repo)
            }
            completion(reposArray)
        }
        
    }
    
    func downloadTrendingRepo (fromDict dict: Dictionary<String, Any>) -> Repo {
        
       // let avatarUrl = dict["avatar_url"] as! String
        let name = dict["name"] as! String
        let description = dict["description"] as! String
        let numberOfForks = dict["forks_count"] as! Int
        let language = dict["language"] as! String
        //let numberOfContributers = dict[""] as! Int
        let repoUrl = dict["html_url"] as! String
        
        
        let repo = Repo(name: name, description: description, image: UIImage(named: "searchIconLarge")!, noOfForks: numberOfForks, language: language, noOfContributer: 50, repoUrl: repoUrl)
        
        return repo
    }
}







