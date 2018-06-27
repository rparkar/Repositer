//
//  TrendingViewController.swift
//  Repositer-Rx
//
//  Created by Rehan Parkar on 2018-06-26.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit

class TrendingViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self 
        tableView.reloadData()
        
        DownloadService.instnace.downloadTrendingRepoDictionary { (json) in
            print("done")
        }
        
    }


}



extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trendingRepoCell", for: indexPath) as? TrendingRepoCell else {return UITableViewCell()}
        
        let repo = Repo(name: "SWIFT", description: "Apples swift language", image: UIImage(named: "searchIconLarge")!, noOfForks: 342, language: "Swift", noOfContributer: 999, repoUrl: "www.apple.com")
        
        cell.configureCell(repo: repo)
        return cell
    }
    
}
