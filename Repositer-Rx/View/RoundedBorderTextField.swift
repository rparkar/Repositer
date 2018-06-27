//
//  RoundedBorderTextField.swift
//  Repositer-Rx
//
//  Created by Rehan Parkar on 2018-06-26.
//  Copyright © 2018 Rehan Parkar. All rights reserved.
//

import UIKit

class RoundedBorderTextField: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = frame.height / 2
        layer.borderWidth = 3
        layer.borderColor = #colorLiteral(red: 0.3442408442, green: 0.5524554849, blue: 0.9224796891, alpha: 1)
        layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        let placeholder = NSAttributedString(string: self.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.3442408442, green: 0.5524554849, blue: 0.9224796891, alpha: 1)])
        attributedPlaceholder = placeholder
    }

}
