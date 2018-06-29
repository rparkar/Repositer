//
//  SearchCell.swift
//  Repositer-Rx
//
//  Created by Rehan Parkar on 2018-06-28.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit

class SearchCell: UITableViewCell {

    //outlets
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoDescriptionLabel: UILabel!
    @IBOutlet weak var forkCountsLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var searchImage: UIImageView!
    
    //variables
    public private (set) var repoUrl: String?
    
    func configureCell(repo: Repo) {
        repoNameLabel.text = repo.name
        repoDescriptionLabel.text = repo.descripton
        forkCountsLabel.text = String(describing:repo.numberOfForks)
        languageLabel.text = repo.language
        repoUrl = repo.repoUrl
    }
    
        
    override func awakeFromNib() {
        super.awakeFromNib()

        backView.layer.cornerRadius = 15
        
    }

}
