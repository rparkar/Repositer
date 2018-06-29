//
//  TrendingRepoCell.swift
//  Repositer-Rx
//
//  Created by Rehan Parkar on 2018-06-26.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class TrendingRepoCell: UITableViewCell {
    
    //outlets
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var repoImageView: UIImageView!
    @IBOutlet weak var numberOfForksLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var noOfContributersLabel: UILabel!
    @IBOutlet weak var viewReadmeButton: BorderedRoundedButton!
    
    //varibales
    private var repoUrl: String?
    var disposeBag = DisposeBag()

    func configureCell(repo: Repo) {
        

        repoNameLabel.text = repo.name
        repoDescriptionLabel.text = repo.descripton
        repoImageView.image = repo.image
        numberOfForksLabel.text = String(describing: repo.numberOfForks)
        languageLabel.text = repo.language
        noOfContributersLabel.text = String(describing: repo.numberOfContributers)
        
        repoUrl = repo.repoUrl
        
        viewReadmeButton.rx.tap.subscribe(onNext: {
            self.window?.rootViewController?.presentSFSafariVCFor(url: self.repoUrl!)
        }).disposed(by: disposeBag)
        
    }
    
    override func layoutSubviews() {
        backView.layer.cornerRadius = 15
        backView.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        backView.layer.shadowOffset = CGSize(width: 0, height: 0)
        backView.layer.shadowOpacity = 0.25
        backView.layer.shadowRadius = 5.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
