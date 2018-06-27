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
        
        Alamofire.request(trendingRepoURL).responseJSON { (response) in
            
            guard let json = response.result.value as? Dictionary<String, Any> else {return}
            print(json)
        }
        
    }
}
