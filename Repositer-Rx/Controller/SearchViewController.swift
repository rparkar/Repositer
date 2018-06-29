//
//  SearchViewController.swift
//  Repositer-Rx
//
//  Created by Rehan Parkar on 2018-06-26.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchViewController: UIViewController {

    //outlets
    @IBOutlet weak var searchTextField: RoundedBorderTextField!
    @IBOutlet weak var tableView: UITableView!
    
    //variables
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindElements()

    }
    
    func bindElements() {
        
        let searchResultsObservable: Observable<[Repo]>
        
        
        searchResultsObservable =  searchTextField.rx.text
            .orEmpty
            .debounce(0.5, scheduler: MainScheduler.instance)
            .map{
            
                $0.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlHostAllowed) ?? ""
            }.flatMap { (query) -> Observable<[Repo]> in
                
                if query == "" {
                    return Observable<[Repo]>.just([])
                } else {
                    let url = searchURL + query + starsDescendingSegment
                    var searchRepos = [Repo]()
                    
                    return URLSession.shared.rx.json(url: URL(string: url)!).map {
                        let results = $0 as AnyObject
                        let items = results.object(forKey: "items") as? [Dictionary<String, Any>] ?? []
                        
                        for item in items {
                            guard let name = item["name"] as? String,
                                let description = item["description"] as? String,
                                let langugae = item["language"] as? String,
                                let forksCount = item["forks_count"] as? Int,
                                let repoUrl = item["html_url"] as? String else { break }
                            
                            let repo = Repo(name: name, description: description, image: UIImage(named: "searchIconLarge")!, noOfForks: forksCount, language: langugae, noOfContributer: 0, repoUrl: repoUrl)
                            
                            searchRepos.append(repo)
                        }
                        return searchRepos
                    }
                }
                
        }.observeOn(MainScheduler.instance)
        
        searchResultsObservable.bind(to: tableView.rx.items(cellIdentifier: "searchCell")) {
            (row, repo: Repo, cell: SearchCell) in
            
            cell.configureCell(repo: repo)
        }.disposed(by: disposeBag)
        
    }

}






