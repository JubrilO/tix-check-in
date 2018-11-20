//
//  TixButton.swift
//  tix
//
//  Created by Jubril on 18/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//

import UIKit

class TixButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5
       backgroundColor = UIColor(red: 0.99, green: 0.39, blue: 0.21, alpha: 1.0)
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2.0)
        layer.shadowRadius = 1
        layer.masksToBounds = false
        layer.shadowOpacity = 1.0
    }
}
