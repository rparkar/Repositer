//
//  DownloadService.swift
//  Repositer-Rx
//
//  Created by Rehan Parkar on 2018-06-27.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage


class DownloadService {
    
    static let instnace = DownloadService()
    
    
    func downloadTrendingRepoDictionary(completion: @escaping (_ reposDictArray: [Dictionary<String, Any>]) -> ()) {
        
        var trendingReposArray = [Dictionary<String, Any>]()
        
        Alamofire.request(trendingRepoURL).responseJSON { (response) in
            
            guard let json = response.result.value as? Dictionary<String, AnyObject> else {return}
          
            guard let repoDictArray = json["items"] as? [Dictionary<String, Any>] else {return}
            
            for repoDict in repoDictArray {
                
                if trendingReposArray.count <= 9 {
                    
                    guard let name = repoDict["name"] as? String,
                        let description = repoDict["description"] as? String,
                        let numberOfForks = repoDict["forks_count"] as? Int,
                        let language = repoDict["language"] as? String,
                        let repoUrl = repoDict["html_url"] as? String,
                        let contributorsUrl = repoDict["contributors_url"] as? String,
                        let ownerDict = repoDict["owner"] as? Dictionary<String, AnyObject>,
                        let avatarUrl = ownerDict["avatar_url"] as? String else { break }
                    
                    let repoDictionary: Dictionary<String, Any> = ["name": name, "description": description, "forks_count":numberOfForks, "language": language, "repoUrl":repoUrl, "contributors_url": contributorsUrl, "avatar_url":avatarUrl]

                    trendingReposArray.append(repoDictionary)
                    
                } else {
                    break
                }
            }
            completion(trendingReposArray)
        }
    }
    
    
    func downloadTrendingRepos(completion: @escaping (_ reposArray: [Repo]) -> ()) {
        
        var reposArray = [Repo]()
        
        downloadTrendingRepoDictionary { (trendingReposDictArray) in
            
            for dict in trendingReposDictArray {
                
                self.downloadTrendingRepo(fromDict: dict, completion: { (returnedRepo) in
                   
                    if reposArray.count < 9 {
                        
                        reposArray.append(returnedRepo)
                        
                    } else {
                        
                        let sortedArray = reposArray.sorted(by: { (repoA, repoB) -> Bool in
                            
                            if repoA.numberOfForks > repoB.numberOfForks {
                                return true
                            } else {
                                return false
                            }
                        })
                        completion(sortedArray)
                    }
                })
            }
        }
    }
    
    func downloadTrendingRepo (fromDict dict: Dictionary<String, Any>, completion: @escaping (_ repo: Repo) -> ()) {
        
        let avatarUrl = dict["avatar_url"] as! String
        let contributorsUrl = dict["contributors_url"] as! String
        let name = dict["name"] as! String
        let description = dict["description"] as! String
        let numberOfForks = dict["forks_count"] as! Int
        let language = dict["language"] as! String
        //let numberOfContributers = dict[""] as! Int
        let repoUrl = dict["repoUrl"] as! String
        
        downloadImageFor(avatarUrl: avatarUrl) { (image) in
            self.downloadContributorsDataFor(contributorsUrl: contributorsUrl, completion: { (returnedContributions) in
                
                let repo = Repo(name: name, description: description, image: image, noOfForks: numberOfForks, language: language, noOfContributer: returnedContributions, repoUrl: repoUrl)
                completion(repo)
                
            })
        }
    }
    
    func downloadImageFor(avatarUrl: String, completion: @escaping (_ image: UIImage) -> () ) {
        
        Alamofire.request(avatarUrl).responseImage { (imageResponse) in
            
            guard let image = imageResponse.result.value else { return }
            completion(image)
        }
    }
    
    func downloadContributorsDataFor(contributorsUrl: String, completion: @escaping (_ contributors: Int) -> (Void) ) {
        
        Alamofire.request(contributorsUrl).responseJSON { (response) in
            
            guard let json = response.result.value as? [Dictionary<String, Any>] else { return }
            if !json.isEmpty {
                let contributions = json.count
                completion(contributions)
            }
        }
    }
}







