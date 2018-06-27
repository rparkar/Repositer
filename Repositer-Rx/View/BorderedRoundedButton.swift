//
//  BorderedRoundedButton.swift
//  Repositer-Rx
//
//  Created by Rehan Parkar on 2018-06-26.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit

class BorderedRoundedButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        layer.borderWidth = 3
        layer.cornerRadius = frame.height / 2
        layer.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0)
        
    }

}
