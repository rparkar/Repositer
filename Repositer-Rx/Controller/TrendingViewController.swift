//
//  TrendingViewController.swift
//  Repositer-Rx
//
//  Created by Rehan Parkar on 2018-06-26.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TrendingViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var tableView: UITableView!
    
    //variables
    var disposeBag = DisposeBag()
    var dataSource = PublishSubject<[Repo]>()
    let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.refreshControl = refreshControl
        refreshControl.tintColor = #colorLiteral(red: 0.3442408442, green: 0.5524554849, blue: 0.9224796891, alpha: 1)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching github repos", attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.3442408442, green: 0.5524554849, blue: 0.9224796891, alpha: 1), NSAttributedStringKey.font: UIFont(name: "AvenirNext-DemiBold", size: 17.0)!])
        refreshControl.addTarget(self, action: #selector(fetchData), for: .valueChanged)
        
        fetchData()
        dataSource.bind(to: tableView.rx.items(cellIdentifier: "trendingRepoCell")) { (row, repo: Repo, cell: TrendingRepoCell) in
            
            cell.configureCell(repo: repo)
            
        }.disposed(by: disposeBag)
        
        
//        tableView.dataSource = self
//        tableView.delegate = self
//        tableView.reloadData()
        
//        DownloadService.instnace.downloadTrendingRepos { (repoArray) in
//
//            print(repoArray[0].name)
//            print(repoArray[1].name)
        
//        }
        
    }
    
    @objc func fetchData() {
        DownloadService.instnace.downloadTrendingRepos { (trendingReposArray) in
            
            self.dataSource.onNext(trendingReposArray)
            self.refreshControl.endRefreshing()
        }
    }


}


//
//extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trendingRepoCell", for: indexPath) as? TrendingRepoCell else {return UITableViewCell()}
//
//        let repo = Repo(name: "SWIFT", description: "Apples swift language", image: UIImage(named: "searchIconLarge")!, noOfForks: 342, language: "Swift", noOfContributer: 999, repoUrl: "www.apple.com")
//
//        cell.configureCell(repo: repo)
//        return cell
//    }

//}
