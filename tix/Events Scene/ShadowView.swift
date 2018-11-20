//
//  ShadowView.swift
//  tix
//
//  Created by Jubril on 18/11/2018.
//  Copyright © 2018 Tix. All rights reserved.
//

import UIKit

class ShadowView: UIView {

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 5
        layer.borderWidth = 1.0
        layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.06).cgColor
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.07).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 1.0)
        layer.shadowRadius = 1
        layer.masksToBounds = false
        layer.shadowOpacity = 1.0
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
    }
}
